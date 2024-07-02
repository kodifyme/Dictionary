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
        let interactor = TranslateInteractor()
        var router: TranslateRouterInput = TranslateRouter()
        
        // warning: strong links
        let presenter = TranslatePresenter(view: view, interactor: interactor, router: router)
        
        view.output = presenter
        interactor.output = presenter
        router.rootViewController = view
        
        router.presenter = presenter
        return view
    }
}
