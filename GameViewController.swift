//
//  GameViewController.swift
//  Hail to the King
//
//  Created by Nick Sercel on 10/22/19.
//  Copyright © 2019 Whelps Cave Gaming. All rights reserved.
//

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

var missingTextView: UITextView = {             //Remove once all views are made with images
    var textView = UITextView(frame: CGRect(x: 100, y: 50, width: 300, height: 100))
    textView.text = "No item images/character portraits have been made yet, thus this screen is uninstalled"
    textView.isHidden = true
    return textView
}()


//Set proper image numbers when images are obtained
var MissingHero = Character(characterName: heroList[0], isEnemy: false, characterBaseImage: UIImage(named: "blackBackground")!, imageNumberAttack: 0, imageNumberMovement: 0, movementSpeed: 0.0, HP: 0, attackSpeed: 0.0, autoAttackDamage: 0, armorValue: 0, isMelee: false, isHealer: false)
var Warrior = Character(characterName: heroList[1], isEnemy: false, characterBaseImage: UIImage(named: "Warrior-1")!, imageNumberAttack: 4, imageNumberMovement: 5, movementSpeed: 350.0, HP: 150, attackSpeed: 10.0, autoAttackDamage: 3, armorValue: 40, isMelee: true, isHealer: false)
//var Cleric = Character(characterName: heroList[2], isEnemy: false, characterBaseImage: <#T##UIImage#>, imageNumberAttack: <#T##Int#>, imageNumberMovement: <#T##Int#>, movementSpeed: 30.0, HP: 75, attackSpeed: 1.5, autoAttackDamage: -15, isMelee: false, isHealer: true)
//var Druid = Character(characterName: heroList[3], isEnemy: false, characterBaseImage: <#T##UIImage#>, imageNumberAttack: <#T##Int#>, imageNumberMovement: <#T##Int#>, movementSpeed: 35.0, HP: 75, attackSpeed: 1.25, autoAttackDamage: 15, isMelee: false, isHealer: false)
//var Ranger = Character(characterName: heroList[4], isEnemy: false, characterBaseImage: <#T##UIImage#>, imageNumberAttack: <#T##Int#>, imageNumberMovement: <#T##Int#>, imageNumberProjectile: <#T##Int#>, imageNumberHeal: 0, movementSpeed: 35.0, HP: 75, attackSpeed: 2.0, autoAttackDamage: 10, isMelee: false, isHealer: false, secondaryBaseImage: <#T##UIImage?#>)
//
var MissingEnemy = Character(characterName: enemyList[0], isEnemy: true, characterBaseImage: UIImage(named: "blackBackground")!, imageNumberAttack: 0, imageNumberMovement: 0, movementSpeed: 0.0, HP: 0, attackSpeed: 0.0, autoAttackDamage: 0, armorValue: 0, isMelee: false, isHealer: false)
var SkeletonArcher1 = Character(characterName: enemyList[1], isEnemy: true, characterBaseImage: UIImage(named: "SkeletonArcher-1")!, imageNumberAttack: 3, imageNumberMovement: 0, imageNumberProjectile: 0, imageNumberHeal: 0, movementSpeed: 0.0, HP: 75, attackSpeed: 1.5, autoAttackDamage: 12, armorValue: 15, isMelee: false, isHealer: false, secondaryBaseImage: nil)
//var Goblin1 = Character(characterName: enemyList[2], isEnemy: true, characterBaseImage: <#T##UIImage#>, imageNumberAttack: <#T##Int#>, imageNumberMovement: <#T##Int#>, movementSpeed: 30.0, HP: 50, attackSpeed: 1.2, autoAttackDamage: 8, isMelee: true, isHealer: false)
//var Goblin2 = Character(characterName: enemyList[2], isEnemy: true, characterBaseImage: <#T##UIImage#>, imageNumberAttack: <#T##Int#>, imageNumberMovement: <#T##Int#>, movementSpeed: 30.0, HP: 50, attackSpeed: 1.2, autoAttackDamage: 8, isMelee: true, isHealer: false)

