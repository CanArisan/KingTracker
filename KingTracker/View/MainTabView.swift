//
//  TabView.swift
//  KingTracker
//
//  Created by Can Arışan on 25.12.19.
//  Copyright © 2019 Can Arisan. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var model: Model
    
    var body: some View {
        TabView {
            if model.hasUncompletedGame()  {
                GameView(gameId: model.getCurrentGame()!.id)
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("Current Game")
                }
            } else {
                NewGameView()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("Current Game")
                }
            }
            HistoryList()
                .tabItem {
                    Image(systemName: "tray.2")
                    Text("History")
            }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView().environmentObject(Model.mock)
    }
}
