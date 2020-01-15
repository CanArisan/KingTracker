//
//  ExistingPlayerSheet.swift
//  KingTracker
//
//  Created by Can Arışan on 15.01.20.
//  Copyright © 2020 Can Arisan. All rights reserved.
//

import SwiftUI

struct ExistingPlayerSheet: View {
    @EnvironmentObject var model: Model
    
    @Binding var player: String
    var body: some View {
        List(model.players.map({$0.name}), id: \.self) { player in
            Button(action: {
                self.player = player
            }) {
                Text(player)
            }
        }
    }
}

struct ExistingPlayerSheet_Previews: PreviewProvider {
    static var previews: some View {
        ExistingPlayerSheet(player: .constant("")).environmentObject(Model.mock)
    }
}
