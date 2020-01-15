//
//  Game.swift
//  KingTracker
//
//  Created by Can Arışan on 22.12.19.
//  Copyright © 2019 Can Arisan. All rights reserved.
//

import Foundation

public class Game: Codable, Identifiable {
    
    public let id: Int
    public var players: [Player]
    public var rounds: [Round]
    public var roundCounts: [Round.Selection: Int]
    private var date: Date
    
    public var completed: Bool {
        for round in self.rounds {
            if round.selection == .undefined {
                return false
            }
        }
        return true
    }
    
    public var dateDescription: String {
        let day = Calendar.current.component(.day, from: date)
        let month = Calendar.current.component(.month, from: date)
        let year = Calendar.current.component(.year, from: date)
        return "\(day).\(month).\(year)"
    }
    
    init(id: Int, players: [Player], date: Date? = nil) {
        self.id = id
        self.players = players
        self.date = date ?? Date()
        
        rounds = []
        for id in 1...20 {
            rounds.append(Round(id: id, selection: .undefined))
        }
        
        roundCounts = [:]
        Round.Selection.allCases.forEach {
            guard $0 != Round.Selection.undefined else {
                return
            }
            roundCounts[$0] = 0
        }
    }
}

extension Game: LocalFileStorable {
    static var fileName = "Games"
}

extension Game: Comparable {
    public static func < (lhs: Game, rhs: Game) -> Bool {
        return lhs.id < rhs.id
    }
    
    public static func == (lhs: Game, rhs: Game) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Game: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
