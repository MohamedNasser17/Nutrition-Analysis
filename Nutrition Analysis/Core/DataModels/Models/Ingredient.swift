//
//  Ingredient.swift
//  Nutrition Analysis
//
//  Created by Mohamed Nasser on 27/06/2021.
//

import Foundation

struct Ingredient: Codable {
    var unit: String = ""
    var food: String = ""
    var weight: Double = 0.0
    var quantity: Double = 0.0
    var calories: Double = 0.0
    
    enum CodingKeys: String, CodingKey {
        case calories = "calories"
        case weight = "totalWeight"
    }
    
    init(quantity: Double, unit: String, food: String) {
        self.unit = unit
        self.food = food
        self.quantity = quantity
    }
}
