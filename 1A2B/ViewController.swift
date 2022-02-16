//
//  ViewController.swift
//  1A2B
//
//  Created by Chu Go-Go on 2022/2/14.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var guessNumLB: UILabel!
    @IBOutlet weak var answerLB: UILabel!
    @IBOutlet weak var timeLB: UILabel!
    @IBOutlet weak var resultTV: UITextView!
    @IBOutlet weak var loseLB: UILabel!
    @IBOutlet weak var sentButton: UIButton!
    @IBOutlet weak var roundCountLB: UILabel!
    @IBOutlet weak var ruleTextView: UITextView!
    @IBOutlet weak var winLB: UILabel!
    @IBOutlet weak var gameScore: UITextView!
//    先建立一個0-9的Array
    var gameNum = ["0","1","2","3","4","5","6","7","8","9"]
    var gameAnswer = [String]()
    var answerNumber = ""
    var guessNum = [String]()
    var tapNum = ""
    var timer: Timer?
    var time = 0.0
    var gameCount = 0
    var showIndex = 0
    var okButton = 0
    var noteIndex = 0
    var ruleIndex = 0
    var guessCount = 0
    var roundCount = 15
    var guesstime = 0
    override func viewDidLoad() {
        gameTime()
        creatNum()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func resetButton(_ sender: UIButton) {
        usealert(tittle: "重新一局?", message: "再挑戰一把？")
        resetGame()
        creatNum()
    }
    @IBAction func ruleButton(_ sender: UIButton) {
        ruleIndex += 1
        if ruleIndex == 1{
            ruleTextView.isHidden = false
        }else{
            ruleTextView.isHidden = true
            ruleIndex = 0
        }
    }
    @IBAction func sentAnswerButton(_ sender: UIButton) {
        guessNum.removeLast()
        guesstime += 1
        roundCount -= 1
        var a = 0
        var b = 0
        print("行不行\(guessNum)")
        print("答案\(gameAnswer)")
        if roundCount == 0{
            loseLB.isHidden = false
            gameScore.text = "你要好好加油！"
        }
        for c in 0...3 {
           
            print("迴圈答案\(gameAnswer[c])")
            print("猜數字\(guessNum[c])")
            if guessNum[c] == gameAnswer[c] {
                print("數字\(gameNum[c])")
                print("a\(a)")
                a += 1
            } else if guessNum.contains(gameAnswer[c]){
                print("a1\(a)")
                print("b\(b)")
                b += 1
            }
        }
        print("aa\(a)")
            if a == 4 {
                answerLB.text = "Good!"
                winLB.isHidden = false
                timer?.invalidate()
                let timeScore = String(format: "%.1f", time)
                gameScore.isHidden = false
                gameScore.text = "恭喜你答對囉！\n答案是\n\(guessNumLB.text!)\n猜了\(guesstime)次\n耗時：\(timeScore)秒"
                resultTV.isHidden = true
                resultTV.text = ""
            }else {
                print("a3\(a)")
                guessCount += 1
                resultTV.text += "第\(guessCount)次\(a)A\(b)B " + guessNumLB.text! + "\n"
                roundCountLB.text = "剩下\(roundCount)次"
            }
            NumClear()
    }
    
    @IBAction func clickAnswerNum(_ sender: UIButton) {
        //        tag要在Button的View調整
        tapNum.append("\(sender.tag),")
        guessNum = tapNum.components(separatedBy: ",")
        guessNumLB.text = guessNum.joined(separator: "")
        if guessNum.count < 5 {
            sentButton.isEnabled = false
        }else if guessNum.count == 5 {
            sentButton.isEnabled = true
        }else if guessNum.count > 5{
            usealert(tittle: "你數字打太多啦！", message: "請輸入四位數")
            sentButton.isEnabled = false
        }
        
        print("存數字\(guessNum)")
        print("案件數字\(tapNum)")
    }
    @IBAction func clickNoteNum(_ sender: UIButton) {

        noteIndex += 1
        if  noteIndex == 1 {
        
            sender.alpha = 0.3
        }else {
            sender.alpha = 1
            noteIndex = 0
        }
        print("第一案\(sender.alpha)")
    }
    
    @IBAction func ClickShowAnswer(_ sender: UIButton) {
        let alert = UIAlertController(title: "真的要偷看答案？", message: "人要靠自己！", preferredStyle: .alert)
        let yesAlert = UIAlertAction(title: "確定", style: .default) { _ in
            self.answerLB.text = "\(self.answerNumber)"
        }
        alert.addAction(yesAlert)
        let canelAlert = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        alert.addAction(canelAlert)
        
        present(alert, animated: true, completion: nil)
//        if okButton == 1 {
//            showIndex += 1
//            if showIndex == 1 {
//                answerLB.text = "\(answerNumber)"
//            }else if showIndex  > 1 {
//                answerLB.text = "1A2B"
//                showIndex = 0
//                okButton = 0
//            }
//        }
    }
    @IBAction func ClickdeletNum(_ sender: UIButton) {
        guessNumLB.text = ""
        tapNum = ""
    }
    func creatNum(){
//        先把陣列裡的數字洗牌
        gameNum.shuffle()
//        從裡面取4個
        let answerNum = gameNum.prefix(4)
//        取到的值儲存起來之後要拿來比較
        gameAnswer = Array(answerNum)
//        在用array把gameAnswer叫出來並且儲存
        for gameAnswer in gameAnswer {
            answerNumber = answerNumber + gameAnswer
            print("\(answerNumber)")
        }
        
         print(gameAnswer)
    }
    func usealert(tittle: String, message: String?){
        let alert = UIAlertController(title: tittle, message: message, preferredStyle: .alert)
        let canelAlert = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let yesAlert = UIAlertAction(title: "確定", style: .default)
        alert.addAction(canelAlert)
        alert.addAction(yesAlert)
        present(alert, animated: true, completion: nil)
    }
    func NumClear(){
        tapNum.removeAll()
        guessNumLB.text = ""
        
    }
    func resetGame(){
        tapNum.removeAll()
        guessNumLB.text = ""
        time = 0.0
        winLB.isHidden = true
        gameScore.isHidden = true
        loseLB.isHidden = true
        roundCount = 0
        noteIndex = 0
        answerLB.text = "1A2B"
        resultTV.isHidden = false
        gameTime()
    }
    func gameTime(){
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
    }
    @objc func updateTime(){
        time += 0.1
        timeLB.text = String(format: "%.f", time)
    }
}

