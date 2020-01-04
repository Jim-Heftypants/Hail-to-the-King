//
//  GameViewController.swift
//  Hail to the King
//
//  Created by Nick Sercel on 10/22/19.
//  Copyright © 2019 Whelps Cave Gaming. All rights reserved.
//

// Width:  1194
// Height: 834

import UIKit
import SpriteKit
import GameplayKit


public var heroList = ["0", "Warrior", "Cleric", "Druid", "Ranger", "Arcanist", "Rogue", "Palladin", "Warlock", "Shaman", "Monk", "Alchemist", "Battlemage"]
public var enemyList = ["0", "SkeletonArcher", "Goblin", "Ogre", "Wolf", "Spider"]

public var saveFileChecker = 0
public var saveOneName: String?
public var saveTwoName: String?
public var saveThreeName: String?
public var saveCode: Array<Any>?

var missingTextView: UITextView = {             //Remove once all views are made and finalized with images
    var textView = UITextView(frame: CGRect(x: 100, y: 50, width: 300, height: 100))
    textView.text = "No item images/character portraits have been made yet, thus this screen is uninstalled"
    textView.isHidden = true
    return textView
}()

let selector = SelectorClass()

let BronzeSword = Item(name: "Bronze Sword", damageValue: 2, price: 50, itemLevel: 1, description: "A simple bronze sword.", slotType: 1, equipmentType: 1)
let MissingItem = Item(name: "0", damageValue: 0, price: 0, itemLevel: 0, description: "", slotType: 0, equipmentType: 0)

var MissingHero = Character(characterName: heroList[0], isEnemy: false, characterBaseImage: UIImage(named: "blackBackground")!, imageNumberAttack: 0, imageNumberMovement: 0, movementSpeed: 0.0, HP: 0, attackSpeed: 0.0, autoAttackDamage: 0, armorValue: 0, isMelee: false, isHealer: false, abilityNames: ["missingAbility"], equipmentType: 0)
var Warrior = Character(characterName: heroList[1], isEnemy: false, characterBaseImage: UIImage(named: "Warrior-1")!, imageNumberAttack: 4, imageNumberMovement: 5, movementSpeed: 350.0, HP: 150, attackSpeed: 3.0, autoAttackDamage: 10, armorValue: 40, isMelee: true, isHealer: false, abilityNames: ["heroicStrike", "shieldWall"], equipmentType: 1)

var MissingEnemy = Character(characterName: enemyList[0], isEnemy: true, characterBaseImage: UIImage(named: "blackBackground")!, imageNumberAttack: 0, imageNumberMovement: 0, movementSpeed: 0.0, HP: 0, attackSpeed: 0.0, autoAttackDamage: 0, armorValue: 0, isMelee: false, isHealer: false, abilityNames: ["missingAbility"], equipmentType: 0)
var SkeletonArcher1 = Character(characterName: enemyList[1], isEnemy: true, characterBaseImage: UIImage(named: "SkeletonArcher-1")!, imageNumberAttack: 3, imageNumberMovement: 0, imageNumberProjectile: 0, imageNumberHeal: 0, movementSpeed: 0.0, HP: 75, attackSpeed: 1.5, autoAttackDamage: 12, armorValue: 15, isMelee: false, isHealer: false, secondaryBaseImage: nil, abilityNames: ["missingAbility"], equipmentType: 0)

var activeHeroes = [MissingHero, MissingHero, MissingHero, MissingHero]
var activeEnemies = [MissingEnemy, MissingEnemy, MissingEnemy, MissingEnemy]
var heroArray = [[Warrior, MissingHero, MissingHero], [Warrior, MissingHero, MissingHero], [Warrior, MissingHero, MissingHero], [Warrior, MissingHero, MissingHero]]

let Tutorial = Level(levelNumber: 0, goldReward: 50, itemReward: BronzeSword, xpReward: 100, enemyLoadTable: [[SkeletonArcher1, MissingEnemy, MissingEnemy, MissingEnemy], [MissingEnemy, MissingEnemy]])
let MissingLevel = Level(levelNumber: -1, goldReward: 0, itemReward: MissingItem, xpReward: 0, enemyLoadTable: [])

var currentLevel = MissingLevel

var selectedItem = MissingItem
var itemArray = [[MissingItem, MissingItem, MissingItem, MissingItem], [MissingItem, MissingItem, MissingItem, MissingItem], [MissingItem, MissingItem, MissingItem, MissingItem], [MissingItem, MissingItem, MissingItem, MissingItem]]        //  4x4  (16 total item slots)

var abilityButtonOne: UIButton = {
let button = UIButton(frame: CGRect(x: 20, y: 20, width: 75, height: 75))
    button.isHidden = true
    button.setImage(UIImage(named: "Warrior-1"), for: .normal)
    return button
}()
var abilityButtonTwo: UIButton = {
    let button = UIButton(frame: CGRect(x: 120, y: 20, width: 75, height: 75))
    button.isHidden = true
    button.setImage(UIImage(named: "Warrior-1"), for: .normal)
    return button
}()
var abilityButtonThree: UIButton = {
    let button = UIButton(frame: CGRect(x: 220, y: 20, width: 75, height: 75))
    button.isHidden = true
    return button
}()
var abilityButtonFour: UIButton = {
    let button = UIButton(frame: CGRect(x: 320, y: 20, width: 75, height: 75))
    button.isHidden = true
    return button
}()
var pauseButton: UIButton = {
    let button = UIButton(frame: CGRect(x: 500, y: 20, width: 75, height: 75))
    button.isHidden = true
    return button
}()

var tempButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
var talentButtons: [[UIButton]] = {
    var button = [[tempButton, tempButton, tempButton], [tempButton, tempButton, tempButton], [tempButton, tempButton, tempButton], [tempButton, tempButton, tempButton]]
    for i in 0...3 {
        for j in 0...2 {
            button[i][j] = UIButton(frame: CGRect(x: 100 + (110 * i), y: 200 + (110 * j), width: 95, height: 95))
            button[i][j].isHidden = true
            button[i][j].backgroundColor = .systemTeal
//            button[i][j].setImage(UIImage(named: "\(heroArray[i][j].name)-1"), for: .normal)      //Re-enable when all images exist
        }
    }
   return button
}()

