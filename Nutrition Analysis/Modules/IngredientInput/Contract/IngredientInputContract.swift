//
//  IngredientInputContract.swift
//  Nutrition Analysis
//
//  Created by Mohamed Nasser on 27/06/2021.
//

import Foundation

// MARK: - ViewModel
protocol IngredientInputViewModelProtocol {
    var uiModel: IngredientInputUIModel? { get }
    
    func analyzeAction()
    func updateInputText(_ test: String?)
}

// MARK: - Router
enum IngredientInputRoute {
    case defaultAlert(title: String, message: String)
    case ingredientSummary(ingredients: [Ingredient])
}

protocol IngredientInputRouterProtocol {
    func navigate(to route: IngredientInputRoute)
}
