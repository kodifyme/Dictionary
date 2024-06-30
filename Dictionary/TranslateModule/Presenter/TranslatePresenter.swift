//
//  TranslatePresenter.swift
//  Dictionary
//
//  Created by KOДИ on 17.06.2024.
//

import UIKit

protocol TranslatePresenterInput {
    var output: TranslatePresenterOutput? { get set }
}

protocol TranslatePresenterOutput: AnyObject {
    func didFetchTranslation(_ translation: String)
    func didFailToFetchTranslation(error: Error)
}

final class TranslatePresenter: TranslatePresenterInput {
    weak var output: TranslatePresenterOutput?
    
    private var view: TranslateViewInput
    private var interactor: TranslateInteractorInput
    private var router: TranslateRouterInput
    private var isSourceLanguageSelection = true
    private var sourceLanguage = "ru"
    private var targetLanguage = "en"
    
    init(view: TranslateViewInput, interactor: TranslateInteractorInput, router: TranslateRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - TranslateViewOutput
extension TranslatePresenter: TranslateViewOutput {
    func didPressLanguageButton(isSourceLanguage: Bool) {
        isSourceLanguageSelection = isSourceLanguage
        router.openLanguageSelectionScreen(delegate: self)
    }
    
    func didEnterText(_ text: String) {
        interactor.fetchTranslation(for: text, from: sourceLanguage, to: targetLanguage)
    }
}

//MARK: - LanguageSelectionDelegate
extension TranslatePresenter: LanguageSelectionDelegate {
    func didSelectLanguage(_ language: String) {
        if isSourceLanguageSelection {
            sourceLanguage = language
            view.setSourceLanguage(language)
        } else {
            targetLanguage = language
            view.setTargetLanguage(language)
        }
    }
}

//MARK: - TranslateInteractorOutput
extension TranslatePresenter: TranslateInteractorOutput {
    func didFetchTranslation(_ translation: String) {
        view.displayTranslation(translation)
    }
    
    func didFailToFetchTranslation(error: Error) {
        print(error)
    }
}
