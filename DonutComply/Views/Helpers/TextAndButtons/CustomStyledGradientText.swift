//
//  CustomStyledGradientText.swift
//  Politifi
//
//  Created by Ethan Hanlon on 12/31/20.
//

import SwiftUI

struct CustomStyledGradientText: View {
    let title : String
    let gradient : LinearGradient
    
    var body: some View {
        HStack {
            Spacer()
            Text(title)
                .font(.title2)
                .foregroundColor(Color.white)
                .padding()
            Spacer()
            }
        .background(gradient)
        .cornerRadius(16)
        .padding(.horizontal)
    }
}

struct CustomStyledGradientText_Previews: PreviewProvider {
    static var previews: some View {
        CustomStyledGradientText(title: "String", gradient: LinearGradient(gradient: Gradient(colors: [Color.pink, Color.purple, Color.blue]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
            .previewLayout(.sizeThatFits)
    }
}
