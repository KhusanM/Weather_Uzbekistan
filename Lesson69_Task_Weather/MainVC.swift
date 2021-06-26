//
//  MainVC.swift
//  Lesson69_Task_Weather
//
//  Created by Kh's MacBook on 15.06.2021.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import CoreData
class MainVC: UIViewController {

    
    
    @IBOutlet weak var morningImg: UIImageView!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var collevtionView: UICollectionView!{
        didSet{
            collevtionView.delegate = self
            collevtionView.dataSource = self
            collevtionView.register(UINib(nibName: "CVC", bundle: nil), forCellWithReuseIdentifier: "CVC")
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var city = "Tashkent"
    var dataWeather:[Weather] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        city = UserDefaults.standard.string(forKey: "city") ?? "Tashkent"
        tempLbl.text = UserDefaults.standard.string(forKey: "temp")
        currentTime()
        addData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cityBtn.setTitle(city, for: .normal)
        getWeather(cityName: city)
        fetchWearher()
    }
    
    func currentTime(){
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        switch hour {
        case 0...5:
            morningImg.image = UIImage(named: "night")
        case 5...19:
            morningImg.image = UIImage(named: "morning")
        case 20...23:
            morningImg.image = UIImage(named: "night")
        default:
            break
        }
    }
    
    func fetchWearher(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Weather")
        do{
            if let results = try context.fetch(request) as? [Weather] {
                dataWeather = results
                
            }
            try self.context.save()
            collevtionView.reloadData()
        }catch{
            
        }
    }
    
    func addData(){
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let hour = calendar.component(.hour, from: date)
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let min = calendar.component(.minute, from: date)
        let weather = Weather(context: context)
        weather.main = descLbl.text
        weather.temp = tempLbl.text
        weather.time = "\(city) \(day)/\(month)/\(year), \(hour):\(min) "
        try? context.save()
    }
    
    func getWeather(cityName: String){
        AF.request("https://api.openweathermap.org/data/2.5/weather", method: .get, parameters: ["q":cityName,"appid": "926db9f09e85a6d71c420188a71f258c"]).responseJSON { (response) in
            if let data = response.data{
                
                let json = JSON(data)
                let temp = json["main"]["temp"].doubleValue
                UserDefaults.standard.setValue(String((Int(temp)-273)), forKey: "temp")
                
                self.tempLbl.text = String((Int(temp)-273))
                if !json["weather"].arrayValue.isEmpty{
                    let main = json["weather"][0]["main"].stringValue
                    self.descLbl.text = main
                }
            }else{
                
                self.descLbl.text = "nil"
            }
        }
    }

    
    @IBAction func cityBtnPressed(_ sender: Any) {
        let vc = CitiesVC(nibName: "CitiesVC", bundle: nil)
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    
}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataWeather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVC", for: indexPath) as! CVC
        cell.updateCell(with: dataWeather[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.width/2*1.3)
    }
    
}

extension MainVC: CityDelegate{
    func cityName(name: String) {
        self.city = name
        UserDefaults.standard.setValue(name, forKey: "city")
    }
}
