//
//  Router.swift
//  MovieCatalogue
//
//  Created by Darshan on 29/12/22.
//

import Foundation
import UIKit

typealias EntryPoint = MovieView & UIViewController
typealias DetailEntryPoint = MovieDetailView &  UIViewController

protocol MovieRouter{
    static func loadMovies() -> MovieRouter
    static func loadMovieDetails() -> MovieRouter
    var entry:EntryPoint? {get set}
    var entrydetail:DetailEntryPoint? {get set}
    
}

class MovieListRouter:MovieRouter{
    var entrydetail: DetailEntryPoint?
    
    
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
    
    static func loadMovieDetails() -> MovieRouter {
        let objrouter = MovieListRouter()
        //VIP
        //View
        let mainstoryBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if var movieDetailViewController:MovieDetailView = mainstoryBoard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailView{
            //Interactor
            var objinteractor:MovieDetailInteractor = MovieDetailsInteractor()
            //Presenter
            var objpresenter:MovieDetailPresenter = MovieDetailsPresenter()
            //View To presenter
            movieDetailViewController.presenter = objpresenter
            
            //Interactor to presenter
            objinteractor.presenter = objpresenter
            
            //Assign To presenter
            objpresenter.router = objrouter
            objpresenter.view = movieDetailViewController
            objpresenter.interactor = objinteractor
            
            objrouter.entrydetail = movieDetailViewController as? DetailEntryPoint
        }
        
          
        return objrouter
    }
}

