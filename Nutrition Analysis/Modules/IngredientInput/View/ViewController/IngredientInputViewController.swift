//
//  IngredientInputViewController.swift
//  Nutrition Analysis
//
//  Created by Mohamed Nasser on 27/06/2021.
//

import UIKit
import RxSwift
import RxCocoa

class IngredientInputViewController: UIViewController {
    
    // MARK: - UIViews
    private var analyzeButton: UIBarButtonItem!
    @IBOutlet private weak var placeholderLabel: UILabel!
    @IBOutlet private weak var ingredientTextView: UITextView!
    
    // MARK: - Proprities
    let disposeBag = DisposeBag()
    var viewModel: IngredientInputViewModelProtocol?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBinding()
    }
}

// MARK: - Private UI Methods
extension IngredientInputViewController {
    private func setupUI() {
        setupAnalyzeBarButtons()
        title = "Ingredient Input"
    }
    
    private func setupAnalyzeBarButtons() {
        analyzeButton = UIBarButtonItem()
        analyzeButton.title = "Analyze"
        analyzeButton.isEnabled = false
        navigationItem.rightBarButtonItem = analyzeButton
    }
}

// MARK: - Private Binding Methods
extension IngredientInputViewController {
    private func setupBinding() {
        bindViewsAppeariance()
        bindIngredientTextView()
        bindAnalyzeButtonAction()
    }
    
    private func bindAnalyzeButtonAction() {
        analyzeButton.rx.tap.bind { [weak self] _ in
            self?.viewModel?.analyzeAction()
        }.disposed(by: disposeBag)
    }
    
    private func bindViewsAppeariance() {
        viewModel?.uiModel?.inputText.bind { [weak self] text in
            let isEmptyText = !(text?.isEmpty ?? true)
            self?.analyzeButton.isEnabled = isEmptyText
            self?.placeholderLabel.isHidden = isEmptyText
        }.disposed(by: disposeBag)
    }
    
    private func bindIngredientTextView() {
        ingredientTextView.rx.text.bind { [weak self] text in
            self?.viewModel?.updateInputText(text)
        }.disposed(by: disposeBag)
    }
}
