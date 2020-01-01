//
//  Items.swift
//  Battleheart Legacy 2
//
//  Created by Nick Sercel on 11/26/19.
//  Copyright © 2019 Whelps Cave Gaming. All rights reserved.
//

import UIKit

class Item {
    let itemName: String
    let damageValue: Int
    let imageView: UIImageView
    let buyPrice: Int
    let sellPrice: Int
    let upgradePrice: Int
    let itemLevel: Int
    let description: String
    let slotType: Int
    let equipmentType: Int
    let assignedCenter: CGPoint
    
    var itemID = [[0], [0]]
    
    init (itemName: String, damageValue: Int, appearance: UIImage, price: Int, itemLevel: Int, description: String, slotType: Int, equipmentType: Int) {
        self.itemName = itemName
        self.damageValue = damageValue
        self.imageView = UIImageView(image: appearance)
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
        
        imageView.isHidden = true
        imageView.frame = CGRect(x: -200, y: -200, width: 75, height: 75)
        imageView.isUserInteractionEnabled = true
    }
    
}
