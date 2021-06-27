//
//  IngredientsSummaryViewModel.swift
//  Nutrition Analysis
//
//  Created by Mohamed Nasser on 27/06/2021.
//

import RxSwift

class IngredientsSummaryViewModel: IngredientsSummaryViewModelProtocol {
    
    // MARK: - Proprities
    var disposeBag = DisposeBag()
    var uiModel: IngredientsSummaryUIModel?
    var router: IngredientsSummaryRouterProtocol?
    var networkService: IntegrantNetworkServiceProtocol?
    
    // MARK: - Init
    init(uiModel: IngredientsSummaryUIModel?,
         router: IngredientsSummaryRouterProtocol?,
         networkService: IntegrantNetworkServiceProtocol?) {
        self.router = router
        self.uiModel = uiModel
        self.networkService = networkService
    }
}
   
// MARK: - View Actions
extension IngredientsSummaryViewModel {
    func totalAction() {
        guard let ingredients = uiModel?.initialIngredients.value else { return }
        router?.navigate(to: .nutritionFacts(ingredients: ingredients))
    }
    
    func fetchIngredientData() {
        uiModel?.initialIngredients.flatMap({ [weak self] ingredients -> Observable<[Ingredient]> in
            guard let networkService = self?.networkService else { return Observable.just([])}
            
            let ingredientsRequests = ingredients.map { ing -> Observable<Result<Ingredient, Error>> in
                return networkService.integrantAnalysis(ingredient: "\(ing.quantity) \(ing.unit) \(ing.food)")
            }
            
            return Observable<[Ingredient]>.zip(ingredientsRequests) { ingredientsData -> [Ingredient] in
                var updatedIngredients = [Ingredient]()
                for i in 0..<ingredientsData.count {
                    var updatedIngredient = ingredients[i]
                    switch ingredientsData[i] {
                        case .success(let ing):
                            updatedIngredient = ing
                            updatedIngredient.food = ingredients[i].food
                            updatedIngredient.unit = ingredients[i].unit
                            updatedIngredient.quantity = ingredients[i].quantity
                            updatedIngredients.append(updatedIngredient)
                        case .failure(let error):
                            print(error)
                    }
                }
                return updatedIngredients
            }
        }).subscribe(onNext: { [weak self] ingredients in
            let ingredientsAsStrings = ingredients.map { ingredient -> String in
                return "Quantity: \(ingredient.quantity), Unit: \(ingredient.unit), Food: \(ingredient.food)\nCalories: \(ingredient.calories)kcal, Weight: \(ingredient.weight)g"
            }
            self?.uiModel?.ingredients.accept(ingredientsAsStrings)
        }).disposed(by: disposeBag)
    }
    
}
