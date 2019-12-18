//
//  SelectorClass.swift
//  Hail to the King
//
//  Created by Nick Sercel on 12/16/19.
//  Copyright © 2019 Whelps Cave Gaming. All rights reserved.
//

import Foundation

class SelectorClass: NSObject {

    func missingAbility() {
        return
    }
    func actuateMissingAbility() {
        return
    }

    @objc func heroicStrike() {
        let dist = abs(Warrior.imageView.center.x - Warrior.target!.imageView.center.x)+abs(Warrior.target!.imageView.frame.origin.y - Warrior.imageView.frame.origin.y)
        if (Warrior.target!.name != Warrior.name && dist < 260) {
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


}
