//
//  ViewController.swift
//  1A2B
//
//  Created by 江啟綸 on 2021/12/24.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var AText: UILabel!
    
    
    @IBOutlet weak var guessText: UITextField!
    @IBOutlet weak var chanceLal: UILabel!
    @IBOutlet weak var GuessBtn: UIButton!
    @IBOutlet weak var ResultTextview: UITextView!
    @IBOutlet weak var reStartBtn: UIButton!
    
    var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    var answer:Array<Int> = [0,0,0,0]
    var guess:Array<Int> = [0,0,0,0]
    var chance = 5
    var round = 0
    var a = 0
    var b = 0
    var gameOver = false
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
     guard let text = guessText.text else { return true }
     let count = text.count + string.count - range.length
     return count <= 4
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        numbers.shuffle()
        
        ResultTextview.layer.borderWidth = 3.0
        ResultTextview.layer.borderColor = UIColor.init(named: "Apink")?.cgColor
 
        chanceLal.layer.borderWidth = 3.0
        chanceLal.layer.borderColor = UIColor.init(named: "Apink")?.cgColor
        
        reStartBtn.layer.borderWidth = 3.0
        reStartBtn.layer.borderColor = UIColor.init(named: "Apink")?.cgColor
        
        GuessBtn.layer.borderWidth = 3.0
        GuessBtn.layer.borderColor = UIColor.init(named: "Apink")?.cgColor
        // GuessBtn 外框
        
        guessText.endEditing(true)
        
        self.guessText.delegate = self
        
        
    }
    
    @IBAction func guessBtn(_ sender: UIButton) {
        
        if guessText.text!.count == 4 && gameOver == false{
                    
            round += 1
            chance -= 1
            chanceLal.text = "\(chance)"
            
//            let guessnn = intToArrayInt(guessText.text!).removingDuplicates()
            
            let guessNumbers = Int(guessText.text!)!

            guess[0] = guessNumbers / 1000
            guess[1] = guessNumbers / 100 % 10
            guess[2] = guessNumbers / 10 % 10
            guess[3] = guessNumbers % 10
            
            for i in 0...3{
                answer[i] = numbers[i]
                if guess[i] == answer[i]{
                    a += 1
                }
                else if guess.contains(answer[i]) == true{
                    b += 1
                }
                
            }

            print(numbers)
            print(guess)
            
            gameplay()
            showResult()
            a = 0
            b = 0
            guessText.text = ""
            
        }
        

    }
    
    func intToArrayInt(_ guessText: String) -> Array<Int>{
        numbers.removeAll()
        for i in guessText{
            let num = Int(String(i))!
            numbers.append(num)
            }
        return numbers
    }
    
    func intToArrayI(_ guessText: String) -> Array<Int>{
        numbers.removeAll()
        for i in guessText{
            let num = Int(String(i))!
            numbers.append(num)
            }
        return numbers
    }



    func run(){
        let numberss = intToArrayInt(guessText.text!).removingDuplicates()
        if numberss.count != 4{
           repeatAlert()
        }
    }
    
    func showResult(){
        let guessNumbers = String(guessText.text!)
        if round <= 5{
            ResultTextview.text = ResultTextview.text + guessNumbers + "　　\(a)A\(b)B\n"
        }
    
        
    }
    
    
    func gameplay(){

        if a == 4{
            firstPrizeHint()
            gameOver = true
        }else if chance == 0{
            if a == 3 && guess[0] != answer[0]{
                sixthPrizeHint()
                gameOver = true
            }
            else{
                gameOverHint()
                gameOver = true
            }
           
        }

    }
    
    func gameoverHint(){
        let alertController = UIAlertController(title: "GAME OVER", message: "QQ", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "ONE MORE", style: .default)
        alertController.addAction(okAction)
        
    }
    
    func repeatAlert(){
        let alerController = UIAlertController(
            title: "repeat",
            message: "QQ",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(
            title: "one",
            style: .default,
            handler: (restartBtn(_:)))
        
        
        alerController.addAction(okAction)
        
        
        self.present(
            alerController,
            animated: true,
            completion: nil)

    }
    
    func gameOverHint(){
        let alerController = UIAlertController(
            title: "GAME OVER",
            message: "QQ",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(
            title: "One More",
            style: .default,
            handler: (restartBtn(_:)))
        
        alerController.addAction(okAction)
        
        self.present(
            alerController,
            animated: true,
            completion: nil)

    }
    @IBAction func restartBtn(_ sender: Any) {
        numbers.shuffle()
        guessText.text = ""
        gameOver = false
        round = 0
        chance = 5
        chanceLal.text = "\(chance)"
        ResultTextview.text = ""
        
    }
    
    func firstPrizeHint(){
        let alerController = UIAlertController(
            title: "WTF Bang",
            message: "Fucking Lucky Boy",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(
            title: "One More",
            style: .default,
            handler: (restartBtn(_:)))
        
        alerController.addAction(okAction)
        
        self.present(
            alerController,
            animated: true,
            completion: nil)

    }
    
    func sixthPrizeHint(){
        let alerController = UIAlertController(
            title: "3A",
            message: "A little Bit",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(
            title: "One More",
            style: .default,
            handler: (restartBtn(_:)))
        
        alerController.addAction(okAction)
        
        self.present(
            alerController,
            animated: true,
            completion: nil)

    }
    
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension Array where Element: Hashable {
  func removingDuplicates() -> [Element] {
      var addedDict = [Element: Bool]()
      return filter {
        addedDict.updateValue(true, forKey: $0) == nil
      }
   }
   mutating func removeDuplicates() {
      self = self.removingDuplicates()
   }
}

