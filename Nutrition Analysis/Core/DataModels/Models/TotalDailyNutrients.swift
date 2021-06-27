//
//  TotalNutrients.swift
//  Nutrition Analysis
//
//  Created by Mohamed Nasser on 27/06/2021.
//

import Foundation

struct TotalDailyNutrients: Codable {
    let totalNutrients: [String: TotalDailyNutrient]
   
    init() {
        totalNutrients = [:]
    }
    
    enum CodingKeys: String, CodingKey {
        case totalNutrients = "totalDaily"
    }
}

struct TotalDailyNutrient: Codable {
    let unit: String
    let label: String
    let quantity: Double
}
