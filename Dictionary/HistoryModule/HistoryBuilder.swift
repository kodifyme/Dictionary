//
//  HistoryBuilder.swift
//  Dictionary
//
//  Created by KOДИ on 04.07.2024.
//

import UIKit

class HistoryBuilder {
    
    static func assembly() -> UIViewController {
        let view = HistoryView()
        let interactor = HistoryInteractor()
        let presenter = HistoryPresenter(view: view, interactor: interactor)
        
        view.output = presenter
        
        return view
    }
}
