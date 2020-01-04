//
//  Items.swift
//  Battleheart Legacy 2
//
//  Created by Nick Sercel on 11/26/19.
//  Copyright © 2019 Whelps Cave Gaming. All rights reserved.
//

import UIKit

class Item {
    let name: String
    let damageValue: Double
    let buyPrice: Int
    let sellPrice: Int
    let upgradePrice: Int
    let itemLevel: Int
    let description: String
    let slotType: Int
    let equipmentType: Int
    let assignedCenter: CGPoint
    
    var itemID = [[0], [0]]
    var itemButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    init (name: String, damageValue: Double, price: Int, itemLevel: Int, description: String, slotType: Int, equipmentType: Int) {
        self.name = name
        self.damageValue = damageValue
        self.buyPrice = price
        self.sellPrice = price/2
        self.upgradePrice = Int(Double(price) * 1.5)
        self.itemLevel = itemLevel
        self.description = description
        self.slotType = slotType
        self.equipmentType = equipmentType
        if (slotType == 1) {assignedCenter = CGPoint(x: 0, y: 0)}
        else if (slotType == 2) {assignedCenter = CGPoint(x: 0, y: 0)}
        else if (slotType == 3) {assignedCenter = CGPoint(x: 0, y: 0)}
        else {assignedCenter = CGPoint(x: 0, y: 0)}
        
        //itemButton.setImage(UIImage(named: self.name), for: .normal)      //Re-enable with images for items and delete next line
        itemButton.isHidden = true
        itemButton.setImage(UIImage(named: "blackBackground"), for: .normal)
        itemButton.addTarget(self, action: #selector(buttonTarget), for: .touchUpInside)
    }
    
    @objc func buttonTarget() {
        descriptorLabel.text = self.description
    }
    
    
}
