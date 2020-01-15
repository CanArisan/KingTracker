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
                        ForEach(model.games) { game in
                            NavigationLink(destination: GameView(gameId: game.id)) {
                                GameCell(gameId: game.id)
                                .padding()
                            }
                        }
                    }
                }
            .padding(.top, 12)
            .background(Rectangle().foregroundColor(Color("Cuha")))
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct HistoryList_Previews: PreviewProvider {
    static var previews: some View {
        HistoryList().environmentObject(Model.mock)
    }
}
