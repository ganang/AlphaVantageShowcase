//
//  LocalStorageService.swift
//  AlphaVantageShowcase
//
//  Created by Ganang Arief Pratama on 09/01/21.
//

import Foundation

class LocalStorageService {
    
    static let shared = LocalStorageService()
    
    // USER DEFAULT
    let defaults = UserDefaults.standard
    
    // get interval on local storage
    func getInterval() -> String {
        
        guard let interval = defaults.string(forKey: "interval") else {
            return "15min"
        }
        
        return interval
    }
    
    // set interval
    func setInterval(interval: String) {
        defaults.set(interval, forKey: "interval")
        defaults.synchronize()
    }
    
    func cleanInterval(){
        defaults.set(nil, forKey: "interval")
        defaults.synchronize()
    }
    
    func getOutputSize() -> String {
        
        guard let outputsize = defaults.string(forKey: "outputsize") else {
            return "compact"
        }
        
        return outputsize
    }
    
    // set outputsize
    func setOutputSize(outputsize: String) {
        defaults.set(outputsize, forKey: "outputsize")
        defaults.synchronize()
    }
    
    func cleanOutputSize(){
        defaults.set(nil, forKey: "outputsize")
        defaults.synchronize()
    }
    
    func setApikey(withApiKey apikey: String, withKey key: String) {
        KeychainWrapper.standard.set(apikey, forKey: key)
    }
    
    func getApikey() -> String {
        let apikey = KeychainWrapper.standard.string(forKey: "apikey")
        
        return apikey ?? ""
    }
}
