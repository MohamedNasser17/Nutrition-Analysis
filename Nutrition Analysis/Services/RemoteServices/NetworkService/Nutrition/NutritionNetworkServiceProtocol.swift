//
//  NutritionNetworkServiceProtocol.swift
//  Nutrition Analysis
//
//  Created by Mohamed Nasser on 27/06/2021.
//

import RxSwift

protocol NutritionNetworkServiceProtocol {
    func nutritionAnalysis(ingredients: [String]) -> Observable<Result<TotalDailyNutrients, Error>>
}

extension NutritionNetworkServiceProtocol {
    func nutritionAnalysis(ingredients: [String]) -> Observable<Result<TotalDailyNutrients, Error>> {
        let service = NutritionNetworkService()
        return service.nutritionAnalysis(ingredients: ingredients)
    }
}
