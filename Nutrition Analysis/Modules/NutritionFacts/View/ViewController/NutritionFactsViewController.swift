//
//  NutritionFactsViewController.swift
//  Nutrition Analysis
//
//  Created by Mohamed Nasser on 27/06/2021.
//

import UIKit
import RxSwift
import RxCocoa

class NutritionFactsViewController: UIViewController {
    
    // MARK: - UIViews
    @IBOutlet private weak var totalButton: UIButton!
    @IBOutlet private weak var dailyNutritionFactsTableView: UITableView!
    
    // MARK: - Proprities
    let disposeBag = DisposeBag()
    var viewModel: NutritionFactsViewModelProtocol?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBinding()
        viewModel?.fetchTotalNutritionFactsData()
    }
}

// MARK: - Private UI Methods
extension NutritionFactsViewController {
    private func setupUI() {
        registerTableViewCells()
        title = "Nutrition Facts"
    }
    
    private func registerTableViewCells() {
        dailyNutritionFactsTableView.register(UITableViewCell.self,
                                              forCellReuseIdentifier: "DailyNutritionFactsTableViewCell")
    }
}

// MARK: - Private Binding Methods
extension NutritionFactsViewController {
    private func setupBinding() {
        bindTableViewDataSource()
    }
    
    private func bindTableViewDataSource() {
        viewModel?.uiModel?.totalDailyNutrients
            .bind(to: dailyNutritionFactsTableView.rx.items(cellIdentifier: "DailyNutritionFactsTableViewCell")) { (_, nutrition, cell) in
                cell.textLabel?.text = nutrition
        }.disposed(by: disposeBag)
    }
}
