//
//  AlertManager.swift
//  Dictionary
//
//  Created by KOДИ on 16.07.2024.
//

import UIKit

class AlertManager {
    
    static let shared = AlertManager()
    
    private init() {}
    
    func historyClear(from controller: UIViewController, completionHandler: @escaping () -> Void) {
        
        let alertController = UIAlertController(title: "Clear History", message: "Are you sure you want to clear the history?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Выйти", style: .cancel) { _ in
            completionHandler()
        }
        
        let clearAction = UIAlertAction(title: "Clear", style: .destructive) { _ in
            completionHandler()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(clearAction)
        controller.present(alertController, animated: true)
    }
}
