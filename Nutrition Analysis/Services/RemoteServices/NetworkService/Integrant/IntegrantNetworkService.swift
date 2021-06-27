//
//  IntegrantNetworkService.swift
//  Nutrition Analysis
//
//  Created by Mohamed Nasser on 27/06/2021.
//

import RxSwift

class IntegrantNetworkService: BaseNetworkService<IntegrantAPI>, IntegrantNetworkServiceProtocol {
    func integrantAnalysis(ingredient: String) -> Observable<Result<Ingredient, Error>> {
        return request(target: .integrantAnalysis(ingredient: ingredient))
    }
}
