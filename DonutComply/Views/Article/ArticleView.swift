//
//  ArticleView.swift
//  DonutComply
//
//  Created by Martin Pham on 12/10/21.
//

import SwiftUI

struct ArticleView: View {
    @State var article: Article
    
    var body: some View {
        ScrollView{
            
            
            VStack(alignment: .leading){
                Text(article.continent)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading)
                
                Divider()
                Image(article.image)
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal)
                
                HStack{
                    Text("Views : " + String(article.views))
                        .padding(.leading)
                    Spacer()
                        .frame(width: 240.0)
                    Text("Score : " + String(article.score))
                        .padding(.trailing)
                    
                    
                }
                
                Spacer()
                
                HStack{
                    
                }
                Text(article.city)
                    .fontWeight(.semibold)
                    .padding(.leading)
                Text(article.food)
                    .fontWeight(.semibold)
                    .padding(.leading)
                
                Spacer()
                    .frame(height: 20.0)
                
                Text(article.context)
                    .padding(.leading)
            }
            
            VStack(alignment: .leading){
                Divider()
                Text("Ingredients: ")
                    .font(.title2)
                    .fontWeight(.heavy)
                
                ForEach(article.ingredients, id: \.self){ i in
                    Text("-  " + i)
                }
            }
            .padding(.all)
        }
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(article: Article(continent: "North America", city: "Mexico City", food: "Gorditas", image: "Gorditas", context: "Gorditas are made from nixtamalized maize flour. Nixtamalization is the origin of Mexican Culinary Culture. It’s a very old process that was invented by mesoamerican people. Gorditas are soft and filled with cheese, meat, and other fillings. It’s now a classic Mexican street food. ", lat: 0, lon: 0, score: 0, views: 0, prepTime: "4 hours", cookingTime: "30 minutes", ingredients: ["4 cups all-purpose flour", "3 tablespoons cornmeal", "1 3/4 teaspoon salt", "2 3/4 teaspoons instant yeast", "4 tablespoons olive oil", "4 tablespoons butter", "2 tablespoons vegetable oil", "1 cup + 2 tablespoons lukewarm water", "3/4 lb mozzarella cheese", "1 lb sausage", "28oz diced tomatoes", "2 to 4 garlic cloves", "1 tablespoon sugar", "2 teaspoons mixure of oregano, basil, rosemary", "1 cup of parmesan"], steps: ""))
    }
}
