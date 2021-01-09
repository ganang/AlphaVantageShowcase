//
//  ApiManager.swift
//  AlphaVantageShowcase
//
//  Created by Ganang Arief Pratama on 08/01/21.
//

import UIKit

public class StockProvider: StockService {
    
    public static let shared = StockProvider()
    private init() {}
    
    // get api key and base url from user defined setting
    private let baseUrl = "https://www.alphavantage.co"
//    private let apiKey = "61F1SVWHXJH7NI2E"
    private let apiKey = KeychainWrapper.standard.string(forKey: "apikey")
    
    private let urlSession = URLSession.shared
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    
    // MARK: get daily stock
    func getDailyStock(endpoint: StockEndpoint, params: [String : String]?, onSuccess: @escaping (DailyResponse) -> Void, onError: @escaping (Error) -> Void) {
        self.handeRequest(requestedObjectType: DailyResponse.self, endpoint: "/\(endpoint.rawValue)", params: params, onSuccess: onSuccess, onError: onError)
    }
    
    // MARK: get intra-day stock
    func getIntraDayStock(endpoint: StockEndpoint, params: [String : String]?, onSuccess: @escaping (IntraDayResponse) -> Void, onError: @escaping (Error) -> Void) {
        self.handeRequest(requestedObjectType: IntraDayResponse.self, endpoint: "/\(endpoint.rawValue)", params: params, onSuccess: onSuccess, onError: onError)
    }
    
    // function for handling api Request with generic type, so it can always be used later
    private func handeRequest<T:Codable>(requestedObjectType:T.Type, endpoint: String, params: [String : String]?, onSuccess: @escaping (T) -> Void, onError: @escaping (Error) -> Void){
        
        guard var urlComponents = URLComponents(string: "\(self.baseUrl)\(endpoint)") else {
            onError(StockError.invalidEndpoint)
            return
        }
        
        var queryItems = [URLQueryItem(name: "apikey", value: apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            onError(StockError.invalidEndpoint)
            return
        }
        
        print(url)
        
        urlSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.errorHandler(onErrorCallback: onError, error: StockError.errorFromApi)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.errorHandler(onErrorCallback: onError, error: StockError.invalidResponse)
                return
            }
            
            guard let data = data else {
                self.errorHandler(onErrorCallback: onError, error: StockError.noData)
                return
            }
            
            do {
                
                let response = try self.jsonDecoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    onSuccess(response)
                }
            } catch let DecodingError.dataCorrupted(context) {
                self.errorHandler(onErrorCallback: onError, error: StockError.invalidResponse)
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                self.errorHandler(onErrorCallback: onError, error: StockError.invalidResponse)
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                self.errorHandler(onErrorCallback: onError, error: StockError.invalidResponse)
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                self.errorHandler(onErrorCallback: onError, error: StockError.invalidResponse)
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                self.errorHandler(onErrorCallback: onError, error: StockError.invalidResponse)
                print("error: ", error)
            }
        }.resume()
    }
    
    // handle error here
    private func errorHandler(onErrorCallback: @escaping(_ error: Error) -> Void, error: Error) {
        DispatchQueue.main.async {
            onErrorCallback(error)
        }
    }
    
}
