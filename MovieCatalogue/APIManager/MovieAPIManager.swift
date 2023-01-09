//
//  MovieAPIManager.swift
//  MovieCatalogue
//
//  Created by Darshan on 30/12/22.
//

import Foundation
import Alamofire


enum MovieAPI {
    case GETMovieAPI
    case GETMovieDetailAPI
    case GETMovieReviewAPI
    case GETSimilarMovieAPI
    case GETCaseCrewAPI
}
extension MovieAPI: EndPointType {
   
    var httpMethod: HTTPMethod {
        switch self {
        case .GETMovieAPI:
            return .get
        case .GETMovieDetailAPI:
            return .get
        case .GETMovieReviewAPI:
            return .get
        case .GETSimilarMovieAPI:
            return .get
        case .GETCaseCrewAPI:
            return .get
        default:
            return .post
        }
    }
    
    var version: String {
        return "1"
    }
    
    var path: String {
        switch self {
        case .GETMovieAPI:
            return "now_playing"
        case .GETMovieDetailAPI:
            return "moviedetail"
        case .GETMovieReviewAPI:
            return "review"
        case .GETSimilarMovieAPI:
            return "similar"
        case .GETCaseCrewAPI:
            return "credits"
        }}
}
class MovieAPIManager{
    
    func requestMovieListDetails(input: Parameters?, handler: @escaping (_ result: MovieListDataBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: MovieAPI.GETMovieAPI, params: input) { (result: MovieListDataBase?, message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    
    func requestMovieDetailsAPI(input: Parameters?, handler: @escaping (_ result: MovieDetailDataBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: MovieAPI.GETMovieDetailAPI, params: input) { (result: MovieDetailDataBase?, message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    func requestMovieReviewAPI(input: Parameters?, handler: @escaping (_ result: MovieReviewBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: MovieAPI.GETMovieReviewAPI, params: input) { (result: MovieReviewBase?, message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    func requestSimilarMovieAPI(input: Parameters?, handler: @escaping (_ result: SimilarMovieBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: MovieAPI.GETSimilarMovieAPI, params: input) { (result: SimilarMovieBase?, message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
    func requestMovieCastCrewAPI(input: Parameters?, handler: @escaping (_ result: MovieCaseCrewBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: MovieAPI.GETCaseCrewAPI, params: input) { (result: MovieCaseCrewBase?, message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
}
