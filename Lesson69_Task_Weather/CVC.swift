//
//  CVC.swift
//  Lesson69_Task_Weather
//
//  Created by Kh's MacBook on 15.06.2021.
//

import UIKit

class CVC: UICollectionViewCell {

    @IBOutlet weak var conteinerView: UIView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var mainLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        conteinerView.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
//        conteinerView.layer.shadowOffset = CGSize(width: 0, height: 0)
//        conteinerView.layer.shadowRadius = 5
//        conteinerView.layer.shadowOpacity = 0.6
//        conteinerView.layer.cornerRadius = 20
    }

    func updateCell(with: Weather){
        timeLbl.text = with.time
        tempLbl.text = with.temp
        mainLbl.text = with.main
    }
}
