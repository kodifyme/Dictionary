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
}

class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    private lazy var mainURL: URL? = {
        URL(string: Constants.baseURLPath)
    }()
    
    func fetchTranslation(for text: String, from sourceLanguage: String?, to targetLanguage: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        guard let mainURL else { return }
        
        let translationRequest = TranslationRequest(
            sourceLanguageCode: sourceLanguage,
            targetLanguageCode: targetLanguage,
            format: "PLAIN_TEXT",
            texts: [text],
            folderID: Constants.folderID
        )
        
        var request = URLRequest(url: mainURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("API-KEY \(Constants.API_KEY)", forHTTPHeaderField: "Authorization")

        do {
            let jsonData = try JSONEncoder().encode(translationRequest)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
                if httpResponse.statusCode == 401 {
                    completion(.failure(NSError(domain: "Unauthorized", code: 401, userInfo: nil)))
                    return
                }
            }
            
            let responseDataString = String(data: data, encoding: .utf8)
            print("Response Data: \(responseDataString ?? "No response data")")
            
            do {
                let translationResponse = try JSONDecoder().decode(TranslationResponse.self, from: data)
                DispatchQueue.main.async {
                    if let translation = translationResponse.translations.first?.text {
                        completion(.success(translation))
                    } else {
                        completion(.failure(NSError(domain: "Invalid response format", code: -1, userInfo: nil)))
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
