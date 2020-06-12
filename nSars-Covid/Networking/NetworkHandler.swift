//
//  NetworkHandler.swift
//  nSars-Covid
//
//  Created by Subhash Tummala on 4/30/20.
//  Copyright © 2020 Subhash Tummala. All rights reserved.
//

import Foundation
import UIKit


class NetworkHandler {
    
    let baseURL = "https://coronavirus-19-api.herokuapp.com/"
    //var stats:GlobalStats!
    //let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: .main)
    
    
    fileprivate func buildURL(requestParam: String) -> URL {
        return URL(string: baseURL + requestParam)!
    }
    
    fileprivate func buildURLRequest(requestParam: String) -> URLRequest {
        var request = URLRequest(url: buildURL(requestParam: requestParam))
        request.httpMethod = "GET"
        return request
    }
    
    public func fetchStats(completion: @escaping (_ stats:GlobalStats) -> ()){
        URLSession.shared.dataTask(with: buildURL(requestParam: "all"), completionHandler: { (data, response, error) in
            if let data = data {
                if let decodedResp =  try? JSONDecoder().decode(GlobalStats.self, from: data) {
                    //let somedata = GlobalStats()
                    //print(String(describing: somedata))
                    completion(decodedResp)
                }
            }
        }).resume()
    }
    
    public func fetchCountryData(path:String, completion: @escaping (_ countries: Country) -> ()){
        URLSession.shared.dataTask(with: buildURL(requestParam: "countries/Australia"), completionHandler: { (data, response, error) in
            //print("service data: "+String(describing: try? self.decoder.decode([Countries].self, from: data!)))
            guard let respData = data else {
                return
            }
            
            print(String(describing: respData))
            
            if let decodeJsonData = try? JSONDecoder().decode(Country.self, from: respData) {
                print("decodeJsonData: "+String(describing: decodeJsonData))
                completion(decodeJsonData)
            }
            
        }).resume()
    }
    
    public func fetchCountries(completion: @escaping (_ countries: [Country]?) -> ()){
        URLSession.shared.dataTask(with: buildURL(requestParam: "countries"), completionHandler: { (data, response, error) in
            //print("service data: "+String(describing: try? self.decoder.decode([Countries].self, from: data!)))
            guard let respData = data else {
                return
            }
            
            print(String(describing: response))
            do{
                let decodeJsonData = try JSONDecoder().decode([Country].self, from: respData)
                print("decodeJsonData: "+String(describing: decodeJsonData))
                completion(decodeJsonData)
                
            } catch {
                print(error)
            }
            
        }).resume()
    }
}


