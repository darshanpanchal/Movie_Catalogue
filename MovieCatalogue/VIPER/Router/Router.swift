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
typealias MovieSearchEntryPoint = MovieSearchView & UIViewController

protocol MovieRouter{
    static func loadMovies() -> MovieRouter
    static func loadMovieDetails() -> MovieRouter
    static func loadMovieSearch() -> MovieRouter
    var entry:EntryPoint? {get set}
    var entrydetail:DetailEntryPoint? {get set}
    var entrySearch:MovieSearchEntryPoint? {get set}
}

class MovieListRouter:MovieRouter{
    
    
    var entrySearch: MovieSearchEntryPoint?
    
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
    
    static func loadMovieSearch() -> MovieRouter {
        let objrouter = MovieListRouter()
        //VIP
        //View
        let mainstoryBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if var movieDetailViewController:MovieSearchView = mainstoryBoard.instantiateViewController(withIdentifier: "MovieSearchViewController") as? MovieSearchView{
            //Interactor
            var objinteractor:MovieSearchInteractor = MovieSearchResultInteractor()
            //Presenter
            var objpresenter:MovieSearchPresenter = MovieSearchDetailsPresenter()
            //View To presenter
            movieDetailViewController.presenter = objpresenter
            
            //Interactor to presenter
            objinteractor.presenter = objpresenter
            
            //Assign to presenter
            objpresenter.view = movieDetailViewController
            objpresenter.interactor = objinteractor
            objpresenter.router = objrouter
            
            
            objrouter.entrySearch = movieDetailViewController as?  MovieSearchEntryPoint
        }
        return objrouter
    }
}

