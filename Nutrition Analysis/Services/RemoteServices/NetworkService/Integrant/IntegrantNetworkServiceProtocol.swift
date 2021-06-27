//
//  IntegrantNetworkServiceProtocol.swift
//  Nutrition Analysis
//
//  Created by Mohamed Nasser on 27/06/2021.
//

import RxSwift

protocol IntegrantNetworkServiceProtocol {
    func integrantAnalysis(ingredient: String) -> Observable<Result<Ingredient, Error>>
}

extension IntegrantNetworkServiceProtocol {
    func integrantAnalysis(ingredient: String) -> Observable<Result<Ingredient, Error>> {
        let service = IntegrantNetworkService()
        return service.integrantAnalysis(ingredient: ingredient)
    }
}
