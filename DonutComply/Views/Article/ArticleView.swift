//
//  ArticleView.swift
//  DonutComply
//
//  Created by Martin Pham on 12/10/21.
//

import SwiftUI

struct ArticleView: View {
    private var testArticle = Article(title: "North America", image: "Gorditas", lastEdit: 0, location: "Mexico City", name: "Tortas de Tamale", context: "Gorditas are made from nixtamalized maize flour. Nixtamalization is the origin of Mexican Culinary Culture. It’s a very old process that was invented by mesoamerican people. Gorditas are soft and filled with cheese, meat, and other fillings. It’s now a classic Mexican street food. ", score: 0, views: 0, steps: "")
    var body: some View {
        ScrollView{
            
            
            VStack(alignment: .leading){
                Text(testArticle.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading)
                
                Divider()
                Image(testArticle.image)
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal)
                    
                
                HStack{
                    Text("Views : " + String(testArticle.views))
                        .padding(.leading)
                    Spacer()
                        .frame(width: 240.0)
                    Text("Score : " + String(testArticle.score))
                        .padding(.trailing)
                    
                    
                }
                
                Spacer()
                
                HStack{
                    
                }
                Text(testArticle.location)
                    .fontWeight(.semibold)
                    .padding(.leading)
                Text(testArticle.name)
                    .fontWeight(.semibold)
                    .padding(.leading)
                
                Spacer()
                    .frame(height: 20.0)
                
                Text(testArticle.context)
                    .padding(.leading)
            }
        }
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView()
    }
}
