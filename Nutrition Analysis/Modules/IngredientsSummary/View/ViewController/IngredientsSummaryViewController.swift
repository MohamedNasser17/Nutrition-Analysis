//
//  IngredientsSummaryViewController.swift
//  Nutrition Analysis
//
//  Created by Mohamed Nasser on 27/06/2021.
//

import UIKit
import RxSwift
import RxCocoa

class IngredientsSummaryViewController: UIViewController {
    
    // MARK: - UIViews
    @IBOutlet private weak var totalButton: UIButton!
    @IBOutlet private weak var ingredientsTableView: UITableView!
    
    // MARK: - Proprities
    let disposeBag = DisposeBag()
    var viewModel: IngredientsSummaryViewModelProtocol?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBinding()
        viewModel?.fetchIngredientData()
    }
}

// MARK: - Private UI Methods
extension IngredientsSummaryViewController {
    private func setupUI() {
        registerTableViewCells()
        title = "Ingredients Summary"
    }
    
    private func registerTableViewCells() {
        ingredientsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "IngredientsTableViewCell")
    }
}

// MARK: - Private Binding Methods
extension IngredientsSummaryViewController {
    private func setupBinding() {
        bindTotalButtonAction()
        bindTableViewDataSource()
    }
    
    private func bindTotalButtonAction() {
        totalButton.rx.tap.bind { [weak self] _ in
            self?.viewModel?.totalAction()
        }.disposed(by: disposeBag)
    }
    
    private func bindTableViewDataSource() {
        viewModel?.uiModel?.ingredients
            .bind(to: ingredientsTableView.rx.items(cellIdentifier: "IngredientsTableViewCell")) { (_, ingredient, cell) in
                cell.textLabel?.text = ingredient
                cell.textLabel?.numberOfLines = 0
        }.disposed(by: disposeBag)
    }
}
