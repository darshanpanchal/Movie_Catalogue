//
//  APIManager.swift
//  MovieCatalogue
//
//  Created by Darshan on 30/12/22.
//


import Foundation
import Alamofire
import UIKit

class NetworkManager {
    
    class func isConnected() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

extension URL {
    /// Returns a new URL by adding the query items, or nil if the URL doesn't support it.
    /// URL must conform to RFC 3986.
    func appending(_ queryItems: [URLQueryItem]) -> URL? {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            // URL is not conforming to RFC 3986 (maybe it is only conforming to RFC 1808, RFC 1738, and RFC 2732)
            return nil
        }
        // append the query items to the existing ones
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems
        
        // return the url from new url components
        return urlComponents.url
    }
}
enum NetworkEnvironment {
    case dev
    case production
    case stage
}

protocol EndPointType {
    
    //MARK: vars and lets
    var baseURL : String { get }
    var path : String { get }
    var httpMethod : HTTPMethod  { get }
    var url : URL { get }
    var encoding : ParameterEncoding { get }
    var version : String { get }
}

extension EndPointType {
    //Mark: - vars and lets
    
    var baseURL : String {
        switch APIManager.networkEnviroment {
        case .dev: return Constant.kBaseURL //Config url here
        case .production : return ""
        case .stage : return ""
        }
    }
    
    var headers: HTTPHeaders? {
        return .init([
            "Content-type": "application/json",
            "Accept": "application/json"
        ])
    }
    var url : URL {
        switch self {
        default:
            let encodeURL : String = (self.baseURL + self.path).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            return URL(string: encodeURL)!
        }
    }
    
    var encoding : ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
}

class AlertMessage:Error {
    var statusCode : Int = 0
    var errorMessage : String = ""
    
    /*private func parseApiError(data: Data?) -> AlertMessage {
     let decoder = JSONDecoder()
     if let jsonData = data, let error = try? decoder.decode(ErrorObject.self, from: jsonData) {
     //return AlertMessage(title: "Test", body: error.key?.localized() ?? error.message)
     
     }
     return AlertMessage(title: Constants.errorAlertTitle.localized(), body: Constants.genericErrorMessage)
     }*/
}

class ErrorObject: Codable {
    
    let message: String
    let key: String?
    
}

class APIManager {
    
    private var sessionManager: Session
    static let networkEnviroment: NetworkEnvironment = .dev
    
    // MARK: - Vars & Lets
    
    private static var sharedApiManager: APIManager = {
        let apiManager = APIManager(sessionManager: Session())
        
        return apiManager
    }()
    
    // MARK: - Accessors
    
    class func shared() -> APIManager {
        return sharedApiManager
    }
    
    // MARK: - Initialization
    
    private init(sessionManager: Session) {
        self.sessionManager = sessionManager
    }
    func checkForQueryParameters(type: EndPointType, params: Parameters? = nil)->(URL,Parameters?){
        if type.httpMethod == .get,let input = params{
            if type.path != MovieAPI.GETMovieAPI.path{
                var detailID = ""
                for value in input{
                    detailID = "\(value.value)"
                }
                let strurl = "\(type.url.absoluteString)\(detailID)"
                if let objURL = URL.init(string: strurl){
                    return (objURL,nil)
                }else{
                    return (type.url,nil)
                }
            }else{
                let url = type.url
                var queryItems:[URLQueryItem] = []
                for value in input{
                    queryItems.append(URLQueryItem.init(name: value.key, value: "\(value.value)"))
                }
                if let newURl = url.appending(queryItems){
                    return (newURl,nil)
                }else{
                    return (type.url,params)
                }
            }
        } else{
            return (type.url,params)
        }
    }
    func call<T>(type: EndPointType, params: Parameters? = nil, handler: @escaping (T?, _ error: AlertMessage?)->()) where T: Decodable {
        
        if NetworkManager.isConnected() {
            //
            viewControllerUtils.showLoader()
            //
            self.sessionManager.session.configuration.timeoutIntervalForRequest = 60
            
            let queryparameterURlParam = self.checkForQueryParameters(type: type, params: params)
            print("url:", queryparameterURlParam.0)
            print("method:", type.httpMethod)
            print("param:",params ?? [:])
            
            print("Header", type.headers ?? [:])
            self.sessionManager.request(queryparameterURlParam.0,
                                        method: type.httpMethod,
                                        parameters: queryparameterURlParam.1,
                                        encoding: type.encoding,
                                        headers: type.headers).validate().responseJSON { data in
                //
                viewControllerUtils.hideLoader()
                //
                switch data.result {
                case .success(_):
                    
                    let decoder = JSONDecoder()
                    if let jsonData = data.data {
                        do {
                            
                            let jsonDict = try JSONSerialization.jsonObject(with: jsonData) as? NSDictionary
                            print("Response:", jsonDict ?? [:])
                            if jsonDict?["statusCode"] as? Int ?? 0 == 401 {
                               // self.callLogoutAndRedirectToWelcomeScreen()
                            }else{
                                let result = try decoder.decode(T.self, from: jsonData)
                                handler(result, nil)
                            }
                        } catch let error {
                            handler(nil, ErrorMessage(message: error.localizedDescription, status: 0))
                        }
                    }else{
                        handler(nil, nil)
                    }
                case .failure(let error):
                    
                    switch error.responseCode {
                        
                    case 401:
                        //                                                    self.callLogoutAndRedirectToWelcomeScreen()
//                        UserSession.shared.callRefreshTokenApi { (status) in
//                            if status {
//                                APIManager.shared().call(type: type, params: params) { (resu: T?,message: AlertMessage?) in
//                                    if let result = resu {
//                                        handler(result, nil)
//                                        
//                                    } else {
//                                        handler(nil, message!)
//                                    }
//                                }
//                            } else {
//                                self.callLogoutAndRedirectToWelcomeScreen()
//                            }
//                            
//                        }
                        break
                        
                    default:
                        let decoder = JSONDecoder()
                        if let jsonData = data.data {
                            do {
                                
                                let jsonDict = try JSONSerialization.jsonObject(with: jsonData) as? NSDictionary
                                print("Response:", jsonDict ?? [:])
                                
                                let result = try decoder.decode(T.self, from: jsonData)
                                handler(result, nil)
                            } catch let error {
                                handler(nil, ErrorMessage(message: error.localizedDescription, status: 0))
                            }
                        }else {
                            handler(nil, ErrorMessage(message: error.localizedDescription, status: 0))
                        }
                        break
                        
                    }
                    
                }
            }
        }else {
            viewControllerUtils.hideLoader()
            handler(nil, ErrorMessage(message: "Please Check Your Internet Connectivity", status: 0))
        }
    }
    
  
    
   
}


class ErrorMessage: AlertMessage {
    
    init(message: String, status: Int) {
        super.init()
        
        self.errorMessage = message
        self.statusCode = status
    }
}
