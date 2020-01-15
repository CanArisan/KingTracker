//
//  TitleBar.swift
//  KingTracker
//
//  Created by Can Arışan on 26.12.19.
//  Copyright © 2019 Can Arisan. All rights reserved.
//

import SwiftUI

struct TitleBar: View {
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "suit.club.fill").foregroundColor(.black)
                Image(systemName: "suit.heart.fill").foregroundColor(Color("SuitRed"))
                Image(systemName: "suit.spade.fill").foregroundColor(.black)
                Image(systemName: "suit.diamond.fill").foregroundColor(Color("SuitRed"))
                Image(systemName: "suit.club.fill").foregroundColor(.black)
            }
            Text("KingTracker")
                .bold()
                .foregroundColor(.black)
            HStack {
                Image(systemName: "suit.heart.fill").foregroundColor(Color("SuitRed"))
                Image(systemName: "suit.spade.fill").foregroundColor(.black)
                Image(systemName: "suit.diamond.fill").foregroundColor(Color("SuitRed"))
                Image(systemName: "suit.club.fill").foregroundColor(.black)
                Image(systemName: "suit.heart.fill").foregroundColor(Color("SuitRed"))
                
            }
        }
        .padding()
        .background(Rectangle().frame(width: 415, height: 40, alignment: .center))
        .foregroundColor(Color("Cuha"))
    }
}

struct TitleBar_Previews: PreviewProvider {
    static var previews: some View {
        TitleBar()
    }
}
