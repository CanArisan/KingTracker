//
//  Round.swift
//  KingTracker
//
//  Created by Can Arışan on 22.12.19.
//  Copyright © 2019 Can Arisan. All rights reserved.
//

import Foundation

public class Round: Codable, Identifiable {
    
    public let id: Int
    public var selection: Selection
    public var playerTakes: [Int:Int] // [PlayerId: Take Count]
    public var caller: Int // Caller player index (0 to 3)
    
    public var playerPts: [Int:Int] {
        return playerTakes.mapValues {
            $0 * getPtsForEachTake()
        }
    }
    
    public enum Selection: String, Codable, CaseIterable {
        case koz = "Koz"
        case elAlmaz = "El"
        case kupaAlmaz = "Kupa"
        case erkekAlmaz = "Erkek"
        case kizAlmaz = "Kiz"
        case son2 = "Son 2"
        case rifki = "Rifki"
        case undefined = " - "
    }
    
    init(id: Int, selection: Selection, playerTakes: [Int:Int]? = nil, caller: Int? = nil) {
        self.id = id
        self.selection = selection
        self.playerTakes = playerTakes ?? [:]
        self.caller = caller ?? 0
    }
    
    static func getCountOfTakes(_ selection: Selection) -> Int {
        switch selection {
        case .undefined:
            return 0
        case .rifki:
            return 1
        case .son2:
            return 2
        case .kizAlmaz:
            return 4
        case .erkekAlmaz:
            return 8
        default:
            return 13
        }
    }
    
    func getPtsForEachTake() -> Int {
        switch self.selection {
        case .undefined:
            return 0
        case .rifki:
            return -320
        case .son2:
            return -180
        case .kizAlmaz:
            return -100
        case .erkekAlmaz:
            return -60
        case .elAlmaz:
            return -50
        case .kupaAlmaz:
            return -30
        case .koz:
            return 50
        }
    }
}
