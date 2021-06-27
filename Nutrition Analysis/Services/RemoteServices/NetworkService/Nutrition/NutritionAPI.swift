//
//  NutritionAPI.swift
//  Nutrition Analysis
//
//  Created by Mohamed Nasser on 27/06/2021.
//

import Moya

enum NutritionAPI {
    case nutritionAnalysis(ingredients: [String])
}

extension NutritionAPI: TargetType, EnvironmentProtocol {
    var baseURL: URL {
        let stringURL = getCurrentEnvironment().middlewareBaseURL
        guard let url = URL(string: stringURL) else { fatalError("stringURL could not be configured") }
        return url
    }
    
    var path: String {
        switch self {
        case .nutritionAnalysis: return "nutrition-details"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .nutritionAnalysis:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        return ["Accept": "*/*",
                "Content-Type": "application/json", 
                "Accept-Encoding": "gzip, deflate, br"]
    }
    
    var task: Task {
        switch self {
        case .nutritionAnalysis(let ingredients):
            
            let appId = getAPIAppID()
            let appKey = getAPIAppKey()
            
            let urlParameters: [String : Any] = ["app_key": appKey, "app_id": appId]
            let bodyParameters: [String : Any] = ["ingr": ingredients]
            
            return .requestCompositeParameters(bodyParameters: bodyParameters,
                                               bodyEncoding: JSONEncoding.default,
                                               urlParameters: urlParameters)
        }
    }
}

