//
//  NutritionFactsUIModel.swift
//  Nutrition Analysis
//
//  Created by Mohamed Nasser on 27/06/2021.
//

import RxRelay

class NutritionFactsUIModel {
    
    // MARK: - Proprities
    var ingredients: BehaviorRelay<[Ingredient]>
    var totalDailyNutrients: BehaviorRelay<[String]>
    
    // MARK: - Init
    init(ingredients: [Ingredient]) {
        self.totalDailyNutrients = BehaviorRelay<[String]>(value: [])
        self.ingredients = BehaviorRelay<[Ingredient]>(value: ingredients)
    }
}
