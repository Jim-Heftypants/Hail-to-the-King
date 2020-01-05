//
//  SelectorClass.swift
//  Hail to the King
//
//  Created by Nick Sercel on 12/16/19.
//  Copyright © 2019 Whelps Cave Gaming. All rights reserved.
//

import Foundation

class SelectorClass: NSObject {
    
    var priorTarget = ""
    var index = [-1, -1]
    
    //MARK: Abilities
    
    func missingAbility() {
        return
    }
    func actuateMissingAbility() {
        return
    }

    @objc func heroicStrike() {
        print("Heroic Strike Clicked")
        let dist = abs(Warrior.imageView.center.x - Warrior.target!.imageView.center.x)+abs(Warrior.target!.imageView.frame.origin.y - Warrior.imageView.frame.origin.y)
        if (Warrior.target!.name != MissingHero.name && dist < 260) {
            actuateHeroicStrike()
        }
        else {Warrior.abilityCheckers[0] = true}
    }

    @objc func actuateHeroicStrike() {
        print("Target HP before ability  \(Warrior.target!.HP)")
        Warrior.target!.HP -= 50
        print("Target HP after ability   \(Warrior.target!.HP)")
        Warrior.abilityCooldowns[0] = true

        Warrior.abilityTimers[0] = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false, block: { (_) in
            print("Heroic strike is now off Cooldown")
            Warrior.abilityCooldowns[0] = false
        })

    }
    
    @objc func shieldWall() {
        print("Shield Wall Clicked")
        Warrior.armorValue += (Warrior.baseArmorValue * 0.6)
        Warrior.abilityCooldowns[1] = true
        
        Warrior.abilityTimers[1] = Timer.scheduledTimer(withTimeInterval: 15.0, repeats: false, block: { (_) in
            print("Shield Wall is now off Cooldown")
            Warrior.abilityCooldowns[1] = false
        })
        // var shieldWallTimer: Timer =
        Timer.scheduledTimer(withTimeInterval: 6.0, repeats: false) { (_) in
            Warrior.armorValue -= (Warrior.baseArmorValue / 1.6)
            print("Shield Wall Faded")
        }
        
    }
    
    
    
    //MARK: Talent Trees
    
    fileprivate func showTalentButtons() {
        for i in 0...3 {
            for j in 0...2 {
                talentButtons[i][j].isHidden = false
                talentButtons[i][j].backgroundColor = .purple
                talentButtons[i][j].addTarget(self, action: Selector("\(selectedHero.name)Talent\((i * 3) + j)"), for: .touchUpInside)
                talentButtons[i][j].setTitle(String(selectedHero.baseMaxTalentPoints[i][j] - selectedHero.maxTalentPoints[i][j]), for: .normal)
                print("Selector: \(selectedHero.name)Talent\((i*3)+j)")
            }
        }
        confirmButton.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
        confirmButton.isHidden = false
        resetTalentsButton.isHidden = false
        descriptorLabel.isHidden = false
    }
    
    
    @objc func talentTreeWarrior() {
        showTalentButtons()
        
          //  Make the orientation and aestetic of warrior tree
    }
    
    @objc func WarriorTalent0() {
        print("Button Clicked! - 1")
        descriptorLabel.text = "The First Warrior Talent"
        priorTarget = "WarriorTalent0Action"
        index = [0, 0]
    }
    
    @objc func WarriorTalent0Action() {           //Do the talent button action
        
    }
    
    @objc func WarriorTalent1() {
        print("Button Clicked! - 2")
        descriptorLabel.text = "The Second Warrior Talent"
        priorTarget = "WarriorTalent1Action"
        index = [0, 1]
    }
    
    @objc func WarriorTalent1Action() {           //Do the talent button action
        
    }
    
    @objc func confirmAction() {
        if (index[0] == -1 || index[1] == -1) {return}
        print("talent \((index[0] * 3) + index[1]) action called successfully")
        if (selectedHero.maxTalentPoints[index[0]][index[1]] <= 0 || selectedHero.currentTalentPoints <= 0) {
            print("all available talent points in this talent are spent")
            if (selectedHero.currentTalentPoints <= 0) {print("All Talent points Spent")}
            return
        }
        selectedHero.currentTalentPoints -= 1
        selectedHero.maxTalentPoints[index[0]][index[1]] -= 1
        talentButtons[index[0]][index[1]].setTitle(String(selectedHero.baseMaxTalentPoints[index[0]][index[1]] - selectedHero.maxTalentPoints[index[0]][index[1]]), for: .normal)
        print("Points spent in this slot  \(selectedHero.baseMaxTalentPoints[index[0]][index[1]] - selectedHero.maxTalentPoints[index[0]][index[1]])")
        selector.perform(Selector(priorTarget))
    }
    
    @objc func talentTreeCleric() {
        
        
        
    }
    
    
}
