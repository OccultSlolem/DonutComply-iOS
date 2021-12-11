//
//  ViewModifiers.swift
//  DonutComply
//
//  Created by Ethan Hanlon on 12/10/21.
//

import SwiftUI

/**
 Hides the SwiftUI navigation bar
 */
struct HideNavigationBar: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}

/**
 Mirrors content vertically
 */
public struct FlipEffect: GeometryEffect {
    public func effectValue(size: CGSize) -> ProjectionTransform {
        let t = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: size.height)
        return ProjectionTransform(t)
    }
}
