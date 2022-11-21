//
//  Animal.swift
//  ZooManagementApp
//
//  Created by Hasan Esat Tozlu on 18.11.2022.
//

import UIKit

class Animal {
    let animalBreed: String
    let waterConsumption: Double
    let sound: String
    let keeper: ZooKeeper?
    var count: Int
    var image: UIImage?
    var totalWaterConsumption: Double? {
        return Double(count) * waterConsumption
    }
    
    init(animalBreed: String, waterConsumption: Double, sound: String, image: UIImage?, count: Int = 1, keeper: ZooKeeper? = nil) {
        self.animalBreed        = animalBreed
        self.waterConsumption   = waterConsumption
        self.sound              = sound
        self.keeper             = keeper
        self.count              = count
        self.image              = image
        
        giveResponsibility()
    }
    
    // Hayvan oluştuktan sonra belirtilen keeper a yetki verilir
    private func giveResponsibility() {
        guard let keeper = keeper else { return }
        var isAnimalFound: Bool = false
        if var animals = keeper.animals {
            for animal in animals {
                if animal.animalBreed.lowercased() == animalBreed.lowercased() {
                    isAnimalFound = true
                    break
                }
            }
            if !isAnimalFound {
                animals.append(self)
                keeper.animals = animals
            }
        } else {
            var animals = [Animal]()
            animals.append(self)
            keeper.animals = animals
        }
    }
}
