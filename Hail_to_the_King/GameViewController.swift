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
var Warrior = Character(characterName: heroList[1], isEnemy: false, characterBaseImage: UIImage(named: "Warrior-1")!, imageNumberAttack: 4, imageNumberMovement: 5, movementSpeed: 350.0, HP: 150, attackSpeed: 3.0, autoAttackDamage: 10, armorValue: 40, isMelee: true, isHealer: false, abilityNames: ["HeroicStrike", "ShieldWall"], equipmentType: 1)

var MissingEnemy = Character(characterName: enemyList[0], isEnemy: true, characterBaseImage: UIImage(named: "blackBackground")!, imageNumberAttack: 0, imageNumberMovement: 0, movementSpeed: 0.0, HP: 0, attackSpeed: 0.0, autoAttackDamage: 0, armorValue: 0, isMelee: false, isHealer: false, abilityNames: ["missingAbility"], equipmentType: 0)
var SkeletonArcher1 = Character(characterName: enemyList[1], isEnemy: true, characterBaseImage: UIImage(named: "SkeletonArcher-1")!, imageNumberAttack: 3, imageNumberMovement: 0, imageNumberProjectile: 0, imageNumberHeal: 0, movementSpeed: 0.0, HP: 75, attackSpeed: 1.5, autoAttackDamage: 12, armorValue: 15, isMelee: false, isHealer: false, secondaryBaseImage: nil, abilityNames: ["missingAbility"], equipmentType: 0)

var selectedHero: Character = MissingHero
var priorClass = MissingHero
var dragHero = MissingHero

var activeHeroes = [MissingHero, MissingHero, MissingHero, MissingHero]
var activeEnemies = [MissingEnemy, MissingEnemy, MissingEnemy, MissingEnemy]
var heroArray = [[Warrior, MissingHero, MissingHero], [MissingHero, MissingHero, MissingHero], [MissingHero, MissingHero, MissingHero], [MissingHero, MissingHero, MissingHero]]
var benchList = [[MissingHero, MissingHero, MissingHero], [MissingHero, MissingHero, MissingHero], [MissingHero, MissingHero, MissingHero], [MissingHero, MissingHero, MissingHero]]

let Tutorial = Level(levelNumber: 0, enemyLoadTable: [[SkeletonArcher1, MissingEnemy, MissingEnemy, MissingEnemy], [MissingEnemy, MissingEnemy]])
let LevelOne = Level(levelNumber: 1, enemyLoadTable: [[SkeletonArcher1, MissingEnemy], [MissingEnemy]])
let LevelTwo = Level(levelNumber: 2, enemyLoadTable: [[SkeletonArcher1, MissingEnemy], [MissingEnemy]])
let MissingLevel = Level(levelNumber: -1, enemyLoadTable: [])

var currentLevel = MissingLevel
var levelArray = [[LevelOne, LevelTwo, MissingLevel, MissingLevel, MissingLevel, MissingLevel, MissingLevel, MissingLevel, MissingLevel, MissingLevel, MissingLevel, MissingLevel, MissingLevel], [MissingLevel, MissingLevel, MissingLevel, MissingLevel, MissingLevel, MissingLevel, MissingLevel, MissingLevel, MissingLevel, MissingLevel, MissingLevel, MissingLevel, MissingLevel], [MissingLevel, MissingLevel, MissingLevel, MissingLevel, MissingLevel, MissingLevel, MissingLevel, MissingLevel, MissingLevel, MissingLevel, MissingLevel, MissingLevel, MissingLevel]]

var selectedItem = MissingItem
var itemReward = MissingItem
var itemArray = [[MissingItem, MissingItem, MissingItem, MissingItem], [MissingItem, MissingItem, MissingItem, MissingItem], [MissingItem, MissingItem, MissingItem, MissingItem], [MissingItem, MissingItem, MissingItem, MissingItem]]        //  4x4  (16 total item slots)
let itemIndex = [[BronzeSword, MissingItem], [MissingItem], [MissingItem], [MissingItem]]   // contains every item in the game and it organized by item level for random item drops

var abilityButtons: [UIButton] = {
    var buttons = [UIButton]()
    for i in 0...3 {
        buttons.insert(UIButton(frame: CGRect(x: 20 + (100 * i), y: 20, width: 75, height: 75)), at: i)
        buttons[i].isHidden = true
        buttons[i].setImage(UIImage(named: "Warrior-1"), for: .normal)
        buttons[i].backgroundColor = .orange
    }
   return buttons
}()

