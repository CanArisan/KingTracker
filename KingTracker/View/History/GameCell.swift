//
//  GameCell.swift
//  KingTracker
//
//  Created by Can Arışan on 30.12.19.
//  Copyright © 2019 Can Arisan. All rights reserved.
//

import SwiftUI

struct GameCell: View {
    @EnvironmentObject var model: Model
    
    var gameId: Game.ID
    
    var game: Game {
        model.game(gameId)!
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            HStack {
                Text("Game \(gameId)")
                    .font(.title)
                Spacer()
                Text("\(game.dateDescription)")
                    .font(.headline)
            }
            HStack {
                VStack {
                    Text("\(game.players[0].name)")
                    Text("\(game.players[0].pts)")
                }
                .padding()
                Spacer()
                    .frame(
                        width: 15,
                        height: 25,
                        alignment: .center
                    )
                VStack {
                    Text("\(game.players[1].name)")
                    Text("\(game.players[1].pts)")
                }
                .padding()
                Spacer()
                    .frame(
                        width: 15,
                        height: 25,
                        alignment: .center
                    )
                VStack {
                    Text("\(game.players[2].name)")
                    Text("\(game.players[2].pts)")
                }
                    .padding()
                Spacer()
                    .frame(
                        width: 15,
                        height: 25,
                        alignment: .center
                    )
                VStack {
                    Text("\(game.players[3].name)")
                    Text("\(game.players[3].pts)")
                }
                    .padding()
            }
            .fixedSize()
        }
        .padding()
        .foregroundColor(.black)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(
                    game.completed ? Color("CompletedGame") : (
                        game.id == model.games.last!.id ? Color("CurrentGame") : Color("UnfinishedGame")
                    )
                )
        )
        .padding(.horizontal, 10)
    }
}

struct GameCell_Previews: PreviewProvider {
    static var previews: some View {
        GameCell(gameId: 1).environmentObject(Model.mock)
    }
}
