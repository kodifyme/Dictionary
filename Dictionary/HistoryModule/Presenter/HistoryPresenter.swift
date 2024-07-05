//
//  HistoryPresenter.swift
//  Dictionary
//
//  Created by KOДИ on 05.07.2024.
//

import UIKit

class HistoryPresenter {
    
    private let view = HistoryView()
    private let interactor = HistoryInteractor()
}

extension HistoryPresenter: HistoryViewOutput {
    func searchTextDidChange(_ searchText: String) {
        if searchText.isEmpty {
            interactor.filteredItems = interactor.allItems
        } else {
            interactor.filteredItems = interactor.allItems.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
        view.updateData(interactor.filteredItems)
    }
}
