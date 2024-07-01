//
//  TranslateInteractor.swift
//  Dictionary
//
//  Created by KOДИ on 17.06.2024.
//

import UIKit

protocol TranslateInteractorInput {
    var output: TranslateInteractorOutput? { get set }
    func fetchTranslation(for text: String, from sourceLanguage: String?, to targetLanguage: String)
}

protocol TranslateInteractorOutput: AnyObject {
    func didFetchTranslation(_ translation: String)
    func didFailToFetchTranslation(error: Error)
}

final class TranslateInteractor: TranslateInteractorInput {
    weak var output: TranslateInteractorOutput?
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchTranslation(for text: String, from sourceLanguage: String?, to targetLanguage: String) {
        networkService.fetchTranslation(for: text, from: sourceLanguage, to: targetLanguage) { result in
            switch result {
            case .success(let translation):
                self.output?.didFetchTranslation(translation.text)
            case .failure(let error):
                self.output?.didFailToFetchTranslation(error: error)
            }
        }
    }
}
