//
//  DailyProtocol.swift
//  AlphaVantageShowcase
//
//  Created by Ganang Arief Pratama on 09/01/21.
//

import UIKit

protocol DailyViewControllerProtocol: class {
    func displayDailyResponse(withResponse response: DailyResponse)
    func displayDailyError(withError error: Error)
}

protocol DailyPresenterProtocol: class {
    var interactor: DailyInteractorProtocol? { get set }
    var view: DailyViewControllerProtocol? { get set }
    var wireframe: DailyWireframeProtocol? { get set }
    
    func getDaily(withParams params: [String: String])
    func displayDailyResponse(withResponse response: DailyResponse)
    func displayDailyError(withError error: Error)
}

protocol DailyInteractorProtocol: class {
    var presenter: DailyPresenterProtocol? { get set }
    
    func getDaily(withParams params: [String: String])
}

protocol DailyWireframeProtocol: class {
    
}