var confirmButton: UIButton = {
let button = UIButton(frame: CGRect(x: 850, y: 50, width: 150, height: 75))
    button.isHidden = true
    button.setTitle("Confirm Talent", for: .normal)
    button.setTitleColor(UIColor(displayP3Red: 0, green: 1.0, blue: 0, alpha: 1), for: .normal)
    button.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 1.0, alpha: 1)
    return button
}()
var resetTalentsButton: UIButton = {
let button = UIButton(frame: CGRect(x: 850, y: 150, width: 150, height: 75))
    button.isHidden = true
    button.setTitle("Reset Talents", for: .normal)
    button.setTitleColor(UIColor(displayP3Red: 0, green: 1.0, blue: 0, alpha: 1), for: .normal)
    button.backgroundColor = UIColor(displayP3Red: 1.0, green: 0, blue: 0, alpha: 1)
    return button
}()

var equipmentButtonOne: UIButton = {
let button = UIButton(frame: CGRect(x: 40, y: 40, width: 125, height: 125))
    button.isHidden = true
    button.setImage(UIImage(named: "Warrior-1"), for: .normal)
    return button
}()
var equipmentButtonTwo: UIButton = {
let button = UIButton(frame: CGRect(x: 205, y: 40, width: 125, height: 125))
    button.isHidden = true
//    button.setImage(UIImage(named: "Warrior-1"), for: .normal)
    button.backgroundColor = .green
    return button
}()
var equipmentButtonThree: UIButton = {
let button = UIButton(frame: CGRect(x: 370, y: 40, width: 125, height: 125))
    button.isHidden = true
//    button.setImage(UIImage(named: "Warrior-1"), for: .normal)
    button.backgroundColor = .green
    return button
}()
var equipmentButtonFour: UIButton = {
let button = UIButton(frame: CGRect(x: 535, y: 40, width: 125, height: 125))
    button.isHidden = true
//    button.setImage(UIImage(named: "Warrior-1"), for: .normal)
    button.backgroundColor = .green
    return button
}()

let placement = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
var tempPoint = CGPoint(x: 0, y: 0)

let itemImageArray: [[UIImageView]] = {
    var view = [[placement, placement, placement, placement], [placement, placement, placement, placement], [placement, placement, placement, placement], [placement, placement, placement, placement]]
    for i in 0...3 {
        for j in 0...3 {
            view[i][j] = UIImageView(frame: CGRect(x: 780 + 100*j, y: 314 + 100*i, width: 95, height: 95))
            view[i][j].backgroundColor = .red
            view[i][j].isHidden = true
        }
    }
    return view
    }()


var descriptorLabel: UILabel = UILabel(frame: CGRect(x: 20, y: 610, width: 1154, height: 200))

var selectedHero: Character = MissingHero

class GameViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var enterNameField: UITextField!
    
    fileprivate func configureTextFields() {
         enterNameField.delegate = self
         enterNameField.placeholder = "Enter Name"
     }
    
    fileprivate func addButtons() {
        self.view.addSubview(abilityButtonOne)
        self.view.addSubview(abilityButtonTwo)
        self.view.addSubview(abilityButtonThree)
        self.view.addSubview(abilityButtonFour)
        self.view.addSubview(pauseButton)
        pauseButton.addTarget(self, action: #selector(pauseGame), for: .touchUpInside)
//        self.view.addSubview(talentButtonOne)
//        self.view.addSubview(talentButtonTwo)
//        self.view.addSubview(talentButtonThree)
//        self.view.addSubview(talentButtonFour)
        self.view.addSubview(confirmButton)
        self.view.addSubview(resetTalentsButton)
        self.view.addSubview(equipmentButtonOne)
        self.view.addSubview(equipmentButtonTwo)
        self.view.addSubview(equipmentButtonThree)
        self.view.addSubview(equipmentButtonFour)
        for i in 0...3 {
            for j in 0...2 {
                talentButtons[i][j].addTarget(self, action: #selector(selectHero(_:)), for: .touchUpInside)
                self.view.addSubview(talentButtons[i][j])
            }
        }
    }
    
    fileprivate func makeItemsInteractive() {
        descriptorLabel.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(standardDrag(_:))))
        resetTalentsButton.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(standardDrag(_:))))
        self.view.addSubview(BronzeSword.itemButton)
        addPanRecog(view: BronzeSword.itemButton)
        
        //Add gesture recognizer for each item
    }
    
    fileprivate func addPanRecog(view: UIView) {
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(itemDragged(_:))))
        
    }
    
    fileprivate func loadImageViews() {
        self.view.addSubview(missingTextView)
        descriptorLabel.isHidden = true
        descriptorLabel.isUserInteractionEnabled = true
        descriptorLabel.font = UIFont(name: "Helvetica", size: 40)
        descriptorLabel.textColor = UIColor(cgColor: CGColor(srgbRed: 1.0, green: 0, blue: 0, alpha: 1.0))
        self.view.addSubview(descriptorLabel)
//        self.view.addSubview(itemStack1)
//        self.view.addSubview(itemStack2)
//        self.view.addSubview(itemStack3)
//        self.view.addSubview(itemStack4)
//        self.view.addSubview(bigItemStack)
        for i in 0...3 {
            self.view.addSubview(Warrior.itemImageViews[i])
            for j in 0...3 {
                self.view.addSubview(itemImageArray[i][j])
            }
        }
    }
    
    fileprivate func setTargets() {
        MissingEnemy.target = MissingHero
        MissingHero.target = MissingEnemy
        Warrior.target = MissingEnemy
        SkeletonArcher1.target = MissingHero
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabelOne.textColor = UIColor(displayP3Red: 1.0, green: 0, blue: 0, alpha: 1)
        configureTextFields()
        loadSavedValues()
        loadImageViews()
        addButtons()
        setTargets()
        makeItemsInteractive()
       
        
        saveThreeName = "Jimbo"
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "GameScene") {
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
//
//                // Present the scene
//                view.presentScene(scene)
//            }
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    //MARK: Drag Time
    
    @objc func standardDrag (_ gesture: UIPanGestureRecognizer) {
        let distance = gesture.translation(in: self.view)
        let label = gesture.view!
        
        label.center = CGPoint(x: label.center.x + distance.x, y: label.center.y + distance.y)
        gesture.setTranslation(CGPoint.zero, in: self.view)
    }
    
    var tempHelper = [-1, -1]
    @objc func itemDragged (_ gesture: UIPanGestureRecognizer) {
        let distance = gesture.translation(in: self.view)
        let view = gesture.view!
        
        view.center = CGPoint(x: view.center.x + distance.x, y: view.center.y + distance.y)
        gesture.setTranslation(CGPoint.zero, in: self.view)
        
        if (gesture.state == UIGestureRecognizer.State.began) {
            tempPoint = view.center
            for i in 0...3 {
                if (selectedHero.itemImageViews[i].center == view.center && selectedHero.items[i].name != MissingItem.name) {
                    selectedItem = selectedHero.items[i]
//                    tempPoint = selectedHero.items[i].itemButton.center
                    tempHelper = [i, -1]
                    print("Called at 1")
                    print("tempHelper:  \(tempHelper)")
                }
                for j in 0...3 {
                    if (itemArray[i][j].name != MissingItem.name  && itemArray[i][j].itemButton.center == view.center) {
                        selectedItem = itemArray[i][j]
//                        tempPoint = itemImageArray[i][j].center
                        tempHelper = [i, j]
                        print("Called at 2")
                        print("tempHelper:  \(tempHelper)")
                    }
                }
            }
            print("Initialized Temp Point:  \(tempPoint)")
            
        }
        
        if (gesture.state == UIGestureRecognizer.State.ended) {
            for i in 0...3 {
                if (selectedHero.itemImageViews[i].frame.contains(view.center) && selectedItem.slotType == (i + 1) && selectedHero.equipmentType == selectedItem.equipmentType) {
                    view.center = selectedHero.itemImageViews[i].center
                    tempPoint = selectedHero.itemImageViews[i].center
                    if (tempHelper[1] == -1) {print("No change - executed nothing")}
                    else {itemArray[tempHelper[0]][tempHelper[1]] = MissingItem
                        selectedHero.attributeArray[i] -= selectedHero.items[i].damageValue
                        selectedHero.items[i] = selectedItem
                        selectedHero.attributeArray[i] += selectedHero.items[i].damageValue
                        selectedItem.itemButton.frame = selectedHero.itemImageViews[i].frame
                        print("Item replaced at \(i)")
                        
                    }
                    return
                }
                 for j in 0...3 {
                     if (itemImageArray[i][j].frame.contains(view.center)) {
                         view.center = itemImageArray[i][j].center
                         tempPoint = itemImageArray[i][j].center
                        if (tempHelper[1] == -1) {
                            selectedHero.items[tempHelper[0]] = MissingItem
                            itemArray[i][j] = selectedItem
                        }
                        else {
                            itemArray[i][j] = selectedItem
                            itemArray[tempHelper[0]][tempHelper[1]] = MissingItem
                        }
                        return
                     }
                 }
             }
            view.center = tempPoint
        }
    }
//            if (selectedHero.equipmentType != selectedItem.equipmentType || slotNumber != selectedItem.slotType) {selectedItem.itemButton.center = tempPoint}
//            else {          //equip the item
//                if (slotNumber == 1) {              // Weapon
//                    selectedHero.autoAttackDamage -= selectedHero.items[0].damageValue
//                    selectedHero.items[0] = selectedItem
//                    selectedHero.autoAttackDamage += selectedItem.damageValue
//                    selectedItem.itemButton.frame = selectedHero.itemImageViews[0].frame
//                    tempPoint = selectedHero.itemImageViews[0].center
//                }
//                else if (slotNumber == 2) {        // Armor
//                    selectedHero.armorValue -= selectedHero.items[1].damageValue
//                    selectedHero.items[1] = selectedItem
//                    selectedHero.armorValue += selectedItem.damageValue
//                    selectedItem.itemButton.frame = selectedHero.itemImageViews[1].frame
//                    tempPoint = selectedHero.itemImageViews[1].center
//                }
//                else if (slotNumber == 3) {       // Ring
//                    //undecided on what properties rings can have
//                    selectedHero.items[2] = selectedItem
//                    selectedItem.itemButton.frame = selectedHero.itemImageViews[2].frame
//                    tempPoint = selectedHero.itemImageViews[2].center
//                }
//                else if (slotNumber == 4) {       // Trinket
//                    //undecided on what properties trinkets can have
//                    selectedHero.items[3] = selectedItem
//                    selectedItem.itemButton.frame = selectedHero.itemImageViews[3].frame
//                    tempPoint = selectedHero.itemImageViews[3].center
//                }
    
    func loadSavedValues() {
        //savedValues.set(0, forKey: "saveKey")
        
    }
    
    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: Label/Button Declarations
    var gold = 0
    
    var mapPage = 0
    var levelNumber = 0
    var activeHeroCount = 0
    var currentLoadTable = 0
    var screenCounter = 0
//    var heroCounter = 0
    var mapCoordinate = 0
    var attackTimerChecker = false
    var touchPointX: CGFloat?
    var touchPointY: CGFloat?
    var selectedCount = false
    var enemyLoadTableFirst: [Character] = []
    var enemyLoadTableSecond: [Character] = []
    var enemyLoadTableThird: [Character] = []
    var enemyLoadTableFourth: [Character] = []
    var enemyLoadTableFifth: [Character] = []
    var enemyLoadTableSixth: [Character] = []
    var priorClass = MissingHero
    var pauseChecker = false
    var currentItemNumber = 0
    
    @IBOutlet weak var titleLabelOne: UILabel!
    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var saveStateStack: UIStackView!
    @IBOutlet weak var armoryStack: UIStackView!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var equipmentButton: UIButton!
    @IBOutlet weak var skillsButton: UIButton!
    @IBOutlet weak var recruitButton: UIButton!
    @IBOutlet weak var heroesButton: UIButton!
    @IBOutlet weak var switchMapLeft: UIButton!
    @IBOutlet weak var switchMapRight: UIButton!
    @IBOutlet weak var mapView2: UIImageView!
    @IBOutlet weak var mapView1: UIImageView!
    @IBOutlet weak var mapView3: UIImageView!
    @IBOutlet weak var activeHeroPortraits: UIImageView!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var saveFileOne: UIButton!
    @IBOutlet weak var saveFileTwo: UIButton!
    @IBOutlet weak var saveFileThree: UIButton!
    @IBOutlet weak var deSelectButton: UIButton!
    @IBOutlet weak var combatBackground: UIImageView!
    @IBOutlet weak var tapRecognizerView: UIView!
    
    //MARK: Character Merc'd
    
    private func characterKilled(character: Character, characterListPosition: Int, attacker: Character) {
        character.imageView.stopAnimating()
        character.animation.stopAnimation(true)
        
        //character.imageView.animationImages = character.deathImages           //impliment once death images have been made
        //character.imageView.animationDuration = 1.0
        //character.imageView.animationRepeatCount = 1
        //character.imageView.startAnimating()
        
//        Timer.scheduledTimer(withTimeInterval: character.imageView.animationDuration, repeats: false) { (_) in
//            character.imageView.removeFromSuperview()
//        }
        
        character.imageView.removeFromSuperview()        //Remove once death animations are implimented
        if (character.isEnemy == true){
            currentLevel.enemyLoadTable[currentLoadTable][characterListPosition] = MissingEnemy
            for i in 0..<currentLevel.enemyLoadTable[currentLoadTable].count {
                if (currentLevel.enemyLoadTable[currentLoadTable][i].name != MissingEnemy.name) {return}
            }
            currentLoadTable += 1
            if (currentLoadTable * currentLevel.enemyLoadTable[currentLoadTable-1].count > currentLevel.enemyLoadTable.count) {
                currentLevel.complete = true
                combatEnded(level: currentLevel)
                return
            }
        }
        else {
            activeHeroCount -= 1
            if (activeHeroCount <= 0) {
                currentLevel.complete = false
                combatEnded(level: currentLevel)
                return
            }
            if (attacker.secondaryThreat != nil) {attacker.target = attacker.secondaryThreat!}
            for i in 0...3 {
                if (activeHeroes[i].name == selectedHero.name) {self.deSelectHero()}
            }
        }
    }
    
    private func deSelectHero() {
        selectedHero = MissingHero
        deSelectButton.isHidden = true
    }
    
    //MARK: Animate Attack
    
    func animateAttack(heroClass: Character, target: Character, attackedListPosition: Int? = -1) {
        if (target.name == MissingHero.name) {return}
        if (heroClass.target!.name == target.name && heroClass.heroShouldNotAttack == true) {return}
        if (heroClass.isEnemy == false) {heroClass.target = target}
        for i in 0..<heroClass.abilityCheckers.count {
            if (heroClass.abilityCheckers[i] == true) {
                let currentSelector : Selector = NSSelectorFromString(heroClass.abilityNames[i])
                selector.perform(currentSelector)
                heroClass.abilityCheckers[i] = false
            }
        }
        heroClass.heroShouldNotAttack = true
        let duration = 1/heroClass.attackSpeed
        heroClass.imageView.animationImages = heroClass.attackImages
        heroClass.imageView.animationDuration = duration
        heroClass.imageView.animationRepeatCount = 0
        heroClass.imageView.startAnimating()
        heroClass.attackTimer = Timer.scheduledTimer(withTimeInterval: duration, repeats: true) { (_) in
            let xDist = heroClass.imageView.center.x - target.imageView.center.x
            let verticalModifier = target.imageView.frame.origin.y + (target.imageView.frame.height - 180)
            let dist = abs(heroClass.imageView.center.x - target.imageView.center.x)+abs(verticalModifier - heroClass.imageView.frame.origin.y + heroClass.imageView.frame.height - 180)
            target.HP -= (heroClass.autoAttackDamage * ((1/target.armorValue) * 10))
            print("Target HP  \(target.HP)")
            if (heroClass.armorValue > target.target!.armorValue && heroClass.isEnemy == true) {
                target.secondaryThreat = target.target
                target.target = heroClass
            }
            if (heroClass.isFacingRight == true) {
                target.imageView.center.x += 10
                if (target.imageView.center.x > self.tapRecognizerView.frame.maxX) {
                    self.animateMovementPrimary(location: CGPoint(x: self.tapRecognizerView.frame.maxX - target.imageView.frame.width / 2, y: target.imageView.frame.origin.y - 180 + target.imageView.frame.height), heroClass: target)
                }
            }
            else {
                target.imageView.center.x -= 10
                if (target.imageView.center.x < self.tapRecognizerView.frame.minX) {
                    self.animateMovementPrimary(location: CGPoint(x: self.tapRecognizerView.frame.minX + target.imageView.frame.width / 2, y: target.imageView.frame.origin.y - 180 + target.imageView.frame.height), heroClass: target)
                }
            }
            
            if (target.HP <= 0) {
                heroClass.imageView.stopAnimating()
                heroClass.attackTimer.invalidate()
                print("Target Killed - Attack Timer invalidated")
                heroClass.attackTimerChecker = false
                self.characterKilled(character: target, characterListPosition: attackedListPosition!, attacker: heroClass)
                return
            }
            
            if (dist >= 260 && heroClass.isMelee && currentLevel.enemyLoadTable[self.currentLoadTable][attackedListPosition!].name != MissingEnemy.name) {
                heroClass.imageView.stopAnimating()
                heroClass.attackTimer.invalidate()
                heroClass.attackTimerChecker = true
                if (xDist > 0) {
                    heroClass.isFacingRight = false
                    self.animateMovementPrimary(location: CGPoint(x: target.imageView.center.x + 3*(target.imageView.frame.width / 4), y: verticalModifier), heroClass: heroClass, target: target, attackedListPosition: attackedListPosition)
                }
                else {
                    heroClass.isFacingRight = true
                    self.animateMovementPrimary(location: CGPoint(x: target.imageView.center.x - 3*(target.imageView.frame.width / 4), y: verticalModifier), heroClass: heroClass, target: target, attackedListPosition: attackedListPosition)
                }
            }
        }
    }
    
    
    
    //      Re-enable and fix when projectile images/healing images are made
    func animateRangedAttack(heroClass: Character, target: Character, attackedListPosition: Int? = -1) {      //no projectile images have been made - will be implimented once they have been
//        let projectileImageView: UIImageView
//
//        projectileImageView.animationImages = heroClass.projectileImages!
//        projectileImageView.animationDuration = heroClass.attackSpeed
//        projectileImageView.animationRepeatCount = 0
//
//        animateAttack(heroClass: heroClass)
//        Timer.scheduledTimer(withTimeInterval: heroClass.attackSpeed, repeats: true) { (_) in
//            projectileImageView.center = heroClass.imageView.center
//            target.HP -= heroClass.autoAttackDamage
//            UIView.animate(withDuration: heroClass.attackSpeed) {
//                projectileImageView.center = target.imageView.center
//            }
//        }
//        Timer.scheduledTimer(withTimeInterval: heroClass.attackSpeed, repeats: false) { (_) in
//            projectileImageView.startAnimating()
//        }
    }
    
    func animateHealing(heroClass: Character, target: Character) {      //no healer images have been made - will be implimented once they have been
//        let healingImageView: UIImageView
//        healingImageView.center = target.imageView.center
//
//        healingImageView.animationImages = heroClass.healingImages!
//        healingImageView.animationDuration = heroClass.attackSpeed
//        healingImageView.animationRepeatCount = 0
//
//        animateAttack(heroClass: heroClass)
//        Timer.scheduledTimer(withTimeInterval: heroClass.attackSpeed, repeats: true) { (_) in
//            target.HP -= heroClass.autoAttackDamage
//        }
//        Timer.scheduledTimer(withTimeInterval: heroClass.attackSpeed, repeats: false) { (_) in
//            healingImageView.startAnimating()
//        }
    }
    
    func animateMovementPrimary(location: CGPoint, heroClass: Character, target: Character? = MissingHero, attackedListPosition: Int? = -1, combatEnded: Bool? = false) {
        if (heroClass.heroShouldNotAttack == true) {heroClass.imageView.stopAnimating()}
        heroClass.heroShouldNotAttack = false
        if (heroClass.name == MissingHero.name) {return}
        if (heroClass.movementSpeed == 0) {
            heroClass.imageView.frame.origin.y = location.y - heroClass.imageView.frame.height + 180
            heroClass.imageView.center.x = location.x
            return
        }
        heroClass.attackTimer.invalidate()
        heroClass.animation.stopAnimation(true)
//        if (heroClass.imageView.isAnimating == true) {heroClass.imageView.stopAnimating()}
        heroClass.attackTimer.invalidate()
        
        let xDist = Double(abs(location.x - heroClass.imageView.center.x))
        let yDist = abs(Double((location.y + 180) - heroClass.imageView.frame.origin.y - heroClass.imageView.frame.height))
        var timeUntilCompletion = 1.0
        var numberOfLoops = 1.0
        let duration = (Double(heroClass.imageNumberMovement) / 5.0)
        var multiplierConstant = 1.0
        if (xDist != 0 && yDist != 0) {
            let proportionality = (yDist / xDist) + 1
            multiplierConstant = heroClass.movementSpeed / proportionality
            numberOfLoops = xDist/multiplierConstant
            timeUntilCompletion = (duration * numberOfLoops)
        }
        else if (xDist == 0 && yDist != 0) {
            numberOfLoops = yDist / heroClass.movementSpeed
            timeUntilCompletion = (duration * numberOfLoops)
        }
        else if (xDist != 0 && yDist == 0) {
            numberOfLoops = xDist / heroClass.movementSpeed
            timeUntilCompletion = (duration * numberOfLoops)
        }
        else {
            return
        }
        
        if (heroClass.imageView.isAnimating == false) {
            heroClass.imageView.animationImages = heroClass.movementImages
            heroClass.imageView.animationDuration = duration
            heroClass.imageView.animationRepeatCount = 0
            heroClass.imageView.startAnimating()
        }
        print("Time until completion  "+String(timeUntilCompletion))
        
        heroClass.animation = UIViewPropertyAnimator(duration: timeUntilCompletion, curve: .linear, animations: {
            heroClass.imageView.frame.origin.y = location.y - heroClass.imageView.frame.height + 180 // 180 is the difference between 0 point in Y for tap in View vs tapViewRecognizer view
            heroClass.imageView.center.x = location.x
        })
        heroClass.animation.startAnimation()
        
        if (heroClass.timerCheck == true) {heroClass.movementTimer.invalidate()}
        heroClass.movementTimer = Timer.scheduledTimer(withTimeInterval: timeUntilCompletion, repeats: false) { (_) in
            heroClass.timerCheck = true
            heroClass.imageView.stopAnimating()
            if (heroClass.attackTimerChecker == true || combatEnded == true) {
                heroClass.attackTimerChecker = false
                if (combatEnded == true) {
                    print("combat has ended - rewards are being displayed shortly")
                    self.displayRewards()
                    return
                }
                print("Hero Arrived at Enemy and is Attacking   \(target!.name)")
                self.animateAttack(heroClass: heroClass, target: target!, attackedListPosition: attackedListPosition!)
            }
        }
    }
    
    
    //MARK: On Touch Handler
    // very important function - causes every touch during combat to do its thing
    
    
    
    
    @IBAction func combatTap(_ sender: UITapGestureRecognizer) {
//        let touchedImageView = self.view.hitTest(sender.location(in: tapRecognizerView), with: nil)
        
        //                              Test Code End
        
                for i in 0...3 {
                    print("For Loop \(i+1) Begun")
//                    let heroRect = activeHeroes[i].imageView.frame
                    let heroRect = CGRect(origin: CGPoint(x: activeHeroes[i].imageView.frame.minX, y: activeHeroes[i].imageView.frame.minY - 180), size: activeHeroes[i].imageView.frame.size)
                    print("set heroRect")
                    if (heroRect.contains(sender.location(in: tapRecognizerView))) {     //Checks if the user clicked on an allied hitbox
                        if (selectedHero.isHealer == true && selectedCount == false) {           //Checks for if healing is gonna happen or de-select healer
                            animateHealing(heroClass: selectedHero, target: activeHeroes[i])
                            selectedHero.target = activeHeroes[i]
                            selectedCount = true
                            print("selected hero is healer and is healing")
                            return
                        }
                        selectedHero = activeHeroes[i]
                        deSelectButton.isHidden = false
                        loadAbilityButtons(heroClass: selectedHero)
                        selectedCount = false
                        print("hero selected by user click on heroRect \(i+1)")
                        return
                    }

                    let enemyRect = CGRect(origin: CGPoint(x: activeEnemies[i].imageView.frame.minX, y: activeEnemies[i].imageView.frame.minY - 180), size: activeEnemies[i].imageView.frame.size)
                    print("enemyRect made")
                                        //re-enable after projectile/healing images are done
                    if (selectedHero.name == MissingHero.name) {print("No hero is selected")}
                    if (enemyRect.contains(sender.location(in: tapRecognizerView)) && selectedHero.name != MissingHero.name) {   //Checks if the user clicked on an ememy hitbox to attack it
                        print("Enemy selected")
                        let verticalModifier = activeEnemies[i].imageView.frame.origin.y + (activeEnemies[i].imageView.frame.height - 180)
                        var counter = -1
                        for j in 0..<currentLevel.enemyLoadTable.count{
                            if (currentLevel.enemyLoadTable[currentLoadTable][j].name == activeEnemies[i].name) {counter = j}
                        }
                        if (selectedHero.isHealer == false) {
                            print("selected hero not a healer")
                            selectedHero.target = activeEnemies[i]
                            if (selectedHero.isMelee == false && selectedHero.name != MissingHero.name) {
                                animateRangedAttack(heroClass: selectedHero, target: activeEnemies[i])
                                print("selected hero is ranged and shooting selected enemy - no movement")
                                return
                            }

                            else if (selectedHero.imageView.center.x <= activeEnemies[i].imageView.center.x) {
                                selectedHero.isFacingRight = true
                                selectedHero.attackTimerChecker = true
                                animateMovementPrimary(location: CGPoint(x: activeEnemies[i].imageView.center.x - 3*(activeEnemies[i].imageView.frame.width / 4), y: verticalModifier), heroClass: selectedHero, target: activeEnemies[i], attackedListPosition: counter)
                                print("selected hero is melee and moves to attack from the left")
                                return
                            }
                            else {
                                selectedHero.isFacingRight = false
                                selectedHero.attackTimerChecker = true
                                animateMovementPrimary(location: CGPoint(x: activeEnemies[i].imageView.center.x + 3*(activeEnemies[i].imageView.frame.width / 4), y: verticalModifier), heroClass: selectedHero, target: activeEnemies[i], attackedListPosition: counter)
                                print("selected hero is melee and moves to attack from the right")
                                return
                            }
                        }
                    }
                }
        if (selectedHero.name != MissingHero.name) {
                animateMovementPrimary(location: sender.location(in: tapRecognizerView), heroClass: selectedHero)       //moves selected hero so long as the user clicked only on the map
                print("selected hero is moved to the location \(sender.location(in: tapRecognizerView))")
                return
        }
    }
    
    //MARK: Text Field Functions
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if saveFileChecker == 1 { saveOneName = textField.text}
        if saveFileChecker == 2 { saveTwoName = textField.text}
        if saveFileChecker == 3 { saveThreeName = textField.text}
        textField.isHidden = true
        loadTutorial()
    }
    
    //MARK: Remove Title Screen
    
    @IBAction func removeTitleScreen(_ sender: UIButton) {
        titleButton.removeFromSuperview()
        titleLabelOne.removeFromSuperview()
        titleImage.removeFromSuperview()
        saveStateStack.isHidden = false
        
        tapRecognizerView.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.15, alpha: 1.0)
        
        resetTalentsButton.addTarget(self, action: #selector(resetTalents), for: .touchUpInside)       //Basically ViewDidLoad but not o_0
    }
    
    //MARK: Chose save file
    
    @IBAction func startSaveOne(_ sender: UIButton) {
        saveFileChecker = 1
        saveStateStack.isHidden = true
        if (saveOneName == nil) { enterNameField.isHidden = false }
        else {armoryStack.isHidden = false}
    }
    
    @IBAction func startSaveTwo(_ sender: UIButton) {
        saveFileChecker = 2
        saveStateStack.isHidden = true
        if (saveTwoName == nil) { enterNameField.isHidden = false }
        else {armoryStack.isHidden = false}
    }

    @IBAction func startSaveThree(_ sender: UIButton) {
        saveFileChecker = 3
        saveStateStack.isHidden = true
        if (saveThreeName == nil) { enterNameField.isHidden = false }
        else {armoryStack.isHidden = false}
    }
    
    //MARK: Play Tutorial
    
    func loadTutorial() {
        //armoryStack.isHidden = false
        activeHeroes[0] = Warrior
        loadCombatScreen(level: Tutorial)
        loadActiveHeroes(level: Tutorial)
//        beginCombat()
    }
    
        //MARK: Load Active Heroes/Enemies
        
        private func loadActiveHeroes(level: Level) {
    //        let xCenter = (view.bounds.maxX - view.bounds.minX) / 2
    //        let yCenter = (view.bounds.maxY - view.bounds.minY) / 2
            currentLevel = level
            var minMS = 0.0
            for i in 0...3 {
                self.view.addSubview(activeHeroes[i].imageView)
                if (activeHeroes[i].secondaryImageView != nil) {self.view.addSubview(activeHeroes[i].secondaryImageView!)}
                if (activeHeroes[i].movementSpeed >= minMS) {minMS = activeHeroes[i].movementSpeed}
    //            animateMovementPrimary(location: activeHeroes[i].positionList[i], heroClass: activeHeroes[i])
            }
            if (activeHeroes[0].exists) {
                activeHeroCount += 1
                activeHeroes[0].imageView.center.x = view.center.x
                activeHeroes[0].imageView.center.y = view.bounds.minY - 100  //sets hero outside left of screen to prep intro animation
                animateMovementPrimary(location: CGPoint(x: view.center.x, y: view.center.y - 100), heroClass: activeHeroes[0]) //animates character to left middle center from outside view on left middle
            }
            if (activeHeroes[1].exists) {
                activeHeroCount += 1
                activeHeroes[1].imageView.center.x = view.bounds.minX - 100  //follows pattern for top mid
                activeHeroes[1].imageView.center.y = view.center.y
                animateMovementPrimary(location: CGPoint(x: view.center.x - 100, y: view.center.y), heroClass: activeHeroes[1])

            }
            if (activeHeroes[2].exists) {
                activeHeroCount += 1
                activeHeroes[2].imageView.center.x = view.center.x
                activeHeroes[2].imageView.center.y = view.bounds.maxY + 100  //sets hero outside right of screen to prep intro animation
                animateMovementPrimary(location: CGPoint(x: view.center.x, y: view.center.y + 100), heroClass: activeHeroes[2]) //animates character to right middle center from outside view on right middle

            }
            if (activeHeroes[3].exists) {
                activeHeroCount += 1
                activeHeroes[3].imageView.center.x = view.bounds.maxX + 100  //follows pattern for bot mid
                activeHeroes[3].imageView.center.y = view.center.y
                animateMovementPrimary(location: CGPoint(x: view.center.x + 100, y: view.center.y), heroClass: activeHeroes[3])
            }
            print("Active Hero Count:  \(activeHeroCount)")
            Timer.scheduledTimer(withTimeInterval: (Double(view.bounds.maxX - view.center.x) / minMS), repeats: false) { (_) in
                self.beginCombat()
            }
        }
    
    private func loadEnemy(enemy: Character) {
        if (enemy.name != MissingEnemy.name && enemy.isMelee == false) {
            self.view.addSubview(enemy.imageView)
            if (enemy.secondaryImageView != nil) {self.view.addSubview(enemy.secondaryImageView!)}
            let yRange = Range(uncheckedBounds: (lower: tapRecognizerView.frame.minY + (enemy.imageView.frame.height / 2), upper: tapRecognizerView.frame.maxY - (enemy.imageView.frame.height / 2)))
            //let x = CGFloat.random(in: xRange)
            let x = Int.random(in: 50...850)
            let y = CGFloat.random(in: yRange)
            enemy.imageView.center = CGPoint(x: CGFloat(x), y: y)
        }
        else if (enemy.name != MissingEnemy.name){
            let randomY = CGFloat.random(in: Range(uncheckedBounds: (lower: tapRecognizerView.frame.minY + (enemy.imageView.frame.height / 2), upper: tapRecognizerView.frame.maxY - (enemy.imageView.frame.height / 2))))
            let randomNumber = Int.random(in: Range(uncheckedBounds: (lower: 0, upper: 1)))
            var randomX = CGFloat(0)
            if (randomNumber == 0) {
                randomX = CGFloat.random(in: Range(uncheckedBounds: (lower: tapRecognizerView.frame.minX - 100, upper: tapRecognizerView.frame.minX)))
            }
            else {
                randomX = CGFloat.random(in: Range(uncheckedBounds: (lower: tapRecognizerView.frame.maxX, upper: tapRecognizerView.frame.maxX + 100)))
            }
            enemy.imageView.center = CGPoint(x: randomX, y: randomY)
        }
    }
    
    //MARK: Load Combat/Combat Ended
    
    func loadLevel(level: Level) {
        loadCombatScreen(level: level)
        loadActiveHeroes(level: level)      //loadActiveHeroes sets the currentLevel to the level set by map selection -- map selection has not been implimented since the images have not been made
    }
    
    private func beginCombat() {
        tapRecognizerView.isHidden = false
        for i in 0..<currentLevel.enemyLoadTable[currentLoadTable].count {
            loadEnemy(enemy: currentLevel.enemyLoadTable[currentLoadTable][i])
            activeEnemies[i] = currentLevel.enemyLoadTable[currentLoadTable][i]     //Active enemies' declaration only gives it a max dim of 4
        }
        // implimentation for map level selection will determine which level object is called here - map has not yet been made so it is not implimented
    }
    
    private func combatEnded(level: Level) {
        tapRecognizerView.isHidden = true
        deSelectButton.isHidden = true
        abilityButtonOne.isHidden = true
        abilityButtonTwo.isHidden = true
        abilityButtonThree.isHidden = true
        abilityButtonFour.isHidden = true
        for i in 0...3 {
            for j in 0..<activeHeroes[i].abilityTimers.count {
                activeHeroes[i].abilityTimers[j].invalidate()
            }
        }
        if (level.complete == true) {
            var checker = false
            gold += level.goldReward
            for i in 0...3 {
                activeHeroes[i].xp += Int(activeHeroes[i].xpModifier * Double(level.xpReward / activeHeroCount))
                for j in 0...3 {
                    if (itemArray[i][j].name == MissingItem.name && checker == false) {itemArray[i][j] = level.itemReward
                        selectedItem = itemArray[i][j]
                        itemArray[i][j].itemButton.frame = itemImageArray[i][j].frame
                        checker = true
                        print("Item Obtained  \(selectedItem.name)")
                        print("Added at:  \(itemImageArray[i][j].frame)")
                    }
                }
            }
        }
        else {
            print("Level Failed")
            for i in 0..<currentLevel.enemyLoadTable[currentLoadTable].count {
                currentLevel.enemyLoadTable[currentLoadTable][i].imageView.removeFromSuperview()
            }
            //          Add combat defeat screen
        }
        resetCombat()
    }
    
    func resetCombat() {
        pauseButton.isHidden = true
        for i in 0...3{
            activeHeroes[i].reset()
            if (activeHeroes[i].exists) {
                animateMovementPrimary(location: CGPoint(x: (view.center.x - CGFloat(150 - (i * 100))), y: view.center.y), heroClass: activeHeroes[i], combatEnded: true)
            }
        }
        currentLevel.enemyLoadTable = currentLevel.baseLoadTable
        activeHeroCount = 0
    }
    
    private func displayRewards() {
        // this will display gold, xp, items won based upon the level's set values
        // not yet implimented since pictures of each reward are not yet made
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (_) in
            for i in 0...3 {
                activeHeroes[i].imageView.removeFromSuperview()
                if (activeHeroes[i].secondaryImageView != nil) {activeHeroes[i].secondaryImageView!.removeFromSuperview()}
            }
            print("Warrior XP after combat:  \(Warrior.xp)")
            self.returnToArmory()
        }
    }
    
    private func loadCombatScreen(level: Level) {
        //level.combatBackground.isHidden = false         image not yet made
        pauseButton.isHidden = false
    }
    
    
    //MARK: Armory
    //returns the view to Armory from selection screens
    
    private func returnToArmory() {
        returnButton.isHidden = true
        mapView1.isHidden = true
        mapView2.isHidden = true
        mapView3.isHidden = true
        activeHeroPortraits.isHidden = true     // Will eventually be deleted
        switchMapRight.isHidden = true
        switchMapLeft.isHidden = true
        armoryStack.isHidden = false
        missingTextView.isHidden = true
        missingTextView.text = "No item images/character portraits have been made yet, thus this screen is uninstalled"
        selectedHero.talentTree.isHidden = true
        for i in 0...3 {
            selectedHero.itemImageViews[i].isHidden = true
            selectedHero.items[i].itemButton.isHidden = true
            for j in 0...3 {
                itemImageArray[i][j].isHidden = true
                itemArray[i][j].itemButton.isHidden = true
            }
            for j in 0...2 {
                talentButtons[i][j].isHidden = true
            }
        }
        hideItemInventoryButtons()
        descriptorLabel.isHidden = true
        descriptorLabel.text = ""
        resetTalentsButton.isHidden = true
        confirmButton.isHidden = true
    }
    
     @IBAction func returnToArmory(_ sender: Any) {
         returnToArmory()
     }
    
    //MARK: Map
    @IBAction func mapButton(_ sender: UIButton) {
        mapPage = 1
        armoryStack.isHidden = true
        mapView1.isHidden = false
        switchMapRight.isHidden = false
        returnButton.isHidden = false
    }
 
    @IBAction func switchMapRight(_ sender: UIButton) {
        switchMapLeft.isHidden = false
        mapPage += 1
        if (mapPage == 2) {mapView1.isHidden = true
            mapView2.isHidden = false}
        else {mapView3.isHidden = false
            switchMapRight.isHidden = true}
    }
    @IBAction func switchMapLeft(_ sender: UIButton) {
        switchMapRight.isHidden = false
        mapPage -= 1
        if (mapPage == 1) {mapView2.isHidden = true
            mapView1.isHidden = false
            switchMapLeft.isHidden = true}
        else {mapView3.isHidden = true
            mapView2.isHidden = false
        }
    }
    /*
    impliment buttons for each level - once map has been created
    */
    
    fileprivate func hideItemInventoryButtons() {
        equipmentButtonOne.isHidden = true
        equipmentButtonTwo.isHidden = true
        equipmentButtonThree.isHidden = true
        equipmentButtonFour.isHidden = true
    }
    
    fileprivate func showItemInventoryButtons() {
        equipmentButtonOne.isHidden = false
        equipmentButtonTwo.isHidden = false
        equipmentButtonThree.isHidden = false
        equipmentButtonFour.isHidden = false
    }
    
    //MARK: Equipment Screen
    
    @IBAction func equipmentScreen(_ sender: UIButton) {
        armoryStack.isHidden = true
        activeHeroPortraits.isHidden = false     // Will eventually be deleted
        selectedHero = activeHeroes[0]           // Will eventually be deleted
        returnButton.isHidden = false
        for i in 0...3 {
            selectedHero.itemImageViews[i].isHidden = false
            selectedHero.items[i].itemButton.isHidden = false
            for j in 0...3 {
                itemImageArray[i][j].isHidden = false
                if (itemArray[i][j].name != MissingItem.name) {itemArray[i][j].itemButton.isHidden = false}
            }
        }
        showItemInventoryButtons()
        descriptorLabel.isHidden = false
    }
    
    //MARK: Skill Screen
    @IBAction func skillsScreen(_ sender: UIButton) {
        
        //the full image container of all hero's hasn't been made yet - impliment selection screen once images are made
        
        armoryStack.isHidden = true
        returnButton.isHidden = false
        screenCounter = 1
        
        for i in 0...3 {
            for j in 0...2 {
                talentButtons[i][j].isHidden = false
            }
        }
    }
    
    @objc func selectHero(_ sender: UIButton) {
        for i in 0...3 {
            for j in 0...2 {
                if (talentButtons[i][j].frame == sender.frame) {
                    selectedHero = heroArray[i][j]
                }
            }
        }
        for i in 0...3 {
            for j in 0...2 {
                talentButtons[i][j].removeTarget(self, action: #selector(selectHero), for: .touchUpInside)
            }
        }
        selector.perform(NSSelectorFromString("talentTree\(selectedHero.name)"))
    }
    
    @objc func resetTalents() {
        selectedHero.currentTalentPoints = selectedHero.baseTalentPoints
        selectedHero.maxTalentPoints = selectedHero.baseMaxTalentPoints
        for i in 0...3 {
            for j in 0...2 {
                talentButtons[i][j].setTitle("", for: .normal)
            }
        }
        print("Talent points reset!")
        //          Undo the augments to ability/physical damage/healing and armor and MS -- undo all talents on selected hero
        //          Impliment once all talents are made
        
    }
    
    
    //MARK: Rectuit Screen
    @IBAction func recruitScreen(_ sender: UIButton) {
        
        //None of this has been implimented - thus it is currently uninstalled
        
        armoryStack.isHidden = true
        returnButton.isHidden = false
//        fullBodyCharacterView.isHidden = false
        missingTextView.isHidden = false
        
    }
    
    
    //MARK: Heroes Screen
    @IBAction func heroesScreen(_ sender: UIButton) {
        
        //the full image container of all hero's hasn't been made yet - impliment selection screen once images are made
        
        armoryStack.isHidden = true
        returnButton.isHidden = false
//        screenCounter = 2
//        leadCastPortraitStack.isHidden = false
//        activeHeroPortraits.isHidden = false
        missingTextView.isHidden = false
    }
    
    @IBAction func deSelectActiveHero(_ sender: Any) {
        selectedHero = MissingHero
        deSelectButton.isHidden = true
        abilityButtonOne.isHidden = true
        abilityButtonTwo.isHidden = true
        abilityButtonThree.isHidden = true
        abilityButtonFour.isHidden = true
    }
    
    
    private func loadAbilityButtons(heroClass: Character) {

        if (priorClass.name != MissingHero.name) {
            if (priorClass.abilityExistanceCheckers[0] == true) {abilityButtonOne.removeTarget(heroClass, action: #selector(heroClass.abilityOne), for: .touchUpInside)}
            if (priorClass.abilityExistanceCheckers[1] == true) {abilityButtonTwo.removeTarget(heroClass, action: #selector(heroClass.abilityTwo), for: .touchUpInside)}
            if (priorClass.abilityExistanceCheckers[2] == true) {abilityButtonThree.removeTarget(heroClass, action: #selector(heroClass.abilityThree), for: .touchUpInside)}
            if (priorClass.abilityExistanceCheckers[3] == true) {abilityButtonFour.removeTarget(heroClass, action: #selector(heroClass.abilityFour), for: .touchUpInside)}
        }
        if (heroClass.abilityExistanceCheckers[0] == true) {
            abilityButtonOne.isHidden = false
            abilityButtonOne.addTarget(heroClass, action: #selector(heroClass.abilityOne), for: .touchUpInside)
        }
        if (heroClass.abilityExistanceCheckers[1] == true) {
            abilityButtonTwo.isHidden = false
            abilityButtonTwo.addTarget(heroClass, action: #selector(heroClass.abilityTwo), for: .touchUpInside)
        }
        if (heroClass.abilityExistanceCheckers[2] == true) {
            abilityButtonThree.isHidden = false
            abilityButtonThree.addTarget(heroClass, action: #selector(heroClass.abilityThree), for: .touchUpInside)
        }
        if (heroClass.abilityExistanceCheckers[3] == true) {
            abilityButtonFour.isHidden = false
            abilityButtonFour.addTarget(heroClass, action: #selector(heroClass.abilityFour), for: .touchUpInside)
        }
        priorClass = heroClass
        print("Ability Buttons have been loaded for selected hero")
    }
    
    @objc func pauseGame() {            //needs work for stopping all timers -- code needed to grey out screen showing that game is paused -- this would also be called when game is temp closed
        if (pauseChecker == false) {
            for i in 0...3 {
                if (activeHeroes[i].name != MissingHero.name) {
                    activeHeroes[i].animation.pauseAnimation()
                    for j in 0..<activeHeroes[i].abilityTimers.count {
                        activeHeroes[i].abilityTimerTrackers[j] = activeHeroes[i].abilityTimers[j].fireDate.timeIntervalSinceNow
                        activeHeroes[i].abilityTimers[j].invalidate()
                    }
                }
            }
            for i in 0..<currentLevel.enemyLoadTable[currentLoadTable].count {                  //no enemies have abilities yet so there is nothing for stopping enemy abilities
                if (activeEnemies[i].name != MissingEnemy.name) {
                    activeEnemies[i].animation.pauseAnimation()
                }
            }
            pauseChecker = true
            return
        }
        if (pauseChecker == true) {
            for i in 0...3 {
                if (activeHeroes[i].name != MissingHero.name) {
                    activeHeroes[i].animation.startAnimation()
                    for j in 0..<activeHeroes[i].abilityTimers.count {
                        activeHeroes[i].abilityTimers[j] = Timer.scheduledTimer(withTimeInterval: activeHeroes[i].abilityTimerTrackers[j], repeats: false, block: { (_) in       //what do MH?
                            activeHeroes[i].abilityCooldowns[j] = false
                        })
                    }
                }
            }
            for i in 0..<currentLevel.enemyLoadTable[currentLoadTable].count {
                if (activeEnemies[i].name != MissingEnemy.name) {
                    activeEnemies[i].animation.startAnimation()
                }
            }
        }

    }
    
    
    
}
