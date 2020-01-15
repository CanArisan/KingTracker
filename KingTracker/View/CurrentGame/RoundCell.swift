//
//  RoundCell.swift
//  KingTracker
//
//  Created by Can Arışan on 22.12.19.
//  Copyright © 2019 Can Arisan. All rights reserved.
//

import SwiftUI

struct RoundCell: View {
    @EnvironmentObject var model: Model
    
    var roundId: Round.ID
    var gameId: Game.ID
    
    var game: Game {
        model.game(gameId)!
    }
    
    var round: Round {
        game.rounds[roundId - 1]
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 5) {
            Text("\(roundId). \(round.selection.rawValue)")
            Spacer()
            HStack {
                Text("\(round.playerPts[game.players[0].id] ?? 0)")
                    .frame(
                        width: 40,
                        height: 25,
                        alignment: .center)
                Spacer()
                    .frame(
                        width: 40,
                        height: 25,
                        alignment: .center
                )
                Text("\(round.playerPts[game.players[1].id] ?? 0)")
                    .frame(
                        width: 40,
                        height: 25,
                        alignment: .center)
                Spacer()
                    .frame(
                        width: 40,
                        height: 25,
                        alignment: .center
                )
                Text("\(round.playerPts[game.players[2].id] ?? 0)")
                    .frame(
                        width: 40,
                        height: 25,
                        alignment: .center)
                Spacer()
                    .frame(
                        width: 40,
                        height: 25,
                        alignment: .center
                )
                Text("\(round.playerPts[game.players[3].id] ?? 0)")
                    .frame(
                        width: 40,
                        height: 25,
                        alignment: .center)
            }
            .fixedSize()
        }
        .padding()
        .foregroundColor(.black)
        .background(Rectangle().foregroundColor(backgroundColor(round: round)))
    }
}

func backgroundColor(round: Round) -> Color {
    switch round.selection {
    case .koz:
        return Color("Pos")
    case .undefined:
        return Color("Cuha")
    default:
        return Color("Neg")
    }
}

func numberOfDigits(_ number: Int?) -> Int {
    guard let number = number else {
        return 0
    }
    if number > 99 {
        return 3
    } else if number > 9 {
        return 2
    } else {
        return 1
    }
}

func computeFrameWidth(_ offset: Int?, second: Int? = nil) -> CGFloat {
    return CGFloat(integerLiteral: 50 - numberOfDigits(offset) * 10 - numberOfDigits(second) * 10 )
}

struct RoundCell_Previews: PreviewProvider {
    static var previews: some View {
        RoundCell(roundId: 1, gameId: 1)
            .environmentObject(Model.mock)
            .previewLayout(.sizeThatFits)
    }
}
