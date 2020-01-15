//
//  GameView.swift
//  KingTracker
//
//  Created by Can Arışan on 22.12.19.
//  Copyright © 2019 Can Arisan. All rights reserved.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var model: Model
    
    @State var presentRoundSheet = false
    
    var gameId: Game.ID
    
    var game: Game {
        model.game(gameId)!
    }
    
    private var addButton: some View {
        Button(action: {self.presentRoundSheet = true}) {
            Image(systemName: "plus.app.fill")
                .resizable()
                .frame(width: 25, height: 25, alignment: .center)
                .accentColor(.black)
        }
        .disabled(game.completed)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TitleBar()
                
                HStack(alignment: .center, spacing: 0) {
                    addButton
                        .padding(.leading, 15)
                    Spacer()
                    ForEach(game.players) { player in
                        Spacer().frame(width: 20, height: 10, alignment: .center)
                        PlayerCell(player: player)
                    }
                }
                .padding(.trailing, 5)
                
                ScrollView {
                    ForEach(1...20, id: \.self) { index in
                        NavigationLink(destination: EditRoundView(roundId: index, gameId: self.gameId)) {
                            RoundCell(roundId: index, gameId: self.gameId)
                        }
                    }
                }
                
                if self.game.completed {
                    HStack(alignment: .center, spacing: 10) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Winners:")
                                .font(.title)
                            ForEach(game.players) { player in
                                if player.pts >= 0 {
                                    Text("\(player.name) \(player.pts)")
                                }
                            }
                        }
                        NavigationLink(destination: NewGameView()) {
                            Text("Create a new game")
                        }
                    }
                }
            }
            .padding(.top, 12)
            .background(Rectangle().foregroundColor(Color("Cuha")))
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .sheet(isPresented: $presentRoundSheet) {
                NavigationView {
                    AddRoundView(roundId: 0, gameId: self.gameId)
                }.environmentObject(self.model)
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(gameId: 1).environmentObject(Model.mock)
    }
}
