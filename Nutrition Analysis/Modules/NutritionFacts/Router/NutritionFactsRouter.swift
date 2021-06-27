//
//  NutritionFactsRouter.swift
//  Nutrition Analysis
//
//  Created by Mohamed Nasser on 27/06/2021.
//

import UIKit

class NutritionFactsRouter: NutritionFactsRouterProtocol {
    
    // MARK: - Proprities
    weak var viewController: UIViewController?
    
    // MARK: - Constrction Methods
    static func createNutritionFactsModule(ingredients: [Ingredient]) -> UIViewController {
        let networkService = NutritionNetworkService()
        let router = NutritionFactsRouter()
        let uiModel = NutritionFactsUIModel(ingredients: ingredients)
        let viewController = NutritionFactsViewController()
        let viewMdoel = NutritionFactsViewModel(uiModel: uiModel, router: router,
                                                networkService: networkService)
        
        viewController.viewModel = viewMdoel
        router.viewController = viewController
        
        return viewController
    }
   
    // MARK: - Navigation
    func navigate(to route: NutritionFactsRoute) {
        
    }
}
