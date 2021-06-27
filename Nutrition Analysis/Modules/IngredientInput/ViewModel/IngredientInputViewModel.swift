//
//  IngredientInputViewModel.swift
//  Nutrition Analysis
//
//  Created by Mohamed Nasser on 27/06/2021.
//

import Foundation

class IngredientInputViewModel: IngredientInputViewModelProtocol {
    
    // MARK: - Proprities
    var uiModel: IngredientInputUIModel?
    var router: IngredientInputRouterProtocol?
    
    // MARK: - Init
    init(uiModel: IngredientInputUIModel?,
         router: IngredientInputRouterProtocol?) {
        self.router = router
        self.uiModel = uiModel
    }
}
    
// MARK: - View Actions
extension IngredientInputViewModel {
    func analyzeAction() {
        guard let inputText = uiModel?.inputText.value else { return }
        
        let ingredients = getIngredients(from: inputText)
        let isValidInputTest = !(ingredients?.isEmpty ?? true)
        
        if isValidInputTest {
            navigateToIngredientSummary(ingredients: ingredients ?? [])
        } else {
            navigateToInvalidInputAlert()
        }
    }
    
    func updateInputText(_ test: String?) {
        uiModel?.inputText.accept(test)
    }
}

// MARK: - Private methods
extension IngredientInputViewModel {
    
    private func getIngredients(from inputTest: String) -> [Ingredient]? {
       
        let ingredientsAsStrings = inputTest.split(separator: "\n")
        let ingredients = ingredientsAsStrings.map({ ingredient -> Ingredient? in
            
            let ingredientElements = ingredient.split(separator: " ")
            if ingredientElements.count == 3, let quantity = Double(ingredientElements[0]) {
                let unit = String(ingredientElements[1])
                let food = String(ingredientElements[2])
                return Ingredient(quantity: quantity, unit: unit, food: food)
            } else {
                return nil
            }
            
        }).filter { ingredient -> Bool in
            return ingredient != nil
        }.map { ingredient -> Ingredient in
            return ingredient!
        }
        
        return (ingredientsAsStrings.count == ingredients.count) ? ingredients : nil
    }
}

// MARK: - Navigation
extension IngredientInputViewModel {
    
    private func navigateToIngredientSummary(ingredients: [Ingredient]) {
        router?.navigate(to: .ingredientSummary(ingredients: ingredients))
    }
    
    private func navigateToInvalidInputAlert() {
        let title = "Invalid Input"
        let message = "Please make sure to flow the right formate of the input ex: 1 cup rice."
        router?.navigate(to: .defaultAlert(title: title, message: message))
    }
}
