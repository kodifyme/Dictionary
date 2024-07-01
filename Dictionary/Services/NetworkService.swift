//
//  NetworkService.swift
//  Dictionary
//
//  Created by KOДИ on 30.06.2024.
//

import Foundation

struct Constants {
    static let API_KEY = "AQVN0VAW9GfpClGw1_oxyHbD0DgqTyxTHxvIOS-x"
    static let baseURLPath = "https://translate.api.cloud.yandex.net/translate/v2/translate"
    static let folderID = "b1gt5798gsiq4fm29lhc"
    static let format = "PLAIN_TEXT"
}

class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    private lazy var mainURL: URL? = {
        URL(string: Constants.baseURLPath)
    }()
    
    func fetchTranslation(for text: String, from sourceLanguage: String?, to targetLanguage: String, completion: @escaping (Result<Translation, Error>) -> Void) {
        
        guard let mainURL else { return }
        
        let translationRequest = TranslationRequest(
            sourceLanguageCode: sourceLanguage,
            targetLanguageCode: targetLanguage,
            format: Constants.format,
            texts: [text],
            folderID: Constants.folderID
        )
        
        var request = URLRequest(url: mainURL)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Authorization": "API-KEY \(Constants.API_KEY)"
        ]

        do {
            let jsonData = try JSONEncoder().encode(translationRequest)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data, error == nil else {
                return completion(.failure(error!))
            }
            
            let responseDataString = String(data: data, encoding: .utf8)
            print("Response Data: \(responseDataString ?? "No response data")")
            
            do {
                let translationResponse = try JSONDecoder().decode(TranslationResponse.self, from: data)
                DispatchQueue.main.async {
                    if let translation = translationResponse.translations.first {
                        completion(.success(translation))
                    } else {
                        completion(.failure(error!))
                    }
                }
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
