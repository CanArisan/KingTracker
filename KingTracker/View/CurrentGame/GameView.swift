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
                    HStack(alignment: .center, spacing: 0) {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Winners:")
                                .font(.title)
                                .padding(.bottom, 5)
                            ForEach(game.players
                                .sorted(by: {$0.pts > $1.pts})
                                .filter{ $0.pts >= 0 }
                            ) { player in
                                Text("\(player.name)")
                                    .padding([.bottom, .leading], 7)
                            }
                        }
                        .padding(.horizontal, 15)
                        Spacer()
                        NavigationLink(destination: NewGameView()) {
                            Text(" Create a new game ")
                                .padding()
                                .foregroundColor(.black)
                                .background(RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(Color("CompletedGame")))
                        }
                        .padding(.trailing, 25)
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
