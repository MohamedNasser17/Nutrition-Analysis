//
//  NutritionFactsViewModel.swift
//  Nutrition Analysis
//
//  Created by Mohamed Nasser on 27/06/2021.
//

import RxSwift

class NutritionFactsViewModel: NutritionFactsViewModelProtocol {
    
    // MARK: - Proprities
    var disposeBag = DisposeBag()
    var uiModel: NutritionFactsUIModel?
    var router: NutritionFactsRouterProtocol?
    var networkService: NutritionNetworkServiceProtocol?
    
    // MARK: - Init
    init(uiModel: NutritionFactsUIModel?,
         router: NutritionFactsRouterProtocol?,
         networkService: NutritionNetworkServiceProtocol?) {
        self.router = router
        self.uiModel = uiModel
        self.networkService = networkService
    }
}
    
// MARK: - View Actions
extension NutritionFactsViewModel {
    func fetchTotalNutritionFactsData() {
        uiModel?.ingredients.filter({ !$0.isEmpty })
            .flatMap({ [weak self] ingredients -> Observable<Result<TotalDailyNutrients, Error>> in
                guard let networkService = self?.networkService else { return Observable.just(.success(TotalDailyNutrients())) }
                let ingredientsString = ingredients.map({ "\($0.quantity) \($0.unit) \($0.food)" })
                return networkService.nutritionAnalysis(ingredients: ingredientsString)
        }).subscribe(onNext: { [weak self] nutritionResult in
            switch nutritionResult {
            case .success(let nutrition):
                let dailyNutrients =  self?.formateNutrition(nutrition: nutrition) ?? []
                self?.uiModel?.totalDailyNutrients.accept(dailyNutrients)
            case .failure(let error):
                print(error)
            }
        }).disposed(by: disposeBag)
    }
}

// MARK: - Private Helper Methods
extension NutritionFactsViewModel {
    private func formateNutrition(nutrition: TotalDailyNutrients) -> [String] {
        let dailyNutrients = nutrition
            .totalNutrients
            .sorted(by: { $0.value.label < $1.value.label })
            .map({ "\($0.value.label): \(String(format: "%.4f", $0.value.quantity))\($0.value.unit)"})
        return dailyNutrients
    }
}