var pauseButton: UIButton = {
    let button = UIButton(frame: CGRect(x: 500, y: 20, width: 75, height: 75))
    button.isHidden = true
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

var talentButtons: [[UIButton]] = {
    var button = [[UIButton]]()
    for i in 0...5 {
        button.insert([UIButton](), at: i)
        for j in 0...2 {
            button[i].insert(UIButton(frame: CGRect(x: 70 + (130 * i), y: 200 + (130 * j), width: 115, height: 115)), at: j)
            button[i][j].isHidden = true
            button[i][j].backgroundColor = .systemTeal
//            button[i][j].setImage(UIImage(named: "\(heroArray[i][j].name)-1"), for: .normal)      //Re-enable when all images exist
        }
    }
   return button
}()

var equipmentButtons: [UIButton] = {
    var buttons = [UIButton]()
    for i in 0...3 {
        buttons.insert(UIButton(frame: CGRect(x: 40 + (165 * i), y: 40, width: 125, height: 125)), at: i)
        buttons[i].backgroundColor = .green
        buttons[i].isHidden = true
    }
    return buttons
}()

let itemImageArray: [[UIImageView]] = {
    var view = [[UIImageView]]()
    for i in 0...3 {
        view.insert([UIImageView](), at: i)
        for j in 0...3 {
            view[i].insert(UIImageView(frame: CGRect(x: 780 + 100*j, y: 314 + 100*i, width: 95, height: 95)), at: j)
            view[i][j].backgroundColor = .red
            view[i][j].isHidden = true
        }
    }
    return view
}()


var descriptorLabel: UILabel = {
    var descriptorLabel = UILabel(frame: CGRect(x: 40, y: 610, width: 1134, height: 200))
    descriptorLabel.isHidden = true
    descriptorLabel.isUserInteractionEnabled = true
    descriptorLabel.font = UIFont(name: "Helvetica", size: 40)
    descriptorLabel.textColor = .red
    return descriptorLabel
}()
var talentLabel: UILabel = {
    var label = UILabel(frame: CGRect(x: 75, y: 75, width: 500, height: 75))
    label.isHidden = true
    label.font = UIFont(name: "Helvetica", size: 30)
    label.textColor = .magenta
    return label
}()

var dragImage: UIImageView = {
   var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
    imageView.backgroundColor = .blue
    imageView.isHidden = true
    return imageView
}()

class GameViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var enterNameField: UITextField!
    
    fileprivate func configureTextFields() {
         enterNameField.delegate = self
         enterNameField.placeholder = "Enter Name"
     }
    
    fileprivate func addButtons() {
        self.view.addSubview(pauseButton)
        pauseButton.addTarget(self, action: #selector(pauseGame), for: .touchUpInside)
        self.view.addSubview(confirmButton)
        self.view.addSubview(resetTalentsButton)
        for i in 0...3 {
            self.view.addSubview(abilityButtons[i])
            self.view.addSubview(equipmentButtons[i])
        }
        for i in 0...5 {
            for j in 0...2 {
                self.view.addSubview(talentButtons[i][j])
            }
        }
        for i in 0...14 {
            self.view.addSubview(mapButtons[i])
            if (i == 0 || i == 14) {
                mapButtons[i].addTarget(self, action: #selector(switchMap), for: .touchUpInside)
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
        self.view.addSubview(talentLabel)
        self.view.addSubview(descriptorLabel)
        self.view.addSubview(dragImage)
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
    
    fileprivate func fixHeroClassThings() {
        Warrior.imageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(moveHero(sender:))))
        
    }
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabelOne.textColor = UIColor(displayP3Red: 1.0, green: 0, blue: 0, alpha: 1)
        configureTextFields()
        loadSavedValues()
        loadImageViews()
        addButtons()
        setTargets()
        fixHeroClassThings()
        makeItemsInteractive()
        
        saveThreeName = "Jimbo"
    }
    
    
    //MARK: Drag Time
    @objc func standardDrag (_ gesture: UIPanGestureRecognizer) {
        let distance = gesture.translation(in: self.view)
        let label = gesture.view!
        
        label.center = CGPoint(x: label.center.x + distance.x, y: label.center.y + distance.y)
        gesture.setTranslation(CGPoint.zero, in: self.view)
    }
    
    var tempHelper = [-1, -1]
    var tempPoint = CGPoint(x: 0, y: 0)
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
                        print("Item replaced at \(i)")          //  Need to figure out what rings/trinkets will influence to be added here (or elsewhere depending on which stats they are)
                                                                //  Could use selectors to have custom effects/methods for each item based on itemName
                        
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
    
    //MARK: Move Hero
    
    var priorLine = CAShapeLayer()
    func addLine(fromPoint start: CGPoint, toPoint end:CGPoint) {
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.strokeColor = UIColor.blue.cgColor
        line.lineWidth = 2
        line.lineJoin = CAShapeLayerLineJoin.round
        self.view.layer.addSublayer(line)
        priorLine = line
    }
    
    @objc func moveHero(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            for i in 0...3 {
                if (sender.view!.center == activeHeroes[i].imageView.center) {dragHero = activeHeroes[i]}
            }
            dragImage.center = dragHero.imageView.center
            dragImage.isHidden = false
            print("Begun drag")
        case .changed:
            let distance = sender.translation(in: self.view)
            let view = sender.view!
            
            if (dragImage.frame.minY + distance.y > 100 && dragImage.frame.maxY + distance.y < 800) { // Map limits for movement
                dragImage.center = CGPoint(x: dragImage.center.x + distance.x, y: dragImage.center.y + distance.y)
            }
            sender.setTranslation(CGPoint.zero, in: self.view)
            
            for i in 0..<activeEnemies.count {
                if (activeEnemies[i].imageView.frame.contains(dragImage.center) && selectedHero.isHealer == false) {
                    dragImage.center = activeEnemies[i].imageView.center
                }
            }
            for i in 0...3 {
                if (activeHeroes[i].imageView.frame.contains(dragImage.center) && selectedHero.isHealer == true) {
                    dragImage.center = activeHeroes[i].imageView.center
                }
            }
            priorLine.removeFromSuperlayer()
            addLine(fromPoint: view.center, toPoint: dragImage.center)
        case .ended:
            print("Drag end registered")
            priorLine.removeFromSuperlayer()
            dragImage.isHidden = true
            if (selectedHero.isHealer == true) {
                for i in 0...3 {
                    if (activeHeroes[i].imageView.frame.contains(dragImage.frame)) {animateHealing(heroClass: dragHero, target: activeHeroes[i])
                        print("did a heal")
                    }
                }
                return
            }
            else {
                for i in 0..<activeEnemies.count {
                    if (activeEnemies[i].imageView.frame.contains(dragImage.frame)) {
                        if (dragHero.isMelee == false) {animateRangedAttack(heroClass: dragHero, target: activeEnemies[i])
                            print("did a shoot")
                        }
                        else {
                            print("did a slap")
                            var xPlacement: CGFloat = 0
                            if (activeEnemies[i].imageView.center.x - dragHero.imageView.center.x < 0) {
                                xPlacement = activeEnemies[i].imageView.center.x + 3*(activeEnemies[i].imageView.frame.width / 4)
                            }
                            else {xPlacement = activeEnemies[i].imageView.center.x - 3*(activeEnemies[i].imageView.frame.width / 4)}
                            let yPlacement = activeEnemies[i].imageView.center.y
                            animateMovementPrimary(location: CGPoint(x: xPlacement, y: yPlacement), heroClass: dragHero, target: activeEnemies[i], attackedListPosition: i, combatEnded: false)
                        }
                        return
                    }
                }
            }
            print("Performing normal movement")
            animateMovementPrimary(location: dragImage.center, heroClass: dragHero)
        default:
            return
        }
    }
    
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
    var mapCoordinate = 0
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
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var saveFileOne: UIButton!
    @IBOutlet weak var saveFileTwo: UIButton!
    @IBOutlet weak var saveFileThree: UIButton!
    @IBOutlet weak var deSelectButton: UIButton!
    
    
let mapButtonPositions: [[CGPoint]] = {
    let topPos: CGPoint = CGPoint(x: 57, y: 400)
    let midPos: CGPoint = CGPoint(x: 57, y: 500)
    let botPos: CGPoint = CGPoint(x: 57, y: 600)
//        CGRect(x: 0, y: 0, width: (view.size.width * view.size.height) * 0.002, height: (view.size.width * view.size.height) * 0.002)
    var points = [[midPos, midPos, botPos, botPos, botPos, midPos, topPos, topPos, botPos, topPos, midPos, midPos, botPos], [topPos, topPos, midPos, botPos, botPos, topPos, botPos, midPos, midPos, topPos, topPos, topPos, midPos], [midPos, midPos, topPos, topPos, topPos, midPos, midPos, botPos, botPos, topPos, botPos, midPos, midPos]]
    var counter = 0
    var checker = false
    var tempBlocker = false
    var tempPoint = CGPoint(x: 57, y: 500)
    for i in 0...2 {
        for j in 0...12 {
            if (tempPoint.y == points[i][j].y || checker == true) {
                if (checker == true) {
                    tempBlocker = true
                }
                checker = false
                counter += 1
            }
            if (abs(tempPoint.y - points[i][j].y) == 200 && tempBlocker == false) {
                checker = true
            }
            tempBlocker = false
            points[i][j].x += CGFloat(counter * 57)
            tempPoint = points[i][j]
        }
        counter = 0
    }
    return points
}()

var mapButtons: [UIButton] = {
    var buttons = [UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton()]
    for i in 0...14 {
        if (i != 0 && i != 14) {
            buttons[i].addTarget(self, action: #selector(selectLevel(_:)), for: .touchUpInside)
        }
        buttons[i].frame = CGRect(x: 0, y: 0, width: 52, height: 52)
        buttons[i].isHidden = true
        buttons[i].backgroundColor = .magenta
        buttons[i].setTitle("\(i)", for: .normal)
    }
    return buttons
}()
    
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
        character.imageView.isHidden = true
        character.imageView.center = CGPoint(x: -500, y: -500)
        character.imageView.removeFromSuperview()        //Remove once death animations are implimented
        if (character.isEnemy == true){
            currentLevel.enemyLoadTable[currentLoadTable][characterListPosition] = MissingEnemy
            for i in 0..<currentLevel.enemyLoadTable[currentLoadTable].count {
                if (currentLevel.enemyLoadTable[currentLoadTable][i].name != MissingEnemy.name) {return}
            }
            currentLoadTable += 1
            activeEnemies = currentLevel.enemyLoadTable[currentLoadTable]
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
                print("Called the perform ability thing")
                selector.perform(Selector("Actuate\(heroClass.abilityNames[i])"))
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
            let dist = abs(heroClass.imageView.center.x - target.imageView.center.x)+abs(heroClass.imageView.center.y + heroClass.imageView.center.y)
            target.HP -= (heroClass.autoAttackDamage * ((1/target.armorValue) * 10))
            print("Target HP  \(target.HP)")
            if (heroClass.armorValue > target.target!.armorValue && heroClass.isEnemy == true) {
                target.secondaryThreat = target.target
                target.target = heroClass
            }
            if (xDist < 0) {
                target.imageView.center.x += 10
                if (target.imageView.center.x > 1194) {
                    self.animateMovementPrimary(location: CGPoint(x: 1194 - target.imageView.frame.width / 2, y: target.imageView.frame.origin.y - 180 + target.imageView.frame.height), heroClass: target)
                }
            }
            else {
                target.imageView.center.x -= 10
                if (target.imageView.center.x < 0) {
                    self.animateMovementPrimary(location: CGPoint(x: 0 + target.imageView.frame.width / 2, y: target.imageView.frame.origin.y - 180 + target.imageView.frame.height), heroClass: target)
                }
            }
            
            if (target.HP <= 0) {
                heroClass.imageView.stopAnimating()
                heroClass.attackTimer.invalidate()
                print("Target Killed - Attack Timer invalidated")
                self.characterKilled(character: target, characterListPosition: attackedListPosition!, attacker: heroClass)
                return
            }
            
            if (dist >= 260 && heroClass.isMelee && currentLevel.enemyLoadTable[self.currentLoadTable][attackedListPosition!].name != MissingEnemy.name) {
                heroClass.imageView.stopAnimating()
                heroClass.attackTimer.invalidate()
                if (xDist > 0) {
                    self.animateMovementPrimary(location: CGPoint(x: target.imageView.center.x + 3*(target.imageView.frame.width / 4), y: target.imageView.center.y), heroClass: heroClass, target: target, attackedListPosition: attackedListPosition)
                }
                else {
                    self.animateMovementPrimary(location: CGPoint(x: target.imageView.center.x - 3*(target.imageView.frame.width / 4), y: target.imageView.center.y), heroClass: heroClass, target: target, attackedListPosition: attackedListPosition)
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
    
    //MARK: Animate Movement
    
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
        heroClass.attackTimer.invalidate()
        
        let xDist = Double(abs(location.x - heroClass.imageView.center.x))
        let yDist = Double(abs(location.y - heroClass.imageView.center.y))
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
        print("Position: \(heroClass.imageView.center)")
        heroClass.animation = UIViewPropertyAnimator(duration: timeUntilCompletion, curve: .linear, animations: {
//            heroClass.imageView.center.y = location.y
//            heroClass.imageView.center.x = location.x
            heroClass.imageView.frame = heroClass.imageView.frame.offsetBy(dx: (location.x - heroClass.imageView.center.x), dy: (location.y - heroClass.imageView.center.y))
        })
        heroClass.animation.startAnimation()
        
        print("Post-position: \(heroClass.imageView.center)")
        
        if (heroClass.timerCheck == true) {heroClass.movementTimer.invalidate()}
        
        heroClass.movementTimer = Timer.scheduledTimer(withTimeInterval: timeUntilCompletion, repeats: false) { (_) in
            heroClass.timerCheck = true
            heroClass.imageView.stopAnimating()
            if (combatEnded == true || attackedListPosition != -1) {
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
    let openingPlacements: [[CGPoint]] = {
        let point1 = CGPoint(x: 597, y: -100)
        let point2 = CGPoint(x: -100, y: 417)
        let point3 = CGPoint(x: 597, y: 934)
        let point4 = CGPoint(x: 1294, y: 417)
        let point5 = CGPoint(x: 597, y: 317)
        let point6 = CGPoint(x: 497, y: 417)
        let point7 = CGPoint(x: 597, y: 517)
        let point8 = CGPoint(x: 697, y: 417)
        let points = [[point1, point2, point3, point4], [point5, point6, point7, point8]]
       return points
    }()
    
    private func loadActiveHeroes(level: Level) {
    //        let xCenter = (view.bounds.maxX - view.bounds.minX) / 2
    //        let yCenter = (view.bounds.maxY - view.bounds.minY) / 2
        currentLevel = level
        var minMS = 0.0
        for i in 0...3 {
            if (activeHeroes[i].name != MissingHero.name) {
                self.view.addSubview(activeHeroes[i].imageView)
                if (activeHeroes[i].secondaryImageView != nil) {self.view.addSubview(activeHeroes[i].secondaryImageView!)}
                if (activeHeroes[i].movementSpeed >= minMS) {minMS = activeHeroes[i].movementSpeed}
            }
        }
        for i in 0...3 {
            if (activeHeroes[i].name != MissingHero.name) {
                activeHeroCount += 1
                activeHeroes[i].imageView.center = openingPlacements[0][i]
                animateMovementPrimary(location: openingPlacements[1][i], heroClass: activeHeroes[i])
            }
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
            let yRange = Range(uncheckedBounds: (lower: 300 + (enemy.imageView.frame.height), upper: 1194 - (enemy.imageView.frame.height * 2)))
            let x = Int.random(in: 50...850)
            let y = CGFloat.random(in: yRange)
            enemy.imageView.center = CGPoint(x: CGFloat(x), y: y)
        }
        else if (enemy.name != MissingEnemy.name){
            self.view.addSubview(enemy.imageView)
            let randomY = CGFloat.random(in: Range(uncheckedBounds: (lower: 400 + enemy.imageView.frame.height, upper: 1194 - enemy.imageView.frame.height)))
            let randomNumber = Int.random(in: Range(uncheckedBounds: (lower: 0, upper: 1)))
            var randomX = CGFloat(0)
            if (randomNumber == 0) {
                randomX = CGFloat.random(in: Range(uncheckedBounds: (lower: 0, upper: 300)))
            }
            else {
                randomX = CGFloat.random(in: Range(uncheckedBounds: (lower: 834, upper: 1294)))
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
        for i in 0..<currentLevel.enemyLoadTable[currentLoadTable].count {
            loadEnemy(enemy: currentLevel.enemyLoadTable[currentLoadTable][i])
            activeEnemies[i] = currentLevel.enemyLoadTable[currentLoadTable][i]
        }
        // implimentation for map level selection will determine which level object is called here - map has not yet been made so it is not implimented
    }
    
    private func combatEnded(level: Level) {
        deSelectButton.isHidden = true
        var checker = false
        for i in 0...3 {
            abilityButtons[i].isHidden = true
            for j in 0..<activeHeroes[i].abilityTimers.count {
                activeHeroes[i].abilityTimers[j].invalidate()
            }
        }
        if (level.complete == true) {
            let index = Int.random(in: ClosedRange(uncheckedBounds: (lower: 0, upper: itemIndex[level.itemLevel].count - 1)))
            itemReward = itemIndex[level.itemLevel - 1][index]
            gold += level.goldReward
            for i in 0...3 {
                activeHeroes[i].xp += Int(activeHeroes[i].xpModifier * Double(level.xpReward / activeHeroCount))
                for j in 0...3 {
                    if (itemArray[i][j].name == MissingItem.name && checker == false) {itemArray[i][j] = itemReward
                        checker = true
                        selectedItem = itemArray[i][j]
                        itemArray[i][j].itemButton.frame = itemImageArray[i][j].frame
                        print("Item Obtained  \(selectedItem.name)")
                        print("Added at:  \(itemImageArray[i][j].frame)")
                    }
                }
            }
        }
        else {
            print("Level Failed")
            for i in 0..<currentLevel.enemyLoadTable[currentLoadTable].count {
                if (currentLevel.enemyLoadTable[currentLoadTable][i].name != MissingEnemy.name) {
                    currentLevel.enemyLoadTable[currentLoadTable][i].imageView.removeFromSuperview()
                }
            }
            //          Add combat defeat screen
        }
        resetCombat()
    }
    
    func resetCombat() {
        pauseButton.isHidden = true
        for i in 0...3{
            activeHeroes[i].reset()
            if (activeHeroes[i].name != MissingHero.name) {
                animateMovementPrimary(location: CGPoint(x: (view.center.x - CGFloat(150 - (i * 100))), y: view.center.y), heroClass: activeHeroes[i], combatEnded: true)
            }
        }
        currentLevel.enemyLoadTable = currentLevel.baseLoadTable
        activeHeroCount = 0
    }
    
    private func displayRewards() {
        // this will display gold, xp, items won based upon the level's set values
        // not yet implimented since pictures of each reward are not yet made
        for i in 0...3 {
            UIView.animate(withDuration: 2.0) {
                activeHeroes[i].imageView.alpha = 0.0
            }
        }
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (_) in
            for i in 0...3 {
                activeHeroes[i].imageView.removeFromSuperview()
                activeHeroes[i].imageView.alpha = 1.0
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
    var selectScreen = 0
    
    private func returnToArmory() {
        returnButton.isHidden = true        // default two screens which must be set
        armoryStack.isHidden = false
        descriptorLabel.isHidden = true     // used in multiple screens so hidden globally
        descriptorLabel.text = ""
        switch selectScreen {
        case 1:
            for i in 0...14 {
                mapButtons[i].isHidden = true
            }
            confirmButton.removeTarget(self, action: #selector(startLevel), for: .touchUpInside)
            confirmButton.isHidden = true
        case 2:
            for i in 0...3 {
                equipmentButtons[i].isHidden = true
                equipmentButtons[i].removeTarget(self, action: #selector(showHeroItems(_:)), for: .touchUpInside)
                selectedHero.itemImageViews[i].isHidden = true
                selectedHero.items[i].itemButton.isHidden = true
                for j in 0...3 {
                    itemImageArray[i][j].isHidden = true
                    itemArray[i][j].itemButton.isHidden = true
                }
            }
        case 3:
            for i in 0...5 {
                for j in 0...2 {
                    talentButtons[i][j].removeTarget(selector, action: Selector("\(selectedHero.name)Talent\((i * 4) + j)"), for: .touchUpInside)
                    talentButtons[i][j].backgroundColor = .systemTeal
                    talentButtons[i][j].isHidden = true
                    talentButtons[i][j].setTitle("", for: .normal)
                }
            }
            resetTalentsButton.isHidden = true
            talentLabel.isHidden = true
            talentLabel.text = ""
            selectedHero.talentTree.isHidden = true
            confirmButton.removeTarget(SelectorClass.self, action: Selector(("confirmAction")), for: .touchUpInside)
            confirmButton.isHidden = true
        case 4:
            missingTextView.isHidden = true
            missingTextView.text = "No item images/character portraits have been made yet, thus this screen is uninstalled"
        case 5:
            for i in 0...3 {
                equipmentButtons[i].isHidden = true
                equipmentButtons[i].removeTarget(self, action: #selector(swapActiveHeroes(_:)), for: .touchUpInside)
                for j in 0...2 {
                    talentButtons[i][j].isHidden = true
                    talentButtons[i][j].setTitle("", for: .normal)
                    talentButtons[i][j].removeTarget(self, action: #selector(swapActiveHeroes(_:)), for: .touchUpInside)
                    talentButtons[i][j].backgroundColor = .systemTeal
                }
            }
        default:
            return
        }
    }
    
     @IBAction func returnToArmory(_ sender: Any) {
         returnToArmory()
     }
    
    //MARK: Map
    fileprivate func setMapButtons() {
        print("Map page \(mapPage)")
        for i in 0...14 {
            if (i != 0 && i != 14) {mapButtons[i].center = mapButtonPositions[mapPage][i - 1]}
            else if (i == 0) {mapButtons[i].center = CGPoint(x: 57, y: 500)}
            else {mapButtons[i].center = CGPoint(x: mapButtonPositions[mapPage][12].x + 57, y: mapButtonPositions[mapPage][12].y)}
            mapButtons[i].setTitle("\(i + (mapPage * 13))", for: .normal)
            mapButtons[i].isHidden = false
        }
    }
    
    @objc func switchMap(_ sender: UIButton) {
        if (sender.frame == mapButtons[0].frame) {
            if (mapPage > 0) {
                mapPage -= 1
            }
            else {return}
        }
        else if (mapPage < 2) {
            mapPage += 1
        }
        else {return}
        
        setMapButtons()
    }
    
    @objc func selectLevel(_ sender: UIButton) {
        for i in 1...13 {
            if (sender.frame == mapButtons[i].frame) {
                currentLevel = levelArray[mapPage][i-1]
            }
        }
        print("Selected level: \(currentLevel.levelNumber)")
        confirmButton.addTarget(self, action: #selector(startLevel), for: .touchUpInside)
    }
    
    @objc func startLevel() {
        for i in 0...14 {
            mapButtons[i].isHidden = true
        }
        returnButton.isHidden = true
        loadLevel(level: currentLevel)
    }
    
    @IBAction func mapButton(_ sender: UIButton) {
        armoryStack.isHidden = true
        returnButton.isHidden = false
        confirmButton.isHidden = false
        selectScreen = 1
        setMapButtons()
    }
    
    //MARK: Equipment Screen
    
    @IBAction func equipmentScreen(_ sender: UIButton) {
        selectScreen = 2
        armoryStack.isHidden = true
        returnButton.isHidden = false
        for i in 0...3 {
            equipmentButtons[i].addTarget(self, action: #selector(showHeroItems(_:)), for: .touchUpInside)
            equipmentButtons[i].isHidden = false
            if (activeHeroes[i].name != MissingHero.name) {equipmentButtons[i].setImage(activeHeroes[i].imageView.image, for: .normal)}
            for j in 0...3 {
                itemImageArray[i][j].isHidden = false
                if (itemArray[i][j].name != MissingItem.name) {itemArray[i][j].itemButton.isHidden = false}
            }
        }
        descriptorLabel.isHidden = false
    }
    
    @objc func showHeroItems(_ sender: UIButton) {
        for i in 0...3 {
            if (equipmentButtons[i].frame == sender.frame) {
                selectedHero = activeHeroes[i]
                for j in 0...3 {
                    selectedHero.itemImageViews[j].isHidden = false
                    selectedHero.items[j].itemButton.isHidden = false
                }
            }
        }
        
    }
    
    //MARK: Skill Screen
    @IBAction func skillsScreen(_ sender: UIButton) {
        selectScreen = 3
        armoryStack.isHidden = true
        returnButton.isHidden = false
        for i in 0...3 {
            for j in 0...2 {
                talentButtons[i][j].setTitle(heroArray[i][j].name, for: .normal)
                talentButtons[i][j].addTarget(self, action: #selector(selectHero(_:)), for: .touchUpInside)
                talentButtons[i][j].isHidden = false
            }
        }
    }
    
    
    @objc func selectHero(_ sender: UIButton) {
        for i in 0...3 {
            for j in 0...2 {
                talentButtons[i][j].removeTarget(self, action: #selector(selectHero(_:)), for: .touchUpInside)
                if (talentButtons[i][j].frame == sender.frame) {
                    selectedHero = heroArray[i][j]
                    print("Selected Hero:  \(selectedHero.name)")
                }
            }
        }
        selector.perform(Selector(("showTalentButtons")))
    }
    
    @objc func resetTalents() {
        selectedHero.currentTalentPoints = selectedHero.baseTalentPoints
        selectedHero.maxTalentPoints = selectedHero.baseMaxTalentPoints
        for i in 0...5 {
            for j in 0...2 {
                talentButtons[i][j].setTitle("0/3", for: .normal)
            }
        }
        talentLabel.text = "Remaining Talent Points:  \(selectedHero.currentTalentPoints)"
        print("Talent points reset!")
        //          Undo the augments to ability/physical damage/healing and armor and MS -- undo all talents on selected hero
        //          Impliment once all talents are made
        
    }
    
    
    //MARK: Rectuit Screen
    @IBAction func recruitScreen(_ sender: UIButton) {
        selectScreen = 4
        //None of this has been implimented - thus it is currently uninstalled
        
        armoryStack.isHidden = true
        returnButton.isHidden = false
//        fullBodyCharacterView.isHidden = false
        missingTextView.isHidden = false
        
    }
    
    var heroCount = 0
    //MARK: Heroes Screen
    @IBAction func heroesScreen(_ sender: UIButton) {
        selectScreen = 5
        for i in 0...3 {
            if (activeHeroes[i].name != MissingHero.name) {heroCount += 1; print(heroCount)}
        }
        armoryStack.isHidden = true
        returnButton.isHidden = false
        for i in 0...3 {
            equipmentButtons[i].addTarget(self, action: #selector(swapActiveHeroes(_:)), for: .touchUpInside)
            equipmentButtons[i].isHidden = false
            if (activeHeroes[i].name != MissingHero.name) {equipmentButtons[i].setImage(activeHeroes[i].imageView.image, for: .normal); print("EYYYYY")}
            for j in 0...2 {
                talentButtons[i][j].addTarget(self, action: #selector(swapActiveHeroes(_:)), for: .touchUpInside)
                talentButtons[i][j].isHidden = false
                if (benchList[i][j].name != MissingHero.name) {talentButtons[i][j].setImage(benchList[i][j].imageView.image, for: .normal); print("AYYYYY")}
            }
        }
    }
    
    @objc func swapActiveHeroes(_ sender: UIButton) {
        for i in 0...3 {
            if (equipmentButtons[i].frame == sender.frame) {
                selectedHero = activeHeroes[i]
                if (heroCount == 1 || selectedHero.name == MissingHero.name) {print("HA Got'em"); return}
                equipmentButtons[i].removeTarget(self, action: #selector(swapActiveHeroes(_:)), for: .touchUpInside)
                equipmentButtons[i].setImage(UIImage(named: "blackBackground"), for: .normal)
                activeHeroes[i] = MissingHero
                heroCount -= 1
                for o in 0...3 {
                    for l in 0...2 {
                        if (benchList[o][l].name == MissingHero.name) {
                            benchList[o][l] = selectedHero
                            talentButtons[o][l].addTarget(self, action: #selector(swapActiveHeroes(_:)), for: .touchUpInside)
                            talentButtons[o][l].setImage(selectedHero.imageView.image, for: .normal)
                            return
                        }
                    }
                }
                print("This is not correct")
                return
            }
            for j in 0...2 {
                if (talentButtons[i][j].frame == sender.frame) {
                    selectedHero = benchList[i][j]
                    if (heroCount == 4 || selectedHero.name == MissingHero.name) {print("NOPE"); return}
                    talentButtons[i][j].removeTarget(self, action: #selector(swapActiveHeroes(_:)), for: .touchUpInside)
                    talentButtons[i][j].setImage(UIImage(named: "blackBackground"), for: .normal)
                    benchList[i][j] = MissingHero
                    heroCount += 1
                    for o in 0...3 {
                        if (activeHeroes[o].name == MissingHero.name) {
                            activeHeroes[o] = selectedHero
                            equipmentButtons[o].addTarget(self, action: #selector(swapActiveHeroes(_:)), for: .touchUpInside)
                            equipmentButtons[o].setImage(selectedHero.imageView.image, for: .normal)
                            return
                        }
                    }
                    print("Buddy... Waaalk")
                    return
                }
            }
        }
    }
    
    
    //      The following functions need to be moved for readability
    
    @IBAction func deSelectActiveHero(_ sender: Any) {
        selectedHero = MissingHero
        deSelectButton.isHidden = true
        for i in 0...3 {
            abilityButtons[i].isHidden = true
        }
    }
    
    @objc func pauseGame() {            //needs work for stopping all timers -- code needed to grey out screen showing that game is paused -- this would also be called when game is temp closed
//        if (pauseChecker == false) {
//            for i in 0...3 {
//                if (activeHeroes[i].name != MissingHero.name) {
//                    activeHeroes[i].animation.pauseAnimation()
//                    for j in 0..<activeHeroes[i].abilityTimers.count {
//                        activeHeroes[i].abilityTimerTrackers[j] = activeHeroes[i].abilityTimers[j].fireDate.timeIntervalSinceNow
//                        activeHeroes[i].abilityTimers[j].invalidate()
//                    }
//                }
//            }
//            for i in 0..<currentLevel.enemyLoadTable[currentLoadTable].count {                  //no enemies have abilities yet so there is nothing for stopping enemy abilities
//                if (activeEnemies[i].name != MissingEnemy.name) {
//                    activeEnemies[i].animation.pauseAnimation()
//                }
//            }
//            pauseChecker = true
//            return
//        }
//        if (pauseChecker == true) {
//            for i in 0...3 {
//                if (activeHeroes[i].name != MissingHero.name) {
//                    activeHeroes[i].animation.startAnimation()
//                    for j in 0..<activeHeroes[i].abilityTimers.count {
//                        activeHeroes[i].abilityTimers[j] = Timer.scheduledTimer(withTimeInterval: activeHeroes[i].abilityTimerTrackers[j], repeats: false, block: { (_) in       //what do MH?
//                            activeHeroes[i].abilityCooldowns[j] = false
//                        })
//                    }
//                }
//            }
//            for i in 0..<currentLevel.enemyLoadTable[currentLoadTable].count {
//                if (activeEnemies[i].name != MissingEnemy.name) {
//                    activeEnemies[i].animation.startAnimation()
//                }
//            }
//        }
    }
    
    
    
}
