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
    
    
    
    
    let regions = [
        Place(name: "Mexico City", latitude:19.507389, longitude:-99.127784),
        Place(name: "Chicago", latitude:41.802753, longitude:-87.744090),
        Place(name: "Buenos Aires", latitude:-36611606, longitude:-60.110613),
        Place(name: "Rio de Janeiro", latitude:-22.959216, longitude:-43.221382),
        Place(name: "Cape Town", latitude:-33.963496, longitude:18.404851),
        Place(name: "Addis Adaba", latitude:9.037633, longitude:38.754418),
        Place(name: "Rome", latitude:41.890605, longitude:12.497402),
        Place(name: "Paris", latitude:48.858436, longitude:2.345173),
        Place(name: "Tokyo", latitude:35.690785, longitude:139.691441),
        Place(name: "Mumbai", latitude:18.941049, longitude:72.832501),
        Place(name: "Sydney", latitude:-33.872890, longitude:151.205791),
        Place(name: "Cairns", latitude:-16.926093, longitude:145.771803),
        
        
    ]
    
    
    
    @State private var selectedFood: String?
    @State private var navigation = false
    
    var body: some View {
        NavigationView{
                        
            VStack {
                NavigationLink(
                    destination: ArticleView(),
                    isActive: $navigation,
                    label: {EmptyView()}
                    )

                
                Map(coordinateRegion: $region, annotationItems: regions) {place in MapAnnotation(coordinate: place.coordinate) {
                    Button(action:  {
                        navigation = true
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
