//
//  Router.swift
//  MovieCatalogue
//
//  Created by Darshan on 29/12/22.
//

import Foundation
import UIKit

typealias EntryPoint = MovieView & UIViewController
protocol MovieRouter{
    static func loadMovies() -> MovieRouter
    var entry:EntryPoint? {get set}
    
}

class MovieListRouter:MovieRouter{
    
    var entry: EntryPoint?
    
    static func loadMovies() -> MovieRouter {
        let objrouter = MovieListRouter()
        //VIP
        //View
        let mainstoryBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if var movieListViewController:MovieView = mainstoryBoard.instantiateViewController(withIdentifier: "MovieListViewController") as? MovieView{
            //Interactor
            var objinteractor:MovieInteractor = MovieListInteractor()
            //Presenter
            var objpresenter:MoviePresenter = MovieListPresenter()
            //View To presenter
            movieListViewController.presenter = objpresenter
            
            //Interactor to presenter
            objinteractor.presenter = objpresenter
            
            //Assign To presenter
            objpresenter.router = objrouter
            objpresenter.view = movieListViewController
            objpresenter.interactor = objinteractor
            
            objrouter.entry = movieListViewController as? EntryPoint
        }
        
          
        return objrouter
    }
}

