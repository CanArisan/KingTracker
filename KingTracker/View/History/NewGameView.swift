//
//  NewGameView.swift
//  KingTracker
//
//  Created by Can Arışan on 26.12.19.
//  Copyright © 2019 Can Arisan. All rights reserved.
//

import SwiftUI

struct NewGameView: View {
    @EnvironmentObject var model: Model
    
    @State var player1 = ""
    @State var player2 = ""
    @State var player3 = ""
    @State var player4 = ""
    
    private var saveButton: some View {
        Button(action: save) {
            Text("Save")
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Game")) {
                    Text("Coming in a future update...")
                }
                if !self.model.players.isEmpty &&
                    (self.player1 == "" || self.player2 == "" || self.player3 == "" || self.player4 == "") {
                    Section(header: Text("Choose existing player")) {
                        Picker(
                            "",
                            selection: self.player1 == "" ? $player1 :
                                (self.player2 == "" ? $player2 :
                                    (self.player3 == "" ? $player3 : $player4))
                        ) {
                            ForEach(model.players.map({$0.name}), id: \.self) { player in
                                Text(player)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                    }
                }
                Section(header: Text("Players")) {
                    TextField("Player 1", text: $player1)
                    TextField("Player 2", text: $player2)
                    TextField("Player 3", text: $player3)
                    TextField("Player 4", text: $player4)
                }
                saveButton
            }
        }
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
    
    private func save() {
        var player1: Player
        var player2: Player
        var player3: Player
        var player4: Player
        
        if !model.players.map({$0.name}).contains(self.player1) {
            player1 = Player(id: model.nextPlayerId(), name: self.player1, pts: 0, kozCount: 0, cezaCount: 0)
            model.save(player1)
        } else {
            player1 = model.players.first(where: {$0.name == self.player1})!
        }
        
        if !model.players.map({$0.name}).contains(self.player2) {
            player2 = Player(id: model.nextPlayerId(), name: self.player2, pts: 0, kozCount: 0, cezaCount: 0)
            model.save(player2)
        } else {
            player2 = model.players.first(where: {$0.name == self.player2})!
        }
        
        if !model.players.map({$0.name}).contains(self.player3) {
            player3 = Player(id: model.nextPlayerId(), name: self.player3, pts: 0, kozCount: 0, cezaCount: 0)
            model.save(player3)
        } else {
            player3 = model.players.first(where: {$0.name == self.player3})!
        }
        
        if !model.players.map({$0.name}).contains(self.player4) {
            player4 = Player(id: model.nextPlayerId(), name: self.player4, pts: 0, kozCount: 0, cezaCount: 0)
            model.save(player4)
        } else {
            player4 = model.players.first(where: {$0.name == self.player4})!
        }
        
        model.save(Game(id: model.nextGameId(), players: [player1, player2, player3, player4]))
    }
}

struct NewGameView_Previews: PreviewProvider {
    static var previews: some View {
        NewGameView().environmentObject(Model.mock)
    }
}
