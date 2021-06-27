//
//  IngredientsSummaryUIModel.swift
//  Nutrition Analysis
//
//  Created by Mohamed Nasser on 27/06/2021.
//

import RxRelay

class IngredientsSummaryUIModel {
    
    // MARK: - Proprities
    var ingredients: BehaviorRelay<[String]>
    var initialIngredients: BehaviorRelay<[Ingredient]>
    
    // MARK: - Init
    init(ingredients: [Ingredient]) {
        self.ingredients = BehaviorRelay<[String]>(value: [])
        self.initialIngredients = BehaviorRelay<[Ingredient]>(value: ingredients)
    }
}
