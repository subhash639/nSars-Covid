//
//  GlobalStats.swift
//  nSars-Covid
//
//  Created by Subhash Tummala on 4/30/20.
//  Copyright © 2020 Subhash Tummala. All rights reserved.
//

import Foundation

struct GlobalStats:Decodable {
    var cases:Int
    var deaths:Int
    var recovered:Int
}

