//
//  Enums.swift
//  ZooManagementApp
//
//  Created by Hasan Esat Tozlu on 18.11.2022.
//

import UIKit

struct DefinedAnimals {
    static var cat     = Animal(animalBreed: "Cat 🐈", waterConsumption: 100, sound: "catSound", image: UIImage(named: "cat"))
    static var dog     = Animal(animalBreed: "Dog 🐶", waterConsumption: 150, sound: "dogSound", image: UIImage(named: "dog"))
    static var bird    = Animal(animalBreed: "Bird 🦜", waterConsumption: 30, sound: "birdSound", image: UIImage(named: "bird"))
    static var monkey  = Animal(animalBreed: "Monkey 🐒", waterConsumption: 200, sound: "monkeySound", image: UIImage(named: "monkey"))
    static var snake   = Animal(animalBreed: "Snake 🐍", waterConsumption: 50, sound: "snakeSound", image: UIImage(named: "snake"))
    static var horse   = Animal(animalBreed: "Horse 🐎", waterConsumption: 400, sound: "horseSound", image: UIImage(named: "horse"))
    static var lion    = Animal(animalBreed: "Lion 🦁", waterConsumption: 500, sound: "lionSound", image: UIImage(named: "lion"))
    static var pig     = Animal(animalBreed: "Pig 🐷", waterConsumption: 300, sound: "pigSound", image: UIImage(named: "pig"))
    static var animalArray = [cat, dog, bird, monkey, snake, horse, lion, pig]
}