//var Warhammer = Item()

//var Arcanist = HeroClass(heroName: heroList[5], imageNumberAttack: 7, imageNumberMovement: 6, characterBaseImage: <#T##UIImage#>, imageNumberProjectile: <#T##Int#>, imageNumberHeal: 0)
//var Rogue = HeroClass(heroName: heroList[6], imageNumberAttack: 7, imageNumberMovement: 6, characterBaseImage: <#T##UIImage#>, imageNumberProjectile: <#T##Int#>, imageNumberHeal: 0)
//var Palladin = HeroClass(heroName: heroList[7], imageNumberAttack: 7, imageNumberMovement: 6, characterBaseImage: <#T##UIImage#>, imageNumberProjectile: <#T##Int#>, imageNumberHeal: 0)
//var Warlock = HeroClass(heroName: heroList[8], imageNumberAttack: 7, imageNumberMovement: 6, characterBaseImage: <#T##UIImage#>, imageNumberProjectile: <#T##Int#>, imageNumberHeal: 0)
//var Shaman = HeroClass(heroName: heroList[9], imageNumberAttack: 7, imageNumberMovement: 6, characterBaseImage: <#T##UIImage#>, imageNumberProjectile: <#T##Int#>, imageNumberHeal: 0)
//var Monk = HeroClass(heroName: heroList[10], imageNumberAttack: 7, imageNumberMovement: 6, characterBaseImage: <#T##UIImage#>, imageNumberProjectile: <#T##Int#>, imageNumberHeal: 0)
//var Alchemist = HeroClass(heroName: heroList[11], imageNumberAttack: 7, imageNumberMovement: 6, characterBaseImage: <#T##UIImage#>, imageNumberProjectile: <#T##Int#>, imageNumberHeal: 0)
//var Battlemage = HeroClass(heroName: heroList[12], imageNumberAttack: 7, imageNumberMovement: 6, characterBaseImage: <#T##UIImage#>, imageNumberProjectile: <#T##Int#>, imageNumberHeal: 0)

//var activeHeroes: [Character] = []
var activeHeroes = [MissingHero, MissingHero, MissingHero, MissingHero]

//var SkeletonArcher2 = EnemyClass(enemyName: "SkeletonArcher", imageNumberAttack: 7, imageNumberMovement: 7, enemyBaseImage: <#T##UIImage#>)
//var SkeletonArcher3 = EnemyClass(enemyName: "SkeletonArcher", imageNumberAttack: 7, imageNumberMovement: 7, enemyBaseImage: <#T##UIImage#>)
//var SkeletonArcher4 = EnemyClass(enemyName: "SkeletonArcher", imageNumberAttack: 7, imageNumberMovement: 7, enemyBaseImage: <#T##UIImage#>)

var activeEnemies: [Character] = [MissingEnemy, MissingEnemy, MissingEnemy, MissingEnemy]

let bronzeSword = Item(itemName: "Bronze Sword", equipableBy: [Warrior], damageValue: 2, appearance: UIImage(named: "blackBackground")!, price: 50, itemLevel: 1)
let MissingItem = Item(itemName: "0", equipableBy: [], damageValue: 0, appearance: UIImage(named: "blackBackground")!, price: 0, itemLevel: 0)

let Tutorial = Level(levelNumber: 0, goldReward: 50, itemReward: MissingItem, xpReward: 100, enemyLoadTable: [[SkeletonArcher1, MissingEnemy, MissingEnemy, MissingEnemy], [MissingEnemy, MissingEnemy]])
let MissingLevel = Level(levelNumber: -1, goldReward: 0, itemReward: MissingItem, xpReward: 0, enemyLoadTable: [])

var currentLevel = MissingLevel

class GameViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var enterNameField: UITextField!
    
    fileprivate func loadImageViews() {
        self.view.addSubview(SkeletonArcher1.imageView)
        
        self.view.addSubview(Warrior.imageView)
        
        self.view.addSubview(Warrior.talentTree)
        
        self.view.addSubview(missingTextView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
        loadSavedValues()
        loadImageViews()
        
        saveThreeName = "Jimbo"
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    func loadSavedValues() {
        //savedValues.set(0, forKey: "saveKey")
        
    }
    
    private func configureTextFields() {
        enterNameField.delegate = self
        enterNameField.placeholder = "Enter Name"
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
    var selectedHero: Character = MissingHero
    var currentLoadTable = 0
    var screenCounter = 0
//    var heroCounter = 0
    var mapCoordinate = 0
    var timerChecker = false
    var touchPointX: CGFloat?
    var touchPointY: CGFloat?
    var selectedCount = false
    var enemyLoadTableFirst: [Character] = []
    var enemyLoadTableSecond: [Character] = []
    var enemyLoadTableThird: [Character] = []
    var enemyLoadTableFourth: [Character] = []
    var enemyLoadTableFifth: [Character] = []
    var enemyLoadTableSixth: [Character] = []
    
    @IBOutlet weak var titleLabelOne: UILabel!
    @IBOutlet weak var titleLabelTwo: UILabel!
    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var saveStateStack: UIStackView!
    @IBOutlet weak var armoryStack: UIStackView!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var equipmentButton: UIButton!
    @IBOutlet weak var vendorButton: UIButton!
    @IBOutlet weak var skillsButton: UIButton!
    @IBOutlet weak var recruitButton: UIButton!
    @IBOutlet weak var heroesButton: UIButton!
    @IBOutlet weak var switchMapLeft: UIButton!
    @IBOutlet weak var switchMapRight: UIButton!
    @IBOutlet weak var mapView2: UIImageView!
    @IBOutlet weak var mapView1: UIImageView!
    @IBOutlet weak var mapView3: UIImageView!
    @IBOutlet weak var activeHeroPortraits: UIImageView!
    @IBOutlet weak var selectedCharacterArmor: UIImageView!
    @IBOutlet weak var armorStatView: UIImageView!
    @IBOutlet weak var ownedArmorView: UIImageView!
    @IBOutlet weak var armoryHeroTwo: UIButton!
    @IBOutlet weak var vendorView: UIImageView!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var saveFileOne: UIButton!
    @IBOutlet weak var saveFileTwo: UIButton!
    @IBOutlet weak var saveFileThree: UIButton!
    @IBOutlet weak var fullBodyCharacterView: UIImageView!
    @IBOutlet weak var ability1: UIButton!
    @IBOutlet weak var ability2: UIButton!
    @IBOutlet weak var ability3: UIButton!
    @IBOutlet weak var ability4: UIButton!
    @IBOutlet weak var combatAbilityStack: UIStackView!
    @IBOutlet weak var deSelectButton: UIButton!
    @IBOutlet weak var combatBackground: UIImageView!
    @IBOutlet weak var tapRecognizerView: UIView!
    
    func findTargetAndDamageHero(targetNumber: Int, enemyClass: Character) -> CGPoint {
        activeHeroes[targetNumber].HP -= enemyClass.autoAttackDamage
        return activeHeroes[targetNumber].imageView.center
    }
    
    //MARK: Image Animation
    
    func testAnimations() {
        //Add animations in here to test for errors
        
    }
    
    private func characterKilled(character: Character, characterListPosition: Int, attacker: Character) {
        character.imageView.stopAnimating()
        character.animation.stopAnimation(true)
        
        //character.imageView.animationImages = character.deathImages           //impliment once death images have been made
        //character.imageView.animationDuration = 1.0
        //character.imageView.animationRepeatCount = 1
        //character.imageView.startAnimating()
        
//        Timer.scheduledTimer(withTimeInterval: character.imageView.animationDuration, repeats: false) { (_) in
//            character.imageView.center = CGPoint(x: -500, y: -500)
//        }
        
        character.imageView.center = CGPoint(x: -500, y: -500)          //Remove once death animations are implimented
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
    
    func animateAttack(heroClass: Character, target: Character, attackedListPosition: Int? = -1) {
        let duration = 1/heroClass.attackSpeed
        heroClass.imageView.animationImages = heroClass.attackImages
        heroClass.imageView.animationDuration = duration
        heroClass.imageView.animationRepeatCount = 0
        heroClass.imageView.startAnimating()
        heroClass.attackTimer = Timer.scheduledTimer(withTimeInterval: duration, repeats: true) { (_) in
            let xDist = heroClass.imageView.center.x - target.imageView.center.x
            let verticalModifier = target.imageView.frame.origin.y + (target.imageView.frame.height - 180)
            let dist = abs(heroClass.imageView.center.x - target.imageView.center.x)+abs(verticalModifier - heroClass.imageView.frame.origin.y + heroClass.imageView.frame.height - 180)
            print("Attacking - Timer currently Validated")
            print("totalDist   \(dist)")
            print("List Placement :   \(attackedListPosition!)")
            target.HP -= heroClass.autoAttackDamage
            if (target.target != nil && heroClass.armorValue > target.target!.armorValue) {
                target.secondaryThreat = target.target
                target.target = heroClass
            }
            if (heroClass.isFacingRight == true) {
                target.imageView.center.x += 20
                if (target.imageView.center.x > self.tapRecognizerView.frame.maxX) {
                    self.animateMovementPrimary(location: CGPoint(x: self.tapRecognizerView.frame.maxX - target.imageView.frame.width / 2, y: target.imageView.frame.origin.y - 180 + target.imageView.frame.height), heroClass: target)
                }
            }
            else {
                target.imageView.center.x -= 20
                if (target.imageView.center.x < self.tapRecognizerView.frame.minX) {
                    self.animateMovementPrimary(location: CGPoint(x: self.tapRecognizerView.frame.minX + target.imageView.frame.width / 2, y: target.imageView.frame.origin.y - 180 + target.imageView.frame.height), heroClass: target)
                }
            }
            
            if (target.HP <= 0) {
                heroClass.imageView.stopAnimating()
                heroClass.attackTimer.invalidate()
                print("Target Killed - Attack Timer invalidated")
                heroClass.timerChecker = false
                self.characterKilled(character: target, characterListPosition: attackedListPosition!, attacker: heroClass)
                return
            }
            
            if (dist >= 260 && heroClass.isMelee && currentLevel.enemyLoadTable[self.currentLoadTable][attackedListPosition!].name != MissingEnemy.name) {
                print("Distance to attack is too far - moving closer")
                
                heroClass.imageView.stopAnimating()
                heroClass.attackTimer.invalidate()
                heroClass.timerChecker = true
                if (xDist > 0) {
                    print("Turning to face left and attacking right side")
                    heroClass.isFacingRight = false
                    self.animateMovementPrimary(location: CGPoint(x: target.imageView.center.x + 3*(target.imageView.frame.width / 4), y: verticalModifier), heroClass: heroClass, target: target, attackedListPosition: attackedListPosition)
                }
                else {
                    print("Turning to face right and attacking left side")
                    heroClass.isFacingRight = true
                    self.animateMovementPrimary(location: CGPoint(x: target.imageView.center.x - 3*(target.imageView.frame.width / 4), y: verticalModifier), heroClass: heroClass, target: target, attackedListPosition: attackedListPosition)
                }
            }
        }
    }
    
    
    
    //      Re-enable and fix when projectile images/healing images are made
    func animateRangedAttack(heroClass: Character, target: Character, attackedListPosition: Int? = -1, level: Level? = MissingLevel) {      //no projectile images have been made - will be implimented once they have been
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
        if (heroClass.name == MissingHero.name) {return}
        if (heroClass.movementSpeed == 0) {
            heroClass.imageView.frame.origin.y = location.y - heroClass.imageView.frame.height + 180
            heroClass.imageView.center.x = location.x
            return
        }
        heroClass.attackTimer.invalidate()
        heroClass.animation.stopAnimation(true)
        if (heroClass.imageView.isAnimating == true) {heroClass.imageView.stopAnimating()}
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
        
        heroClass.imageView.animationImages = heroClass.movementImages
        heroClass.imageView.animationDuration = duration
        heroClass.imageView.animationRepeatCount = Int(numberOfLoops) + 1
        heroClass.imageView.startAnimating()
        print("Time until completion  "+String(timeUntilCompletion))
        
        heroClass.animation = UIViewPropertyAnimator(duration: timeUntilCompletion, curve: .linear, animations: {
            heroClass.imageView.frame.origin.y = location.y - heroClass.imageView.frame.height + 180 // 180 is the difference between 0 point in Y for tap in View vs tapViewRecognizer view
            heroClass.imageView.center.x = location.x
//            heroClass.imageView.frame = CGRect(origin: CGPoint(x: location.x, y: location.y), size: heroClass.imageView.frame.size)
        })
        heroClass.animation.startAnimation()
        
        if (heroClass.timerChecker == true || combatEnded == true) {
            heroClass.timerChecker = false
            Timer.scheduledTimer(withTimeInterval: timeUntilCompletion, repeats: false) { (_) in
                if (combatEnded == true) {
                    print("combat has ended - rewards are being displayed shortly")
                    self.displayRewards()
                    return
                }
                print("Hero Arrived at Enemy and is Beginning Attack Animation")
                self.animateAttack(heroClass: heroClass, target: target!, attackedListPosition: attackedListPosition!)
            }
        }
    }
    
    
    //MARK: On Touch Handler
    // very important function - causes every touch during combat to do its thing
    
    @IBAction func combatTap(_ sender: UITapGestureRecognizer) {
                for i in 0...3 {
                    print("For Loop \(i+1) Begun")
//                    let heroRect = activeHeroes[i].imageView.frame
                    let heroRect = CGRect(origin: CGPoint(x: activeHeroes[i].imageView.frame.minX, y: activeHeroes[i].imageView.frame.minY - 180), size: activeHeroes[i].imageView.frame.size)
                    print("set heroRect")
                    if (heroRect.contains(sender.location(in: tapRecognizerView))) {     //Checks if the user clicked on an allied hitbox
                        if (selectedHero.isHealer == true && selectedCount == false) {           //Checks for if healing is gonna happen or de-select healer
                            animateHealing(heroClass: selectedHero, target: activeHeroes[i])
                            selectedCount = true
                            print("selected hero is healer and is healing")
                            return
                        }
                        selectedHero = activeHeroes[i]
                        deSelectButton.isHidden = false
                        //add code for ability buttons which show upon reaching this code segment (aka. .isHidden = false)
                        //will be implimented once images for abilities are made
                        selectedCount = false
                        print("hero selected by user click on heroRect \(i+1)")
                        return
                    }

//                    let enemyRect = CGRect(x: activeEnemies[i].imageView.center.x, y: activeEnemies[i].imageView.center.y, width: (activeEnemies[i].imageView.image?.size.width)!, height: (activeEnemies[i].imageView.image?.size.height)!)
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
                        if (selectedHero.isMelee == false && selectedHero.name != MissingHero.name) {
                            animateRangedAttack(heroClass: selectedHero, target: activeEnemies[i])
                            print("selected hero is ranged and shooting selected enemy - no movement")
                            return
                        }
                        else if (selectedHero.isHealer == true) {
                            print("selected hero is healer and does nothing")
                            return
                        }
                            
                        else if (selectedHero.imageView.center.x <= activeEnemies[i].imageView.center.x) {
                            selectedHero.isFacingRight = true
                            selectedHero.timerChecker = true
                            animateMovementPrimary(location: CGPoint(x: activeEnemies[i].imageView.center.x - 3*(activeEnemies[i].imageView.frame.width / 4), y: verticalModifier), heroClass: selectedHero, target: activeEnemies[i], attackedListPosition: counter)
                            print("selected hero is melee and moves to attack from the left")
                            return
                        }
                        else {
                            selectedHero.isFacingRight = false
                            selectedHero.timerChecker = true
                            animateMovementPrimary(location: CGPoint(x: activeEnemies[i].imageView.center.x + 3*(activeEnemies[i].imageView.frame.width / 4), y: verticalModifier), heroClass: selectedHero, target: activeEnemies[i], attackedListPosition: counter)
                            print("selected hero is melee and moves to attack from the right")
                            return
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
        if titleImage.isHidden == false {
            titleButton.isHidden = true
            titleLabelOne.isHidden = true
            titleLabelTwo.isHidden = true
            titleImage.isHidden = true
            saveStateStack.isHidden = false
            tapRecognizerView.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.15, alpha: 1.0)
        }
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
    
    func loadLevel(level: Level) {
        loadCombatScreen(level: level)
        loadActiveHeroes(level: level)      //loadActiveHeroes sets the currentLevel to the level set by map selection -- map selection has not been implimented since the images have not been made
    }
    
//    private func loadEnemies() {
//        for i in 0...3 {
//            activeEnemies[i] = currentLevel.enemyLoadTable[i]
//            if (activeEnemies[i].name != MissingEnemy.name && activeEnemies[i].isMelee == false) {
//                let xRange = Range(uncheckedBounds: (lower: tapRecognizerView.frame.minX, upper: tapRecognizerView.frame.maxX))
//                let yRange = Range(uncheckedBounds: (lower: tapRecognizerView.frame.minY + (activeEnemies[i].imageView.frame.height / 2), upper: tapRecognizerView.frame.maxY + (activeEnemies[i].imageView.frame.height / 2)))
//                let x = CGFloat.random(in: xRange)
//                let y = CGFloat.random(in: yRange)
//                activeEnemies[i].imageView.center = CGPoint(x: x, y: y)
//            }
//            else if (activeEnemies[i].name != MissingEnemy.name){
//                let randomY = CGFloat.random(in: Range(uncheckedBounds: (lower: tapRecognizerView.frame.minY + (activeEnemies[i].imageView.frame.height / 2), upper: tapRecognizerView.frame.maxY + (activeEnemies[i].imageView.frame.height / 2))))
//                let randomNumber = Int.random(in: Range(uncheckedBounds: (lower: 0, upper: 1)))
//                var randomX = CGFloat(0)
//                if (randomNumber == 0) {
//                    randomX = CGFloat.random(in: Range(uncheckedBounds: (lower: tapRecognizerView.frame.minX - 100, upper: tapRecognizerView.frame.minX)))
//                }
//                else {
//                    randomX = CGFloat.random(in: Range(uncheckedBounds: (lower: tapRecognizerView.frame.maxX, upper: tapRecognizerView.frame.maxX + 100)))
//                }
//                activeEnemies[i].imageView.center = CGPoint(x: randomX, y: randomY)
//            }
//        }
//    }
    
    private func loadEnemy(enemy: Character) {
        if (enemy.name != MissingEnemy.name && enemy.isMelee == false) {
            let xRange = Range(uncheckedBounds: (lower: tapRecognizerView.frame.minX, upper: tapRecognizerView.frame.maxX))
            let yRange = Range(uncheckedBounds: (lower: tapRecognizerView.frame.minY + (enemy.imageView.frame.height / 2), upper: tapRecognizerView.frame.maxY + (enemy.imageView.frame.height / 2)))
            let x = CGFloat.random(in: xRange)
            let y = CGFloat.random(in: yRange)
            enemy.imageView.center = CGPoint(x: x, y: y)
        }
        else if (enemy.name != MissingEnemy.name){
            let randomY = CGFloat.random(in: Range(uncheckedBounds: (lower: tapRecognizerView.frame.minY + (enemy.imageView.frame.height / 2), upper: tapRecognizerView.frame.maxY + (enemy.imageView.frame.height / 2))))
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
    
    //MARK: Load/Reset Combat
    
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
        if (level.complete == true) {
            gold += level.goldReward
            for i in 0...3{
                activeHeroes[i].xp += Int(activeHeroes[i].xpModifier * Double(level.xpReward / activeHeroCount))
            }
        }
        resetCombat()
    }
    
    private func displayRewards() {
        // this will display gold, xp, items won based upon the level's set values
        // not yet implimented since pictures of each reward are not yet made
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (_) in
            for i in 0...3 {
                activeHeroes[i].imageView.center = CGPoint(x: -200, y: -200)
            }
            print("Warrior XP after combat:  \(Warrior.xp)")
            self.returnToArmory()
        }
    }
    
    
    private func loadActiveHeroes(level: Level) {
//        let xCenter = (view.bounds.maxX - view.bounds.minX) / 2
//        let yCenter = (view.bounds.maxY - view.bounds.minY) / 2
        currentLevel = level
        var minMS = 0.0
        for i in 0...3 {
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
    
    private func loadCombatScreen(level: Level) {
        //level.combatBackground.isHidden = false         image not yet made
    }
    
    func resetCombat() {
        for i in 0...3{
            activeHeroes[i].reset()
            if (activeHeroes[i].exists) {
                animateMovementPrimary(location: CGPoint(x: (view.center.x - CGFloat(150 + (i * 100))), y: view.center.y), heroClass: activeHeroes[i], combatEnded: true)
            }
        }
        currentLevel.enemyLoadTable = currentLevel.baseLoadTable
        activeHeroCount = 0
    }
    
    
    //MARK: Armory
    //returns the view to Armory from selection screens
    
    private func returnToArmory() {
        returnButton.isHidden = true
        mapView1.isHidden = true
        mapView2.isHidden = true
        mapView3.isHidden = true
        activeHeroPortraits.isHidden = true
        selectedCharacterArmor.isHidden = true
        ownedArmorView.isHidden = true
        armorStatView.isHidden = true
        vendorView.isHidden = true
        armoryHeroTwo.isHidden = true
        switchMapRight.isHidden = true
        switchMapLeft.isHidden = true
        armoryStack.isHidden = false
        missingTextView.isHidden = true
        missingTextView.text = "No item images/character portraits have been made yet, thus this screen is uninstalled"
        selectedHero.talentTree.isHidden = true
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
    
 
    
    //MARK: Equipment Screen
    

    
    fileprivate func openArmorScreen() {
        armoryStack.isHidden = true
        activeHeroPortraits.isHidden = false
        ownedArmorView.isHidden = false
        selectedHero = activeHeroes[0]
        returnButton.isHidden = false
    }
    
    @IBAction func equipmentScreen(_ sender: UIButton) {
//        openArmorScreen()
//        selectedCharacterArmor.isHidden = false
//        armorStatView.isHidden = false
        armoryStack.isHidden = true
        missingTextView.isHidden = false
        returnButton.isHidden = false
    }
    //selecting individual characters in equipment screen
    @IBAction func selectSecondHero(_ sender: UIButton) {
        selectedHero = activeHeroes[0]
    }
    //Impliment 1-4 heroes later - once art is done
    
    //MARK: Vendor Screen
    @IBAction func vendorScreen(_ sender: UIButton) {
//        openArmorScreen()
//        vendorView.isHidden = false
        armoryStack.isHidden = true
        missingTextView.isHidden = false
        returnButton.isHidden = false
    }
    
    //MARK: Skill Screen
    @IBAction func skillsScreen(_ sender: UIButton) {
        
        //the full image container of all hero's hasn't been made yet - impliment selection screen once images are made
        
        armoryStack.isHidden = true
        returnButton.isHidden = false
//        screenCounter = 1
//        returnButton.isHidden = false
//        skillTreeImage.isHidden = false
        
        //set warrior talent view here
        selectedHero = Warrior
        selectedHero.talentTree.isHidden = false
        
        missingTextView.text = "Talents have not been implimented but this is a sample image of the talent selection screen for Warrior"
        missingTextView.isHidden = false
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
    }
    
    
    
}
