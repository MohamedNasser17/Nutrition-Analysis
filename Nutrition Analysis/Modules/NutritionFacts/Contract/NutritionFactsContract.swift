//
//  NutritionFactsContract.swift
//  Nutrition Analysis
//
//  Created by Mohamed Nasser on 27/06/2021.
//

import Foundation

// MARK: - ViewModel
protocol NutritionFactsViewModelProtocol {
    var uiModel: NutritionFactsUIModel? { get }
    
    func fetchTotalNutritionFactsData()
}

// MARK: - Router
enum NutritionFactsRoute {
}

protocol NutritionFactsRouterProtocol {
    func navigate(to route: NutritionFactsRoute)
}
