//
//  CitiesVC.swift
//  Lesson69_Task_Weather
//
//  Created by Kh's MacBook on 15.06.2021.
//

import UIKit
protocol CityDelegate {
    func cityName(name: String)
}

class CitiesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var cities = ["Andijan","Bukhara","Fergana","Namangan","Navoiy","Nukus","Qarshi","Samarqand","Tashkent","Termiz","Urgench","Jizzakh"]
    
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "TVC", bundle: nil), forCellReuseIdentifier: "TVC")
        }
    }
    var delegate: CityDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVC", for: indexPath) as! TVC
        cell.citiesLbl.text = cities[indexPath.row]
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        delegate?.cityName(name: cities[indexPath.row])
        
        dismiss(animated: true, completion: nil)
        
    }
    
    

}
