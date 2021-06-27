//
//  IntegrantAPI.swift
//  Nutrition Analysis
//
//  Created by Mohamed Nasser on 27/06/2021.
//

import Moya

enum IntegrantAPI {
    case integrantAnalysis(ingredient: String)
}

extension IntegrantAPI: TargetType, EnvironmentProtocol {
    var baseURL: URL {
        let stringURL = getCurrentEnvironment().middlewareBaseURL
        guard let url = URL(string: stringURL) else { fatalError("stringURL could not be configured") }
        return url
    }
    
    var path: String {
        switch self {
        case .integrantAnalysis: return "nutrition-data"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .integrantAnalysis:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        return [:]
    }
    
    var task: Task {
        switch self {
        case .integrantAnalysis(let ingredient):
            let appId = getAPIAppID()
            let appKey = getAPIAppKey()
            let parameters: [String : Any] = ["app_id":appId,
                                              "app_key":appKey,
                                              "ingr": ingredient]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
}

