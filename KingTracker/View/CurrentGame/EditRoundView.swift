//
//  SelectionPickerView.swift
//  KingTracker
//
//  Created by Can Arışan on 22.12.19.
//  Copyright © 2019 Can Arisan. All rights reserved.
//

import SwiftUI

struct EditRoundView: View {
    @EnvironmentObject var model: Model
    @Environment(\.presentationMode) private var presentationMode
    
    @State var selection: Round.Selection = .undefined
    @State var caller: Int = 0
    @State var player1Takes: String = ""
    @State var player2Takes: String = ""
    @State var player3Takes: String = ""
    @State var player4Takes: String = ""
    
    @State var oldRound: Round = Round(id: -1, selection: .undefined)
    
    @State var isSaving: Bool = false
    
    var roundId: Int
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
    
    private var deleteButton: some View {
        Button(action: delete) {
            Text("Delete")
        }
        .disabled(roundOptional == nil || selection == .undefined)
        .foregroundColor(.red)
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
                            Round.Selection.allCases.filter({ select in
                                if select == .undefined {
                                    return false
                                } else if select == .koz {
                                    return game.roundCounts[select]! < 8
                                } else {
                                    return game.roundCounts[select]! < 2
                                }
                            }),
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
                    deleteButton
                }
            }
            .onAppear{
                self.updateStates()
                self.isSaving = false
                
                // Revert old changes
                self.game.players[self.caller].decrementSelection(self.oldRound.selection)
                self.game.roundCounts[self.oldRound.selection] = (self.game.roundCounts[self.oldRound.selection] ?? 1) - 1
                self.game.players[0].pts -= self.oldRound.playerPts[self.game.players[0].id] ?? 0
                self.game.players[1].pts -= self.oldRound.playerPts[self.game.players[1].id] ?? 0
                self.game.players[2].pts -= self.oldRound.playerPts[self.game.players[2].id] ?? 0
                self.game.players[3].pts -= self.oldRound.playerPts[self.game.players[3].id] ?? 0
            }
            .onDisappear{
                if !self.isSaving {
                    // Load old changes back
                    self.game.players[self.caller].incrementSelection(self.oldRound.selection)
                    self.game.roundCounts[self.oldRound.selection] = (self.game.roundCounts[self.oldRound.selection] ?? 0) + 1
                    self.game.players[0].pts += self.oldRound.playerPts[self.game.players[0].id] ?? 0
                    self.game.players[1].pts += self.oldRound.playerPts[self.game.players[1].id] ?? 0
                    self.game.players[2].pts += self.oldRound.playerPts[self.game.players[2].id] ?? 0
                    self.game.players[3].pts += self.oldRound.playerPts[self.game.players[3].id] ?? 0
                }
                self.isSaving = false
            }
            .modifier(ResignKeyboardOnDragGesture())
        }
    .navigationBarTitle("")
    .navigationBarHidden(true)
//        .navigationBarItems(trailing: saveButton)
    }
    
    private func getRoundTotalTakes() -> Int {
        let a = Int(player1Takes) ?? 0
        let b = Int(player2Takes) ?? 0
        let c = Int(player3Takes) ?? 0
        let d = Int(player4Takes) ?? 0
        return a + b + c + d
    }
    
    private func updateStates() {
        guard let roundUnwrapped = roundOptional else {
            return
        }
        
        oldRound = roundUnwrapped
        
        caller = oldRound.caller
        selection = oldRound.selection
        
        player1Takes = "\(oldRound.playerTakes[game.players[0].id] ?? 0)"
        player1Takes = player1Takes == "0" ? "" : player1Takes
        
        player2Takes = "\(oldRound.playerTakes[game.players[1].id] ?? 0)"
        player2Takes = player2Takes == "0" ? "" : player2Takes
        
        player3Takes = "\(oldRound.playerTakes[game.players[2].id] ?? 0)"
        player3Takes = player3Takes == "0" ? "" : player3Takes
        
        player4Takes = "\(oldRound.playerTakes[game.players[3].id] ?? 0)"
        player4Takes = player4Takes == "0" ? "" : player4Takes
    }
    
    private func save() {
        isSaving = true
        
        // Create a new round
        let round = Round(
            id: roundId,
            selection: selection,
            caller: caller
        )
        
        // Add player points to the round
        round.playerTakes[game.players[0].id] = Int(player1Takes)
        round.playerTakes[game.players[1].id] = Int(player2Takes)
        round.playerTakes[game.players[2].id] = Int(player3Takes)
        round.playerTakes[game.players[3].id] = Int(player4Takes)
        
        // Modify player points in game
        game.players[0].pts += round.playerPts[game.players[0].id] ?? 0
        game.players[1].pts += round.playerPts[game.players[1].id] ?? 0
        game.players[2].pts += round.playerPts[game.players[2].id] ?? 0
        game.players[3].pts += round.playerPts[game.players[3].id] ?? 0
        
        // Overwrite the round in the game
        game.rounds[roundId - 1] = round
        
        // Modify selection count
        game.players[caller].incrementSelection(selection)
        game.roundCounts[selection] = 1 + (game.roundCounts[selection] ?? 0)
        
        model.save(game)
        
        updateStates()
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func delete() {
        selection = .undefined
        caller = 0
        player1Takes = "0"
        player2Takes = "0"
        player3Takes = "0"
        player4Takes = "0"
        save()
    }
}

struct SelectionPickerView_Previews: PreviewProvider {
    static var previews: some View {
        EditRoundView(roundId: 1, gameId: 1)
    }
}
