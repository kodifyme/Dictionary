//
//  TranslateBuilder.swift
//  Dictionary
//
//  Created by KOДИ on 25.06.2024.
//

import UIKit

class TranslateBuilder {
    
    static func assembly() -> UIViewController {
        let view = TranslateView()
        let networkService = NetworkService.shared
        let interactor = TranslateInteractor(networkService: networkService)
        let router = TranslateRouter()
        let presenter = TranslatePresenter(view: view, interactor: interactor, router: router)
        
        view.output = presenter
        interactor.output = presenter
        router.rootViewController = view
        return view
    }
}
