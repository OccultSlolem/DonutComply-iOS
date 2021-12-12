//
//  Colors.swift
//  DonutComply
//
//  Created by Ethan Hanlon on 12/10/21.
//

import SwiftUI

public struct Colors {
    private static var osTheme: UIUserInterfaceStyle {
        return UIScreen.main.traitCollection.userInterfaceStyle
    }
    
    // Politifi Branding
    public static let ancientPages = Color(hex: 0xDDD4D0)
    public static let duskyViolet = Color(hex: 0xCFC0BD)
    public static let gravelDust = Color(hex: 0xB8B8AA)
    public static let greenBay = Color(hex: 0x7F9183)
    public static let aventurine = Color(hex:0x586F6B)
    
    // Third party branding
    public static let discordBgColor = Color(hex: 0x5865F2)
    public static let instagramBgColor = Color(hex: 0xF09433)
    
    public static var buttonBackgroundColor: Color {
        if osTheme == UIUserInterfaceStyle.light {
            return aventurine
        } else {
            return gravelDust
        }
    }
    
    public static var textForegroundColor: Color {
        if osTheme == UIUserInterfaceStyle.light {
            return ancientPages
        } else {
            return aventurine
        }
    }
}

//With thanks to Sam Soffes on StackOverflow
//This allows us to initialize a UIColor using a hex code
extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
