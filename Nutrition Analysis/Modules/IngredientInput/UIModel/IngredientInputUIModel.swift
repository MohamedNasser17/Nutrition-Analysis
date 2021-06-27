//
//  IngredientInputUIModel.swift
//  Nutrition Analysis
//
//  Created by Mohamed Nasser on 27/06/2021.
//

import RxSwift
import RxRelay

struct IngredientInputUIModel {
    
    // MARK: - Proprities
    let inputText = BehaviorRelay<String?>(value: nil)
}
