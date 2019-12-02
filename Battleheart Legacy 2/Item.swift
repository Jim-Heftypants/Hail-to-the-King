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
    var equipableBy: [Character] = []
    let damageValue: Int
    let appearance: UIImage
    let buyPrice: Int
    let sellPrice: Int
    let upgradePrice: Int
    let itemLevel: Int
    
    init (itemName: String, equipableBy: [Character], damageValue: Int, appearance: UIImage, price: Int, itemLevel: Int) {
        self.itemName = itemName
        self.equipableBy = equipableBy
        self.damageValue = damageValue
        self.appearance = appearance
        self.buyPrice = price
        self.sellPrice = price/2
        self.upgradePrice = Int(Double(price) * 1.5)
        self.itemLevel = itemLevel
        
    }
    
    
    
    
    
    
    
    
    
    
}
