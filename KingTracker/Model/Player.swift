//
//  Player.swift
//  KingTracker
//
//  Created by Can Arışan on 22.12.19.
//  Copyright © 2019 Can Arisan. All rights reserved.
//

import Foundation

public class Player: Codable, Identifiable {
    
    public let id: Int
    public var name: String
    public var totalPts: Int
    public var pts: Int
    public var kozCount: Int
    public var cezaCount: Int
    
    init(id: Int, name: String, pts: Int, totalPts: Int? = nil, kozCount: Int, cezaCount: Int) {
        self.id = id
        self.name = name
        self.pts = pts
        self.totalPts = totalPts ?? pts
        self.kozCount = kozCount
        self.cezaCount = cezaCount
    }
    
    func setName(name: String) {
        self.name = name
    }
    
    func isSelectionValid(_ selection: Round.Selection) -> Bool {
        if selection == .undefined {
            return false
        } else if selection == .koz {
            return self.kozCount < 2
        } else {
            return self.cezaCount < 3
        }
    }
    
    func incrementSelection(_ selection: Round.Selection) {
        guard selection != .undefined else {
            return
        }
        
        if selection == .koz {
            guard kozCount < 2 else {
                return
            }
            kozCount += 1
        } else {
            guard cezaCount < 3 else {
                return
            }
            cezaCount += 1
        }
    }
    
    func decrementSelection(_ selection: Round.Selection) {
        guard selection != .undefined else {
            return
        }
        
        if selection == .koz {
            guard kozCount > 0 else {
                return
            }
            kozCount -= 1
        } else {
            guard cezaCount > 0 else {
                return
            }
            cezaCount -= 1
        }
    }
}

extension Player: LocalFileStorable {
    static var fileName = "Players"
}

extension Player: Equatable {
    public static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Player: Comparable {
    public static func < (lhs: Player, rhs: Player) -> Bool {
        return lhs.id < rhs.id
    }
}

extension Player: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
