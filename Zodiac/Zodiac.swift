//
//  Zodiac.swift
//  Zodiac
//
//  Created by MacBook Pro on 6/3/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import UIKit

class zodiac {
    var name : String
    var monthStart : Int
    var dayStart : Int
    var monthEnd : Int
    var dayEnd : Int
    init(name: String, dayStart: Int, monthStart: Int, dayEnd: Int, monthEnd : Int) {
        self.name = name
        self.dayStart = dayStart
        self.monthStart = monthStart
        self.dayEnd = dayEnd
        self.monthEnd = monthEnd
    }
}
