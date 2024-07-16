//
//  HistoryPresenter.swift
//  Dictionary
//
//  Created by KOДИ on 05.07.2024.
//

import UIKit

class HistoryPresenter {
    
    private var view: HistoryViewInput
    private var interactor: HistoryInteractorInput
    
    init(view: HistoryViewInput, interactor: HistoryInteractorInput) {
        self.view = view
        self.interactor = interactor
    }
}

//MARK: - HistoryViewOutput
extension HistoryPresenter: HistoryViewOutput {
    
    func searchTextDidChange(_ searchText: String) {
        let filteredItems: [TranslationEntity]
        if searchText.isEmpty {
            filteredItems = interactor.fetchTranslations()
        } else {
            filteredItems = interactor.fetchTranslations().filter {
                $0.sourceText?.localizedCaseInsensitiveContains(searchText) == true ||
                $0.translatedText?.localizedCaseInsensitiveContains(searchText) == true
            }
        }
        view.updateData(filteredItems)
    }
    
    func viewDidLoad() {
        view.updateData(interactor.fetchTranslations())
    }
    
    func deleteAllItems() {
        interactor.clearTranslations()
        viewDidLoad()
    }
}
