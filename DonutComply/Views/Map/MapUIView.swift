//
//  MapUIView.swift
//  DonutComply
//
//  Created by Aidan Bayer-Calvert on 12/11/21.
//

import SwiftUI
import MapKit

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    
}

struct MapUIView: View {
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 0,
            longitude: 0),
        span: MKCoordinateSpan(
            latitudeDelta:170, longitudeDelta:170))
    
    var fh = FirestoreHelper()
    
    
    let regions = [
        Place(name: "Gorditas", latitude:19.507389, longitude:-99.127784),
        Place(name: "Deep Dish Pizza", latitude:41.802753, longitude:-87.744090),
        Place(name: "Milanesas De Carne", latitude:-36611606,longitude:-60.110613),
        Place(name: "Pastel De Queijo", latitude:-22.959216, longitude:-43.221382),
        Place(name: "Bobotie", latitude:-33.963496, longitude:18.404851),
        Place(name: "Injera", latitude:9.037633, longitude:38.754418),
        Place(name: "Carbonara", latitude:41.890605, longitude:12.497402),
        Place(name: "Steak-Frites", latitude:48.858436, longitude:2.345173),
        Place(name: "Soba", latitude:35.690785, longitude:139.691441),
        Place(name: "Akuri On Toast", latitude:18.941049, longitude:72.832501),
        Place(name: "Barramundi", latitude:-33.872890, longitude:151.205791),
        Place(name: "Duck Confit", latitude:-16.926093, longitude:145.771803),
        
        
    ]
    
    
    @State private var mainArticle = Article(continent: "", city: "", food: "", image: "", context: "", lat: 0, lon: 0, score: 0, views: 0, prepTime: "", cookingTime: "", steps: "")
    @State private var selectedFood: String?
    @State private var navigation = false
    
    var body: some View {
        NavigationView{
                        
            VStack {
                NavigationLink(
                    destination:ArticleView(article: Article(continent: "North America", city: "Mexico City", food: "Gorditas", image: "Gorditas", context: "Gorditas are made from nixtamalized maize flour. Nixtamalization is the origin of Mexican Culinary Culture. It’s a very old process that was invented by mesoamerican people. Gorditas are soft and filled with cheese, meat, and other fillings. It’s now a classic Mexican street food. ", lat: 0, lon: 0, score: 0, views: 0, prepTime: "4 hours", cookingTime: "30 minutes", ingredients: ["4 cups all-purpose flour", "3 tablespoons cornmeal", "1 3/4 teaspoon salt", "2 3/4 teaspoons instant yeast", "4 tablespoons olive oil", "4 tablespoons butter", "2 tablespoons vegetable oil", "1 cup + 2 tablespoons lukewarm water", "3/4 lb mozzarella cheese", "1 lb sausage", "28oz diced tomatoes", "2 to 4 garlic cloves", "1 tablespoon sugar", "2 teaspoons mixure of oregano, basil, rosemary", "1 cup of parmesan"], steps: "")),
                    isActive: $navigation,
                    label: {EmptyView()}
                    )

                
                Map(coordinateRegion: $region, annotationItems: regions) {place in MapAnnotation(coordinate: place.coordinate) {
                    Button(action:  {
                        fh.getArticleByName(name: place.name){ article, success in
                            if success && article != nil {
                                mainArticle = article!
                                navigation = true
                            }
                        }
                        withAnimation {
                            selectedFood = place.name
                        }
                    }, label: {
                        VStack {
                            Circle()
                            Text(place.name)
                                .background(RoundedRectangle(cornerRadius: 16)
                                                .foregroundColor(.white))
                        }
                    })
                }}
            }
            .modifier(HideNavigationBar())
        }
    }
    
    struct MapUIView_Previews: PreviewProvider {
        static var previews: some View {
            MapUIView()
        }
    }
    
}
