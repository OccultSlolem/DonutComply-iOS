//
//  MapUIView.swift
//  DonutComply
//
//  Created by Aidan Bayer-Calvert on 12/11/21.
//

import SwiftUI
import MapKit

struct MapUIView: View {
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 40.7,
            longitude: -74),
        span: MKCoordinateSpan(
            latitudeDelta:10, longitudeDelta:10
        )
    )
    var body: some View {
//        MapUIView {
            VStack {
                Map(coordinateRegion: $region)
            }
//        }
    }
}

struct MapUIView_Previews: PreviewProvider {
    static var previews: some View {
        MapUIView()
        }
    }

