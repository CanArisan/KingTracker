//
//  Model.swift
//  KingTracker
//
//  Created by Can Arışan on 22.12.19.
//  Copyright © 2019 Can Arisan. All rights reserved.
//

import Foundation
import Combine

// MARK: - Model
/// Contains all persistent data and handles storing and loading.
public class Model {
    
    // MARK: Stored Instance Properties
    @Published public private(set) var players: [Player] {
        didSet {
            players.saveToFile()
        }
    }
    @Published public private(set) var games: [Game] {
        didSet {
            games.saveToFile()
        }
    }
    
    // MARK: Initializer
    public init(players: [Player]? = nil, games: [Game]? = nil) {
        self.players = players ?? Player.loadFromFile()
        self.games = games ?? Game.loadFromFile()
    }
    
    // MARK: Instance Methods
    public func player(_ id: Player.ID?) -> Player? {
        players.first(where: { $0.id == id })
    }
    
    public func game(_ id: Game.ID?) -> Game? {
        games.first(where: { $0.id == id })
    }
    
    public func save(_ player: Player) {
        delete(player: player.id)
        players.append(player)
        players.sort()
    }
    
    public func save(_ game: Game) {
        delete(game: game.id)
        games.append(game)
        games.sort()
    }
    
    public func delete(player id: Player.ID) {
        players.removeAll(where: { $0.id == id })
    }
    
    public func delete(game id: Game.ID) {
        games.removeAll(where: { $0.id == id })
    }
    
    public func nextPlayerId() -> Int {
        return 1 + (players.last?.id ?? 0)
    }
    
    public func nextGameId() -> Int {
        return 1 + (games.last?.id ?? 0)
    }
    
    public func hasUncompletedGame() -> Bool {
        return self.games.contains(where: {!$0.completed})
    }
    
    public func getCurrentGame() -> Game? {
        return self.games.last(where: {!$0.completed})
    }
}

// MARK: Extension: Model: ObservableObject
extension Model: ObservableObject { }

// MARK: Extension: Model
#if DEBUG
extension Model {
    
    // MARK: Stored Type Properties
    /**
     Mock data to enable working with the preview.
     */
    public static var mock: Model {
        var players: [Player] = []
        
        for i in 1...4 {
            players.append(Player(id: i, name: "Pl \(i)", pts: 0, kozCount: 0, cezaCount: 0))
        }
        
        let games = [Game(id: 1, players: players)]
        
        // Create a model with data
        let mock = Model(players: players, games: games)
        
        return mock
    }
}
#endif
