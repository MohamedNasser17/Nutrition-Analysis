//
//  NutritionNetworkService.swift
//  Nutrition Analysis
//
//  Created by Mohamed Nasser on 27/06/2021.
//

import RxSwift

class NutritionNetworkService: BaseNetworkService<NutritionAPI>, NutritionNetworkServiceProtocol {
    func nutritionAnalysis(ingredients: [String]) -> Observable<Result<TotalDailyNutrients, Error>> {
        return request(target: .nutritionAnalysis(ingredients: ingredients))
    }
}
