//
//  WelcomeViewController.swift
//  LearnASCII
//
//  Created by Dinh Quang Hieu on 3/25/17.
//  Copyright © 2017 Dinh Quang Hieu. All rights reserved.
//

import UIKit
import SnapKit

class WelcomeViewController: UIViewController {

    struct Constants {
        static let BUTTON_SIZE: CGSize = CGSize(width: 90, height: 40)
    }
    
    var imageView: UIImageView!
    
    var buttonSettings: UIButton!
    var buttonStart: UIButton!
    var buttonLookup: UIButton!
    
    func initControls() {
        imageView = UIImageView(frame: UIScreen.main.bounds)
        imageView.image = UIImage(named: "image.jpg")
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.top.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
        
        buttonSettings = UIButton(type: .system)
        let textSettings = NSAttributedString(string: "Settings", attributes: [NSForegroundColorAttributeName : UIColor.white, NSFontAttributeName : UIFont.systemFont(ofSize: 20)])

        buttonSettings.setAttributedTitle(textSettings, for: .normal)
        buttonSettings.layer.cornerRadius = 5
        buttonSettings.backgroundColor = UIColor(red: 253.0 / 255.0, green: 178.0 / 255.0, blue: 16.0 / 255.0, alpha: 1.0)
        buttonSettings.setTitleColor(UIColor.white, for: .normal)
        buttonSettings.addTarget(self, action: #selector(didTapSettings), for: .touchUpInside)
        view.addSubview(buttonSettings)
        buttonSettings.snp.makeConstraints { (make) in
            make.width.equalTo(Constants.BUTTON_SIZE.width)
            make.height.equalTo(Constants.BUTTON_SIZE.height)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-50)
        }
        
        buttonStart = UIButton(type: .system)
        let textStart = NSAttributedString(string: "Start", attributes: [NSForegroundColorAttributeName : UIColor.white, NSFontAttributeName : UIFont.systemFont(ofSize: 20)])
        buttonStart.setAttributedTitle(textStart, for: .normal)
        buttonStart.layer.cornerRadius = 5
        buttonStart.backgroundColor = UIColor(red: 253.0 / 255.0, green: 178.0 / 255.0, blue: 16.0 / 255.0, alpha: 1.0)
        buttonStart.setTitleColor(UIColor.white, for: .normal)
        buttonStart.addTarget(self, action: #selector(didTapStart), for: .touchUpInside)
        view.addSubview(buttonStart)
        buttonStart.snp.makeConstraints { (make) in
            make.width.equalTo(Constants.BUTTON_SIZE.width)
            make.height.equalTo(Constants.BUTTON_SIZE.height)
            make.right.equalTo(self.buttonSettings.snp.left).offset(-10)
            make.bottom.equalTo(self.buttonSettings)
        }
        
        buttonLookup = UIButton(type: .system)
        let textLookup = NSAttributedString(string: "Lookup", attributes: [NSForegroundColorAttributeName : UIColor.white, NSFontAttributeName : UIFont.systemFont(ofSize: 20)])
        buttonLookup.setAttributedTitle(textLookup, for: .normal)
        buttonLookup.layer.cornerRadius = 5
        buttonLookup.backgroundColor = UIColor(red: 253.0 / 255.0, green: 178.0 / 255.0, blue: 16.0 / 255.0, alpha: 1.0)
        buttonLookup.setTitleColor(UIColor.white, for: .normal)
        buttonLookup.addTarget(self, action: #selector(didTapLookup), for: .touchUpInside)
        view.addSubview(buttonLookup)
        buttonLookup.snp.makeConstraints { (make) in
            make.width.equalTo(Constants.BUTTON_SIZE.width)
            make.height.equalTo(Constants.BUTTON_SIZE.height)
            make.left.equalTo(self.buttonSettings.snp.right).offset(10)
            make.bottom.equalTo(self.buttonSettings)
        }

    }
    
    func initVariables() {
        UserDefaults.standard.set(30, forKey: "nQuiz")
        UserDefaults.standard.set(120, forKey: "time")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initControls()
        initVariables()
    }
    
    func didTapStart() {
        let vc = ViewController()
        present(vc, animated: true, completion: nil)
    }

    func didTapSettings() {
        let alert = UIAlertController(title: "Settings", message: nil, preferredStyle: .alert)
        alert.addTextField { (textfield: UITextField) in
            textfield.keyboardType = .numberPad
            textfield.placeholder = "Number of quiz"
            if let nQuiz = UserDefaults.standard.value(forKey: "nQuiz") as? Int {
                textfield.text = String(nQuiz)
            }
        }
        alert.addTextField { (textfield: UITextField) in
            textfield.keyboardType = .numberPad
            textfield.placeholder = "Time in second"
            if let time = UserDefaults.standard.value(forKey: "time") as? Int {
                textfield.text = String(time)
            }
        }
        let actionOK = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in
            if let nQuiz = Int((alert.textFields?.first?.text)!) {
                UserDefaults.standard.set(nQuiz, forKey: "nQuiz")
            }
            if let time = Int((alert.textFields?[1].text)!) {
                UserDefaults.standard.set(time, forKey: "time")
            }
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(actionOK)
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }
    
    func didTapLookup() {
        let vc = LookupViewController()
        let nvc = UINavigationController(rootViewController: vc)
        self.present(nvc, animated: true, completion: nil)
    }
}
