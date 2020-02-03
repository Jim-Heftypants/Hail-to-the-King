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
    
    let levelNumber: Int
    var goldReward: Int
    var xpReward: Int
    var enemyLoadTable = [[Character]]()
    var baseLoadTable = [[Character]]()
    var isBossLevel: Bool = false
    let itemLevel: Int
    
    convenience init(levelNumber: Int, enemyLoadTable: [[Character]]) {
        self.init(levelNumber: levelNumber, goldReward: nil, xpReward: nil, enemyLoadTable: enemyLoadTable, bossLevel: nil)
    }
    
    init(levelNumber: Int, goldReward: Int?, xpReward: Int?, enemyLoadTable: [[Character]], bossLevel: Bool?) {
        self.levelNumber = levelNumber
        self.goldReward = Int(50 * (1 + (Double(levelNumber) / 15)))
        if (goldReward != nil) {self.goldReward = goldReward!}
        self.xpReward = 1000 + (levelNumber * 200)
        if (xpReward != nil) {self.xpReward = xpReward!}
        self.enemyLoadTable = enemyLoadTable
        self.baseLoadTable = enemyLoadTable
        if (bossLevel != nil) {self.isBossLevel = true}
        switch levelNumber {
        case 0...10:
            itemLevel = 1
        case 11...20:
            itemLevel = 2
        case 21...30:
            itemLevel = 3
        default:
            itemLevel = 0
        }
    }
    
}
