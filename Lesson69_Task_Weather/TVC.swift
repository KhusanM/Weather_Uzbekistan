//
//  TVC.swift
//  Lesson69_Task_Weather
//
//  Created by Kh's MacBook on 15.06.2021.
//

import UIKit

class TVC: UITableViewCell {

    
    @IBOutlet weak var conteinerView: UIView!
    @IBOutlet weak var citiesLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        conteinerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        conteinerView.layer.shadowRadius = 5
        conteinerView.layer.shadowOpacity = 0.6
        conteinerView.layer.cornerRadius = 20
    }

    
    
    
    
}
