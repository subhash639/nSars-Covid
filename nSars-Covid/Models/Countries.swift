//
//  Countries.swift
//  nSars-Covid
//
//  Created by Subhash Tummala on 5/1/20.
//  Copyright © 2020 Subhash Tummala. All rights reserved.
//

import Foundation

struct Countries:Decodable {
    
    var countries:[Country]
    
    init(from decoder:Decoder) throws {
        countries = [Country]()
        var container = try decoder.unkeyedContainer()
        
        while !container.isAtEnd {
            if let country = try? container.decode(Country.self){
                countries.append(country)
            }
        }
    }
    
}

struct Country:Decodable {
    var country:String
    var cases:Int
    var todayCases:Int
    var deaths:Int
    var todayDeaths:Int
    var recovered:Int?
    var active:Int?
    var critical:Int
    var casesPerOneMillion:Int
    var deathsPerOneMillion:Int
    var totalTests:Int
    var testsPerOneMillion:Int
}
