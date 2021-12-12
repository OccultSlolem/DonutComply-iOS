//
//  DataStructures.swift
//  DonutComply
//
//  Created by Ethan Hanlon on 12/10/21.
//

import Foundation

struct Article {
    var title: String
    var image: String
    var lastEdit: Int
    var location: String // TODO
    var name: String
    var context: String
    var score: Int
    var views: Int
    var prepTime: String
    var cookingTime: String
    var ingredients: [String] = []
    var steps: String
}
