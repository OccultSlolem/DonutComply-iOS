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
    var food: String
    var image: String
    var context: String
    var lat: Double // Latitude
    var lon: Double // Longitude
    var score: Int
    var views: Int
    var prepTime: String
    var cookingTime: String
    var ingredients: [String] = []
    var steps: String
}
