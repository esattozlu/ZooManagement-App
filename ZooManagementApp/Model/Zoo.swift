//
//  Zoo.swift
//  ZooManagementApp
//
//  Created by Hasan Esat Tozlu on 18.11.2022.
//

import UIKit

protocol ZooCreator { // Protocol ✅
    func addIncome(amount: Double)
    func addExpense(amount: Double, completion: (String?) -> ())
    func getNewAnimal(animalBreed: String, waterConsumption: Double, sound: String, keeper: ZooKeeper, count: Int, image: UIImage?, completion: (_ error: String?) -> ())
    func hireZooKeeper(keeper: ZooKeeper, completion: (String?) -> ())
    func paySalary(completion: (String) -> ())
}

class Zoo: ZooCreator {
    
    var zooName: String
    var waterLimit: Double
    var budget: Double
    var logo: UIImage?
    var animals: [Animal]?  // Optional ✅
    var keepers: [ZooKeeper]?   // Optional ✅
    var totalSalary: Double {
        var totalSalary: Double = 0
        if let keepers = keepers, !keepers.isEmpty{
            keepers.forEach{ totalSalary += $0.salary }
            return totalSalary
        }
        return totalSalary
    }
        
    var remainingLimit: Double {    // computed property ✅
        guard let animals = animals else { return waterLimit }
        var totalConsumption: Double = 0
        animals.forEach{ totalConsumption += $0.waterConsumption * Double($0.count)}
        return waterLimit - totalConsumption
    }
    
    // Hayvanat bahçesi oluşturur
    init(zooName: String, waterLimit: Double, budget: Double, logo: UIImage?) {
        self.waterLimit     = waterLimit
        self.budget         = budget
        self.zooName        = zooName
        self.logo           = logo
        print("\(zooName) Zoo is created with \(waterLimit) water limit, \(budget)₺ budget.")
    }
    
    // Gelir eklemek için kullanılır
    func addIncome(amount: Double) {
        let previousBudget  = budget
        budget             += amount
        print("Income is added. Previos budget: \(previousBudget)₺, new budget: \(budget)₺")
    }
    
    // Gider eklemek için kullanılır
    func addExpense(amount: Double, completion: (String?) -> ()) {
        // eğer budget'da yeterli para yoksa uyarı verir ve gider oluşmaz.
        if budget >= amount {
            let previousBudget  = budget
            budget             -= amount
            print("Expense is added. Previos budget: \(previousBudget)₺, new budget: \(budget)₺")
        } else {
            let message = "There is not enough money to pay expense. Please add income to budget case."
            completion(message)
        }
    }
    
    // Su limitini revise eder
    func reviseWaterLimit(limit: Double) {
        waterLimit = limit
        print("Water limit is changed to \(waterLimit)")
    }
    
    // Su limitini belirtilen miktarda arttırır
    func increaseWaterLimit(amount: Double) {
        waterLimit += amount
        print("Water limit is increased by \(amount) to \(waterLimit)")
    }
    
    // Maaşları öder
    func paySalary(completion: (String) -> ()) { // Closure ✅
        var message = String()
        if let keepers = keepers, !keepers.isEmpty{
            
            if budget >= totalSalary {
                budget -= totalSalary
                message = "\(totalSalary.formattedWithSeparator)₺ keeper salaries are paid. Remaining budget: \(budget.formattedWithSeparator)₺."
                completion(message)
            } else {
                // eğer budget'da maaşlar için yeterli para yoksa uyarı verir ve gider oluşmaz.
                message = "There is not enough money to pay salaries. Please add income to budget case."
                completion(message)
            }
        } else {
            message = "There is no keeper to pay salary."
            completion(message)
        }
    }
    
    // yeni hayvan alır
    func getNewAnimal(animalBreed: String, waterConsumption: Double, sound: String, keeper: ZooKeeper, count: Int, image: UIImage?, completion: (_ error: String?) -> ()) {
        var message = ""
        var breedCheck = true
        
        guard waterConsumption * Double(count) <= remainingLimit else {
            message = "Remaining water limit of zoo is not enough to get \(count) \(animalBreed). Please increase the water limit at least \((waterConsumption * Double(count) - remainingLimit).formattedWithSeparator)."
            completion(message)
            return
        }
        
        
        if var animals = animals {
            // Hayvan eklenirken, eklemek istenen türe ve tipe sahip daha önce bir hayvan olup olmadığı kontrolü.
            animals.forEach{
                if $0.animalBreed.lowercased() == animalBreed.lowercased() {
                    message = "There is already an animal with breed: \(animalBreed). Please click Increase Animal Count button."
                    breedCheck = false
                    completion(message)
                    return
                }
            }
            // eğer eklenen aynı breed'e sahip hayvan varsa fonksiyonu devam ettirmemek için guard
            guard breedCheck else { return }
            
            let animal = Animal(animalBreed: animalBreed, waterConsumption: waterConsumption, sound: sound, image: image, count: count, keeper: keeper)
            animals.append(animal)
            self.animals = animals
        } else {
            var animals = [Animal]()
            let animal = Animal(animalBreed: animalBreed, waterConsumption: waterConsumption, sound: sound, image: image, count: count, keeper: keeper)
            animals.append(animal)
            self.animals = animals
        }
        
        print("\(animalBreed) breed animal is added.")
        completion(nil)
    }
    
    // yeni bakıcı işe alır
    func hireZooKeeper(keeper: ZooKeeper, completion: (String?) -> ()) {
        var idCheck = true
        var message = ""
        
        if var keepers = keepers {
            // Keeper eklenirken, eklemek istenen id'ye sahip daha önce bir keeper olup olmadığı kontrolü.
            keepers.forEach{
                if $0.keeperId == keeper.keeperId {
                    message = "There is already a keeper with id: \(keeper.keeperId). Please try another id."
                    completion(message)
                    idCheck = false
                    return
                }
            }
            // eğer eklenen id'li keeper varsa fonksiyonu devam ettirmemek için guard
            guard idCheck else { return }
            
            keepers.append(keeper)
            self.keepers = keepers
        } else {
            var keepers = [ZooKeeper]()
            keepers.append(keeper)
            self.keepers = keepers
        }
        
        print("Keeper \(keeper.name) is hired.")
    }
    
    // Kalan su limiti yazdırılır
    func askRemainingWaterLimit() {
        print("Remaining water limit:", remainingLimit)
    }
    
    
    //mevcut hayvan sayısı arttırılmak istendiğinde kullanılır
    func addToExisting(animalBreed: String, count: Int, completion: (String?) -> ()) {
        var animalFound = false
        var message = ""
        
        guard let animals = animals else {
            message = "There is no animal in the zoo. Please use Create Animal button."
            completion(message)
            return
        }
        
        for (index, animal) in animals.enumerated() {
            // Böyle bir hayvan olup olmadığı incelenir
            if animalBreed.lowercased() == animal.animalBreed.lowercased() {
                
                guard animal.waterConsumption * Double(count) <= remainingLimit else {
                    message = "There is not enough water limit to add \(count) \(animalBreed). Please increase the water limit at least \(animal.waterConsumption * Double(count) - remainingLimit)"
                    completion(message)
                    return
                }
                
                let previousCount = animals[index].count
                animals[index].count += count
                print("\(previousCount) \(animal.animalBreed) increased to \(animals[index].count).")
                animalFound = true
                completion(nil)
                break
            }
        }
        if !animalFound {
            message = "Breed: \(animalBreed) animal is not previosly defined. Please click Create Animal button."
            completion(message)
            animalFound = false
        }
    }
}
