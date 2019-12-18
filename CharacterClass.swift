//
//  CharacterClass.swift
//  Battleheart Legacy 2
//
//  Created by Nick Sercel on 11/22/19.
//  Copyright © 2019 Whelps Cave Gaming. All rights reserved.
//

import UIKit

class Character {
    var exists = true
    var canAttack = true
    var xp = 0
    var level = 1
    var xpModifier = 1.0
    var attackTimerChecker = false
    var timerCheck = false
    var abilityTwoExistanceChecker = false
    var abilityThreeExistanceChecker = false
    var abilityFourExistanceChecker = false
    var abilityCheckers: [Bool] = [false, false, false, false]
    var abilityCooldowns: [Bool] = [false, false, false, false]
    var abilityTimerTrackers: [Double] = []
    var abilityNames: [String] = []
    var heroShouldNotAttack = false
    
    var isMelee: Bool
    var movementSpeed: Double
    var baseMovementSpeed: Double
    var HP: Int
    var BaseHP: Int
    var autoAttackDamage: Int
    var baseAutoAttackDamage: Int
    var attackSpeed: Double
    var baseAttackSpeed: Double
    var armorValue: Int
    var baseArmorValue: Int
    var isFacingRight: Bool
    var target: Character?      //need a way to fix and impliment after constructor call
    var secondaryThreat: Character?
    
    lazy var attackTimer = Timer()
    lazy var movementTimer: Timer = Timer.scheduledTimer(withTimeInterval: 0, repeats: false) { (_) in }
    lazy var abilityTimers: [Timer] = [movementTimer, movementTimer, movementTimer, movementTimer]
    
    let imageNumberAttack: Int
    let imageNumberMovement: Int
    let imageNumberProjectile: Int
    let imageNumberHeal: Int
    let isEnemy: Bool
    let isHealer: Bool
    let name: String
    
    var talentTree: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    var imageView: UIImageView
    let secondaryImageView: UIImageView?
    
    var attackImages: [UIImage] = []
    var movementImages: [UIImage] = []
    var projectileImages: [UIImage]? = []
    var healingImages: [UIImage]? = []
    var animation: UIViewPropertyAnimator
    
    convenience init (characterName: String, isEnemy: Bool, characterBaseImage: UIImage, imageNumberAttack: Int, imageNumberMovement: Int, movementSpeed: Double, HP: Int, attackSpeed: Double, autoAttackDamage: Int, armorValue: Int, isMelee: Bool, isHealer: Bool, abilityNames: [String]) {
        self.init (characterName: characterName, isEnemy: isEnemy, characterBaseImage: characterBaseImage, imageNumberAttack: imageNumberAttack, imageNumberMovement: imageNumberMovement, imageNumberProjectile: 0, imageNumberHeal: 0, movementSpeed: movementSpeed, HP: HP, attackSpeed: attackSpeed, autoAttackDamage: autoAttackDamage, armorValue: armorValue, isMelee: isMelee, isHealer: isHealer, secondaryBaseImage: nil, abilityNames: abilityNames)
    }
    
