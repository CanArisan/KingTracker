//
//  AddRoundView.swift
//  KingTracker
//
//  Created by Can Arışan on 02.01.20.
//  Copyright © 2020 Can Arisan. All rights reserved.
//

import SwiftUI

struct AddRoundView: View {
    @EnvironmentObject var model: Model
    @Environment(\.presentationMode) private var presentationMode
    
    @State var selection: Round.Selection = .undefined
    @State var caller: Int = 0
    @State var player1Takes: String = ""
    @State var player2Takes: String = ""
    @State var player3Takes: String = ""
    @State var player4Takes: String = ""
    
    @State var roundId: Int = 0
    var gameId: Int
    
    var game: Game {
        return model.game(gameId)!
    }
    
    var roundOptional: Round? {
        return game.rounds.first(where: {$0.id == roundId})
    }
    
    private var saveButton: some View {
        Button(action: save) {
            Text("Save")
        }
        .disabled(
            !game.players[caller].isSelectionValid(selection)
                || roundOptional == nil
                || getRoundTotalTakes() != Round.getCountOfTakes(selection)
                || selection == .undefined ? true :
                selection == .koz ? game.roundCounts[selection]! >= 8 : game.roundCounts[selection]! >= 2
        )
    }
    
    var body: some View {
        VStack{
            Form {
                Section(header: Text("Caller")) {
                    Picker("", selection: $caller) {
                        ForEach(0...3, id: \.self) { index in
                            Text(self.game.players[index].name)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Game Selection")) {
                    Picker("", selection: $selection) {
                        ForEach(
                            Round.Selection.allCases.filter{ select in
                                if select == .undefined {
                                    return false
                                } else if select == .koz {
                                    return game.roundCounts[select]! < 8
                                } else {
                                    return game.roundCounts[select]! < 2
                                }
                            },
                            id: \.self
                        ) { selection in
                            Text(selection.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Take count")) {
                    TextField("\(game.players[0].name)", text: $player1Takes).keyboardType(.numberPad)
                    TextField("\(game.players[1].name)", text: $player2Takes).keyboardType(.numberPad)
                    TextField("\(game.players[2].name)", text: $player3Takes).keyboardType(.numberPad)
                    TextField("\(game.players[3].name)", text: $player4Takes).keyboardType(.numberPad)
                }
                
                Section{
                    saveButton
                }
            }
                //        .navigationBarItems(trailing: saveButton)
                .onAppear{
                    while self.game.rounds[self.roundId].selection != .undefined {
                        self.roundId += 1
                    }
                    self.roundId += 1
                    
            }
            .modifier(ResignKeyboardOnDragGesture())
        }
    }
    
    func getRoundTotalTakes() -> Int {
        let a = Int(player1Takes) ?? 0
        let b = Int(player2Takes) ?? 0
        let c = Int(player3Takes) ?? 0
        let d = Int(player4Takes) ?? 0
        return a + b + c + d
    }
    
    private func save() {
        let round = Round(
            id: roundId,
            selection: selection,
            caller: caller
        )
        round.playerTakes[game.players[0].id] = Int(player1Takes)
        round.playerTakes[game.players[1].id] = Int(player2Takes)
        round.playerTakes[game.players[2].id] = Int(player3Takes)
        round.playerTakes[game.players[3].id] = Int(player4Takes)
        game.players[0].pts += round.playerPts[game.players[0].id] ?? 0
        game.players[1].pts += round.playerPts[game.players[1].id] ?? 0
        game.players[2].pts += round.playerPts[game.players[2].id] ?? 0
        game.players[3].pts += round.playerPts[game.players[3].id] ?? 0
        game.rounds[roundId - 1] = round
        
        game.players[caller].incrementSelection(selection)
        game.roundCounts[selection] = 1 + (game.roundCounts[selection] ?? 0)
        model.save(game)
        
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddRoundView_Previews: PreviewProvider {
    static var previews: some View {
        AddRoundView(gameId: 1).environmentObject(Model.mock)
    }
}
