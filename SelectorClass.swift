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
        talentButtonOne.isHidden = false
        talentButtonTwo.isHidden = false
        talentButtonThree.isHidden = false
        talentButtonFour.isHidden = false
        confirmButton.isHidden = false
        resetTalentsButton.isHidden = false
        descriptorLabel.isHidden = false
    }
    
    fileprivate func setButtonTargets() {
        talentButtonOne.addTarget(self, action: #selector(warriorTalentOne), for: .touchUpInside)
        talentButtonTwo.addTarget(self, action: #selector(warriorTalentTwo), for: .touchUpInside)
    }
    
    @objc func talentTreeWarrior() {
        showTalentButtons()
        
          //  Make the orientation and aestetic of warrior tree
        
        setButtonTargets()
    }
    
    @objc func warriorTalentOne() {
        print("Button Clicked! - 1")
        descriptorLabel.text = "The First Warrior Ability"
        if (Warrior.currentTalentPoints <= 0){return}
        confirmButton.isHighlighted = true
        confirmButton.removeTarget(self, action: NSSelectorFromString(priorTarget), for: .touchUpInside)
        priorTarget = "warriorTalentOneAction"
        confirmButton.addTarget(self, action: NSSelectorFromString(priorTarget), for: .touchUpInside)
    }
    
    @objc func warriorTalentOneAction() {           //Do the talent button action
        print("talent one action called successfully")
        if (Warrior.maxTalentPoints[0][0] <= 0 || Warrior.currentTalentPoints <= 0) {
            confirmButton.isHighlighted = false
            print("all available talent points in this talent are spent")
            if (Warrior.currentTalentPoints <= 0) {print("All Talent points Spent")}
            return
        }
        Warrior.currentTalentPoints -= 1
        Warrior.maxTalentPoints[0][0] -= 1
        print("Points spent in this slot  \(Warrior.baseMaxTalentPoints[0][0] - Warrior.maxTalentPoints[0][0])")
    }
    
    @objc func warriorTalentTwo() {
        print("Button Clicked! - 2")
        descriptorLabel.text = "The Second Warrior Ability"
        if (Warrior.currentTalentPoints <= 0){return}
        confirmButton.isHighlighted = true
        confirmButton.removeTarget(self, action: NSSelectorFromString(priorTarget), for: .touchUpInside)
        priorTarget = "warriorTalentTwoAction"
        confirmButton.addTarget(self, action: NSSelectorFromString(priorTarget), for: .touchUpInside)
        
    }
    
    @objc func warriorTalentTwoAction() {           //Do the talent button action
        print("talent two action called successfully")
        if (Warrior.maxTalentPoints[0][1] <= 0 || Warrior.currentTalentPoints <= 0) {
            confirmButton.isHighlighted = false
            print("all available talent points in this talent are spent")
            if (Warrior.currentTalentPoints <= 0) {print("All Talent points Spent")}
            return
        }
        Warrior.currentTalentPoints -= 1
        Warrior.maxTalentPoints[0][1] -= 1
        print("Points spent in this slot  \(Warrior.baseMaxTalentPoints[0][1] - Warrior.maxTalentPoints[0][1])")
    }
    
    
    
    @objc func talentTreeCleric() {
        
        
        
    }
    
    
}
