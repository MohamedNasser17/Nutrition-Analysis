//
//  EnvironmentProtocol.swift
//  Nutrition Analysis
//
//  Created by Mohamed Nasser on 27/06/2021.
//

import Foundation

protocol EnvironmentProtocol {
    func getCurrentEnvironment() -> Environment
}

extension EnvironmentProtocol {
    func getCurrentEnvironment() -> Environment {
        return Environment.current
    }
    
    func getAPIAppID() -> String {
        return Environment.current.apiAppID
    }
    
    func getAPIAppKey() -> String {
        return Environment.current.apiAppKey
    }
}
