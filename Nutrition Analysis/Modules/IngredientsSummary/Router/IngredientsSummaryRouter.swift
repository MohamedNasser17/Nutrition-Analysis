//
//  IngredientsSummaryRouter.swift
//  Nutrition Analysis
//
//  Created by Mohamed Nasser on 27/06/2021.
//

import UIKit

class IngredientsSummaryRouter: IngredientsSummaryRouterProtocol {
    
    // MARK: - Proprities
    weak var viewController: UIViewController?
    
    // MARK: - Constrction Methods
    static func createIngredientsSummaryModule(ingredients: [Ingredient]) -> UIViewController {
        let networkService = IntegrantNetworkService()
        let router = IngredientsSummaryRouter()
        let uiModel = IngredientsSummaryUIModel(ingredients: ingredients)
        let viewController = IngredientsSummaryViewController()
        let viewMdoel = IngredientsSummaryViewModel(uiModel: uiModel, router: router,
                                                    networkService: networkService)
        
        viewController.viewModel = viewMdoel
        router.viewController = viewController
        
        return viewController
    }
   
    // MARK: - Navigation
    func navigate(to route: IngredientsSummaryRoute) {
        switch route {
        case .nutritionFacts(let ingredients):
            navigateToNutritionFacts(ingredients)
        }
    }
}

// MARK: - Private Methods
extension IngredientsSummaryRouter {
    private func navigateToNutritionFacts(_ ingredients: [Ingredient]) {
        let vc = NutritionFactsRouter.createNutritionFactsModule(ingredients: ingredients)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
