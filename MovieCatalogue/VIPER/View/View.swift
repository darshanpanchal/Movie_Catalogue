//
//  View.swift
//  MovieCatalogue
//
//  Created by Darshan on 29/12/22.
//

import Foundation
// ViewController
// Protocol
// Reference Presenter


protocol MovieView{
    var presenter:MoviePresenter? {get set}
    
    func update(with movies:[MovieResults])
    func update(with error:String)
}
