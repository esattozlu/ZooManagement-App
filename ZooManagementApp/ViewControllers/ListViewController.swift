//
//  ListViewController.swift
//  ZooManagementApp
//
//  Created by Hasan Esat Tozlu on 18.11.2022.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var listSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var listTableView: UITableView!
    var zoo: Zoo?
    
    var keeperArray: [ZooKeeper] {
        if let zoo = zoo {
            return zoo.keepers ?? [ZooKeeper]()
        }
        return [ZooKeeper]()
    }
    
    var animalsInZoo: [Animal] {
        if let zoo = zoo {
            guard let animals = zoo.animals else {
                return [Animal]()
            }
            return animals
        }
        return [Animal]()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = false
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(UINib(nibName: "KeepersCell", bundle: nil), forCellReuseIdentifier: "keepersCell")
        listTableView.register(UINib(nibName: "AnimalsCell", bundle: nil), forCellReuseIdentifier: "animalsCell")
        
        listSegmentedControl.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
    }
    
    @objc func handleSegmentChange() {
        listTableView.reloadData()
    }
    

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listSegmentedControl.selectedSegmentIndex == 0 {
            return animalsInZoo.count
        } else {
            return keeperArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if listSegmentedControl.selectedSegmentIndex == 0 {
            guard let cell = listTableView.dequeueReusableCell(withIdentifier: "animalsCell", for: indexPath) as? AnimalsCell else { return UITableViewCell() }
            cell.animal = animalsInZoo[indexPath.row]
            return cell
        } else {
            guard let cell = listTableView.dequeueReusableCell(withIdentifier: "keepersCell", for: indexPath) as? KeepersCell else { return UITableViewCell() }
            cell.keeper = keeperArray[indexPath.row]
            return cell
        }
    }
    
    
}
