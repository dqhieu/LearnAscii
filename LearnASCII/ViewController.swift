//
//  ViewController.swift
//  LearnASCII
//
//  Created by Dinh Quang Hieu on 3/25/17.
//  Copyright © 2017 Dinh Quang Hieu. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController, EndViewControllerDelegate {
    
    var buttonA: UIButton!
    var buttonB: UIButton!
    var buttonC: UIButton!
    var buttonD: UIButton!
    
    var lblCode: UILabel!
    var lblRemainingCode: UILabel!
    
    var progessView: UIProgressView!
    
    var answer: [Int] = [0,0,0,0]
    var currentAnswer: Int = 0
    
    var nQuiz: Int = 30
    var time: Int = 120
    
    var count: Int = 0
    
    var rightAnswer:[Int] = []
    var wrongAnswer:[Int] = []
    
    func initControls() {
        
        lblCode = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        lblCode.text = "4B"
        lblCode.font = UIFont.systemFont(ofSize: 40)
        lblCode.textAlignment = .center
        view.addSubview(lblCode)
        lblCode.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view.snp.centerY)
            make.height.equalTo(50)
        }
        
        buttonA = UIButton(type: .system)
        buttonA.setTitle("%%", for: .normal)
        buttonA.layer.cornerRadius = 5
        buttonA.backgroundColor = UIColor(red: 253.0 / 255.0, green: 178.0 / 255.0, blue: 16.0 / 255.0, alpha: 1.0)
        buttonA.setTitleColor(UIColor.white, for: .normal)
        buttonA.addTarget(self, action: #selector(didTapButtonA), for: .touchUpInside)
        view.addSubview(buttonA)
        buttonA.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.centerY).offset(10)
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(self.view.snp.centerX).offset(-5)
            make.height.equalTo(40)
        }
        
        buttonB = UIButton(type: .system)
        buttonB.setTitle("%%", for: .normal)
        buttonB.layer.cornerRadius = 5
        buttonB.backgroundColor = UIColor(red: 253.0 / 255.0, green: 178.0 / 255.0, blue: 16.0 / 255.0, alpha: 1.0)
        buttonB.setTitleColor(UIColor.white, for: .normal)
        buttonB.addTarget(self, action: #selector(didTapButtonB), for: .touchUpInside)
        view.addSubview(buttonB)
        buttonB.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.centerX).offset(5)
            make.right.equalTo(self.view).offset(-10)
            make.top.equalTo(self.buttonA)
            make.height.equalTo(40)
        }
        
        buttonC = UIButton(type: .system)
        buttonC.setTitle("%%", for: .normal)
        buttonC.layer.cornerRadius = 5
        buttonC.backgroundColor = UIColor(red: 253.0 / 255.0, green: 178.0 / 255.0, blue: 16.0 / 255.0, alpha: 1.0)
        buttonC.setTitleColor(UIColor.white, for: .normal)
        buttonC.addTarget(self, action: #selector(didTapButtonC), for: .touchUpInside)
        view.addSubview(buttonC)
        buttonC.snp.makeConstraints { (make) in
            make.left.equalTo(self.buttonA)
            make.right.equalTo(self.buttonA)
            make.top.equalTo(self.buttonA.snp.bottom).offset(10)
            make.height.equalTo(40)
        }
        
        buttonD = UIButton(type: .system)
        buttonD.setTitle("%%", for: .normal)
        buttonD.layer.cornerRadius = 5
        buttonD.backgroundColor = UIColor(red: 253.0 / 255.0, green: 178.0 / 255.0, blue: 16.0 / 255.0, alpha: 1.0)
        buttonD.setTitleColor(UIColor.white, for: .normal)
        buttonD.addTarget(self, action: #selector(didTapButtonD), for: .touchUpInside)
        view.addSubview(buttonD)
        buttonD.snp.makeConstraints { (make) in
            make.left.equalTo(self.buttonB)
            make.right.equalTo(self.buttonB)
            make.top.equalTo(self.buttonC)
            make.height.equalTo(40)
        }
        
        progessView = UIProgressView(progressViewStyle: .default)
        progessView.progress = 0.0
        view.addSubview(progessView)
        progessView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view)
            make.height.equalTo(5)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
        lblRemainingCode = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
        lblRemainingCode.text = "0/0"
        lblRemainingCode.textColor = UIColor.gray
        lblRemainingCode.font = UIFont.systemFont(ofSize: 30)
        lblRemainingCode.textAlignment = .center
        view.addSubview(lblRemainingCode)
        lblRemainingCode.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.top.equalTo(self.buttonD.snp.bottom).offset(10)
        }

    }
    
    func initGame() {
        initVariables()
        initTimer()
        updateUI()
    }
    
    func initVariables() {
        if let nQuiz = UserDefaults.standard.value(forKey: "nQuiz") as? Int {
            self.nQuiz = nQuiz
        } else {
            self.nQuiz = 30
        }
        if let time = UserDefaults.standard.value(forKey: "time") as? Int {
            self.time = time
        } else {
            self.time = 120
        }
        self.count = 0
        self.progessView.progress = 0
        self.rightAnswer.removeAll()
        self.wrongAnswer.removeAll()
    }
    
    func initTimer() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (timer:Timer) in
            self.progessView.progress += 1.0 / Float(self.time) / 2
            if self.progessView.progress >= 1.0 {
                self.endGame()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initControls()
        initGame()
    }
    
    func updateUI() {
        answer[0] = Int(arc4random()) % AsciiTable.shared.count
        answer[1] = Int(arc4random()) % AsciiTable.shared.count
        answer[2] = Int(arc4random()) % AsciiTable.shared.count
        answer[3] = Int(arc4random()) % AsciiTable.shared.count
        
        currentAnswer = answer[Int(arc4random()) % 4]
        lblCode.text = AsciiTable.shared.getHex(at: currentAnswer)
        
        let textA = NSAttributedString(string: AsciiTable.shared.getChar(at: answer[0]), attributes: [NSForegroundColorAttributeName : UIColor.white, NSFontAttributeName : UIFont.systemFont(ofSize: 20)])
        buttonA.setAttributedTitle(textA, for: .normal)
        let textB = NSAttributedString(string: AsciiTable.shared.getChar(at: answer[1]), attributes: [NSForegroundColorAttributeName : UIColor.white, NSFontAttributeName : UIFont.systemFont(ofSize: 20)])
        buttonB.setAttributedTitle(textB, for: .normal)
        let textC = NSAttributedString(string: AsciiTable.shared.getChar(at: answer[2]), attributes: [NSForegroundColorAttributeName : UIColor.white, NSFontAttributeName : UIFont.systemFont(ofSize: 20)])
        buttonC.setAttributedTitle(textC, for: .normal)
        let textD = NSAttributedString(string: AsciiTable.shared.getChar(at: answer[3]), attributes: [NSForegroundColorAttributeName : UIColor.white, NSFontAttributeName : UIFont.systemFont(ofSize: 20)])
        buttonD.setAttributedTitle(textD, for: .normal)
        
        lblRemainingCode.text = "\(count)/\(nQuiz)"
    }
    
    func checkGameEnd() {
        count += 1
        if count >= nQuiz {
            endGame()
        } else {
            updateUI()
        }
    }
    
    func endGame() {
        let vc = EndViewController()
        vc.rightAnswer = self.rightAnswer
        vc.wrongAnswer = self.wrongAnswer
        vc.delegate = self
        let nvc = UINavigationController(rootViewController: vc)
        present(nvc, animated: true, completion: nil)
    }
    
    func didTapButtonA() {
        if buttonA.titleLabel?.text == AsciiTable.shared.getChar(at: currentAnswer) {
            rightAnswer.append(currentAnswer)
        } else {
            wrongAnswer.append(currentAnswer)
        }
        checkGameEnd()
    }
    
    func didTapButtonB() {
        if buttonB.titleLabel?.text == AsciiTable.shared.getChar(at: currentAnswer) {
            rightAnswer.append(currentAnswer)
        } else {
            wrongAnswer.append(currentAnswer)
        }
        checkGameEnd()
    }
    
    func didTapButtonC() {
        if buttonC.titleLabel?.text == AsciiTable.shared.getChar(at: currentAnswer) {
            rightAnswer.append(currentAnswer)
        } else {
            wrongAnswer.append(currentAnswer)
        }
        checkGameEnd()
    }
    
    func didTapButtonD() {
        if buttonD.titleLabel?.text == AsciiTable.shared.getChar(at: currentAnswer) {
            rightAnswer.append(currentAnswer)
        } else {
            wrongAnswer.append(currentAnswer)
        }
        checkGameEnd()
    }
    
}

extension ViewController {
    func didTapPlayAgain() {
        initGame()
    }
    
    func didTapBackToMenu() {
        self.dismiss(animated: false, completion: nil)
    }
}
