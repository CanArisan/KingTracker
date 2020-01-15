//
//  PlayerCell.swift
//  KingTracker
//
//  Created by Can Arışan on 22.12.19.
//  Copyright © 2019 Can Arisan. All rights reserved.
//

import SwiftUI

struct PlayerCell: View {
    @EnvironmentObject var model: Model
    
    var player: Player
    
    init(player: Player) {
        self.player = player
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            HStack(alignment: .center, spacing: 2) {
                Image(systemName: player.kozCount > 0 ? "arrowtriangle.up.fill" : "arrowtriangle.up")
                    .resizable()
                    .frame(width: 10, height: 10, alignment: .center)
                Image(systemName: player.kozCount > 1 ? "arrowtriangle.up.fill" : "arrowtriangle.up")
                    .resizable()
                    .frame(width: 10, height: 10, alignment: .center)
                Image(systemName: player.cezaCount > 0 ? "arrowtriangle.down.fill" : "arrowtriangle.down")
                    .resizable()
                    .frame(width: 10, height: 10, alignment: .center)
                Image(systemName: player.cezaCount > 1 ? "arrowtriangle.down.fill" : "arrowtriangle.down")
                    .resizable()
                    .frame(width: 10, height: 10, alignment: .center)
                Image(systemName: player.cezaCount > 2 ? "arrowtriangle.down.fill" : "arrowtriangle.down")
                    .resizable()
                    .frame(width: 10, height: 10, alignment: .center)
            }
            Text(player.name)
            Text("\(player.pts)")
                .bold()
                .foregroundColor(player.pts >= 0 ? Color("Pos") : Color("Pink"))
        }
    }
}

struct PlayerCell_Previews: PreviewProvider {
    static var previews: some View {
        PlayerCell(player: Model.mock.players[0]).environmentObject(Model.mock)
    }
}
