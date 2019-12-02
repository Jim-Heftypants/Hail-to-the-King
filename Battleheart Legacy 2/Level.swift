//
//  Level.swift
//  Battleheart Legacy 2
//
//  Created by Nick Sercel on 11/29/19.
//  Copyright © 2019 Whelps Cave Gaming. All rights reserved.
//

import UIKit

//not yet implimented into GameViewController

class Level {
    var complete = false
    
    var levelNumber: Int
    var goldReward: Int
    var itemReward: Item
    var xpReward: Int
    var enemyLoadTable: [Character] = []
    let baseLoadTable: [Character]
    
    init(levelNumber: Int, goldReward: Int, itemReward: Item, xpReward: Int?, enemyLoadTable: [Character]) {
        self.levelNumber = levelNumber
        self.goldReward = goldReward
        self.itemReward = itemReward
        self.xpReward = 1000 + (levelNumber * 200)
        if (xpReward != nil) {self.xpReward = xpReward!}
        self.enemyLoadTable = enemyLoadTable
        self.baseLoadTable = enemyLoadTable
    }
    
    
}
