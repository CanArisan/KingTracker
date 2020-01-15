//
//  ContentView.swift
//  KingTracker
//
//  Created by Can Arışan on 22.12.19.
//  Copyright © 2019 Can Arisan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    @State private var gameId = 1
 
    var body: some View {
        TabView(selection: $selection){
            GameView(gameId: gameId)
                .tag(0)
                
            EditRoundView(caller: 0, roundId: 0, gameId: gameId)
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
