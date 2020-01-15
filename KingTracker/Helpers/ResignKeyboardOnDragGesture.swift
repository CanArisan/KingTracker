//
//  ResignKeyboardOnDragGesture.swift
//  KingTracker
//
//  Created by Can Arışan on 02.01.20.
//  Copyright © 2020 Can Arisan. All rights reserved.
//

import SwiftUI

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension UIApplication {
    public func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

