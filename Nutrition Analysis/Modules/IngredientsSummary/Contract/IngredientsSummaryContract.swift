//
//  IngredientsSummaryContract.swift
//  Nutrition Analysis
//
//  Created by Mohamed Nasser on 27/06/2021.
//

import Foundation

// MARK: - ViewModel
protocol IngredientsSummaryViewModelProtocol {
    var uiModel: IngredientsSummaryUIModel? { get }
    
    func totalAction()
    func fetchIngredientData()
}

// MARK: - Router
enum IngredientsSummaryRoute {
    case nutritionFacts(ingredients: [Ingredient])
}

protocol IngredientsSummaryRouterProtocol {
    func navigate(to route: IngredientsSummaryRoute)
}