    init (characterName: String, isEnemy: Bool, characterBaseImage: UIImage, imageNumberAttack: Int, imageNumberMovement: Int, imageNumberProjectile: Int, imageNumberHeal: Int, movementSpeed: Double, HP: Int, attackSpeed: Double, autoAttackDamage: Int, armorValue: Int, isMelee: Bool, isHealer: Bool, secondaryBaseImage: UIImage?, abilityNames: [String]) {
        if (characterName == heroList[0]) {self.exists = false}
        name = characterName
        self.isEnemy = isEnemy
        self.HP = HP
        self.BaseHP = HP
        self.movementSpeed = movementSpeed
        self.baseMovementSpeed = movementSpeed
        self.attackSpeed = attackSpeed
        self.baseAttackSpeed = attackSpeed
        self.autoAttackDamage = autoAttackDamage
        self.baseAutoAttackDamage = autoAttackDamage
        self.isMelee = isMelee
        self.isHealer = isHealer
        self.imageNumberAttack = imageNumberAttack
        self.imageNumberMovement = imageNumberMovement
        self.imageNumberProjectile = imageNumberProjectile
        self.imageNumberHeal = imageNumberHeal
        self.isFacingRight = true
        self.armorValue = armorValue
        self.baseArmorValue = armorValue
        self.abilityNames = abilityNames
        
        //      all non-init declarations should be made externally when object is declared
        
        self.imageView = {
            let imageView = UIImageView(frame: CGRect(x: -200, y: -200, width: 200, height: 230))
            imageView.image = characterBaseImage
            imageView.contentMode = .scaleAspectFit
            imageView.backgroundColor = UIColor(displayP3Red: 1.0, green: 0, blue: 0, alpha: 1.0)
            return imageView
        }()
        if (name == heroList[0]){
            self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        }
        self.secondaryImageView = {
            let secondaryImageView = UIImageView(image: secondaryBaseImage)
            secondaryImageView.frame = CGRect(x: -200, y: -200, width: 50, height: 50)
            return secondaryImageView
        }()
        
        self.animation = UIViewPropertyAnimator(duration: 1.0, curve: .linear, animations: {})
        
        if (characterName != heroList[0] && isEnemy == false){
            self.talentTree = {
                let imageView = UIImageView(frame: CGRect(x: 0, y: 185, width: 1194, height: 654))
                imageView.image = UIImage(named: "\(characterName)-Talent-Tree.png")!
                imageView.contentMode = .scaleAspectFit
                imageView.isHidden = true
                return imageView
            }()
        }
        

        self.attackImages = createAllImageArrays(total: imageNumberAttack, characterName: name, animationType: "Attack")
        if (imageNumberMovement != 0) {self.movementImages = self.createAllImageArrays(total: imageNumberMovement, characterName: name, animationType: "Movement")}
        if (imageNumberProjectile != 0) {self.projectileImages = self.createAllImageArrays(total: imageNumberProjectile, characterName: name, animationType: "Projectile")}
        if (imageNumberHeal != 0) {self.healingImages = self.createAllImageArrays(total: imageNumberHeal, characterName: name, animationType: "Heal")}
       
    }
        
    func createAllImageArrays(total: Int, characterName: String, animationType: String) -> [UIImage] {
        var imageArray: [UIImage] = []
        for imageCount in 1..<(total + 1){
            let imageName = "\(characterName)-\(animationType)-\(imageCount).png"
            let image = UIImage(named: imageName)!
            imageArray.append(image)
        }
        return imageArray
    }
    
    func reset() {
        HP = BaseHP
        movementSpeed = baseMovementSpeed
        attackSpeed = baseAttackSpeed
        autoAttackDamage = baseAutoAttackDamage
        armorValue = baseArmorValue
    }
    
    @objc func abilityOne() {
        if (abilityCooldowns[0] == true || abilityCheckers[0] == true) {return}
        let currentSelector : Selector = NSSelectorFromString(abilityNames[0])
        selector.perform(currentSelector)
    }

    @objc func abilityTwo() {
        if (abilityCooldowns[1] == true || abilityCheckers[1] == true) {return}
        let currentSelector : Selector = NSSelectorFromString(abilityNames[1])
        selector.perform(currentSelector)
    }

    @objc func abilityThree() {
        if (abilityCooldowns[2] == true || abilityCheckers[2] == true) {return}
        let currentSelector : Selector = NSSelectorFromString(abilityNames[2])
        selector.perform(currentSelector)
    }

    @objc func abilityFour() {
        if (abilityCooldowns[3] == true || abilityCheckers[3] == true) {return}
        let currentSelector : Selector = NSSelectorFromString(abilityNames[3])
        selector.perform(currentSelector)
    }
    
}
