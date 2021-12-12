//
//  DataStructures.swift
//  DonutComply
//
//  Created by Ethan Hanlon on 12/10/21.
//

import Foundation
import Firebase
import Combine

struct Article {
    var continent: String
    var city: String
    var image: String
    var lastEdit: Int
    var location: String // A general location, showed in the article
    var lat: Double // Latitude
    var lon: Double // Longitude
    var context: String
    var score: Int
    var views: Int
    var prepTime: String
    var cookingTime: String
    var ingredients: [String] = []
    var steps: String
}
