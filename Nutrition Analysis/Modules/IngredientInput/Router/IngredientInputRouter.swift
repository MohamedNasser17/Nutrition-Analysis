//
//  IngredientInputRouter.swift
//  Nutrition Analysis
//
//  Created by Mohamed Nasser on 27/06/2021.
//

import UIKit

class IngredientInputRouter: IngredientInputRouterProtocol {
    
    // MARK: - Proprities
    weak var viewController: UIViewController?
    
    // MARK: - Constrction Methods
    static func createIngredientInputModule() -> UIViewController {
        let router = IngredientInputRouter()
        let uiModel = IngredientInputUIModel()
        let viewController = IngredientInputViewController()
        let viewMdoel = IngredientInputViewModel(uiModel: uiModel, router: router)
        
        viewController.viewModel = viewMdoel
        router.viewController = viewController
        
        return viewController
    }
   
    // MARK: - Navigation
    func navigate(to route: IngredientInputRoute) {
        switch route {
        case .ingredientSummary(let ingredients):
            navigateToIngredientSummary(ingredients)
        case .defaultAlert(let title, let message):
            navigateToInvalidInputAlert(title: title, message: message)
        }
    }
}

// MARK: - Private Methods
extension IngredientInputRouter {
    private func navigateToIngredientSummary(_ ingredients: [Ingredient]) {
        let vc = IngredientsSummaryRouter.createIngredientsSummaryModule(ingredients: ingredients)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func navigateToInvalidInputAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        viewController?.present(alert, animated: true, completion: nil)
    }
}
