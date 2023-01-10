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

//-------
protocol MovieView{
    var presenter:MoviePresenter? {get set}
    
    func update(with movies:[MovieResults])
    func update(with error:String)
}
//------
protocol MovieDetailView{
    var presenter:MovieDetailPresenter? {get set}
    func updatewithMovieDetails(movie:MovieDetailDataBase)
    func updatewithMovieReview(movie:MovieReviewBase)
    func updatewithSimilarMovie(movie:SimilarMovieBase)
    func updatewithMovieCast(movie:MovieCaseCrewBase)
    
    func update(with error:String)
}
//------
protocol MovieSearchView{
    var presenter:MovieSearchPresenter? {get set}
    
    func updatewithMovieSearchDetails(movies:[MovieResults])
    func update(with error:String)
}
