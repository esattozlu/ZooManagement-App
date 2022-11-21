//
//  ZooKeeper.swift
//  ZooManagementApp
//
//  Created by Hasan Esat Tozlu on 18.11.2022.
//

import UIKit

class ZooKeeper {
    let name: String
    var keeperId: Int
    var age: Int
    var animals: [Animal]? // Optional ✅
    // sorumlu olunan hayvan türü başına 0,05 kat sayısı ile maaş hesabı yapar(baz maaş: 7000₺)
    var salary: Double {    // computed property ✅
        (1 + Double(age)/100) * 7000
    }
    
    init(name: String, keeperId: Int, age: Int){
        self.name       = name
        self.keeperId   = keeperId
        self.age        = age
    }
    
    static func calculateSalary(age: Int) -> Double {
        return (1 + Double(age)/100) * 7000
    }
}
