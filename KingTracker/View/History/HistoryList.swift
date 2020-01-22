//
//  HistoryList.swift
//  KingTracker
//
//  Created by Can Arışan on 30.12.19.
//  Copyright © 2019 Can Arisan. All rights reserved.
//

import SwiftUI

struct HistoryList: View {
    @EnvironmentObject var model: Model
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center, spacing: 10) {
                TitleBar()
                Text("Game History")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.black)
                ScrollView {
                    ForEach(model.games.reversed()) { game in
                        Button(action: {
                            self.setCurrentGame(game: game)
                        }){
                            GameCell(gameId: game.id)
                            .padding()
                        }
                    }
                }
                NavigationLink(destination: NewGameView()) {
                    Text("Create a new game")
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(.white))
                        .padding(.vertical, 8)
                }
            }
            .padding(.top, 12)
            .background(Rectangle().foregroundColor(Color("Cuha")))
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
    
    private func setCurrentGame(game: Game) {
        guard let currentGame = self.model.getCurrentGame() else {
            // Should not be entered
            print("No active game")
            return
        }
        
        let tempId = game.id
        game.id = currentGame.id
        currentGame.id = tempId
        model.save(game)
        model.save(currentGame)
    }
}

struct HistoryList_Previews: PreviewProvider {
    static var previews: some View {
        HistoryList().environmentObject(Model.mock)
    }
}
