//
//  IntraDayWireframe.swift
//  AlphaVantageShowcase
//
//  Created by Ganang Arief Pratama on 08/01/21.
//

import UIKit

protocol IntraDayViewControllerProtocol: class {
    func displayIntraDayResponse(withResponse response: IntraDayResponse)
}

protocol IntraDayPresenterProtocol: class {
    var interactor: IntraDayInteractorProtocol? { get set }
    var view: IntraDayViewControllerProtocol? { get set }
    var wireframe: IntraDayWireframeProtocol? { get set }
    
    func getIntraDay(withParams params: [String: String])
    func displayIntraDayResponse(withResponse response: IntraDayResponse)
}

protocol IntraDayInteractorProtocol: class {
    var presenter: IntraDayPresenterProtocol? { get set }
    
    func getIntraDay(withParams params: [String: String])
}

protocol IntraDayWireframeProtocol: class {
    
}
