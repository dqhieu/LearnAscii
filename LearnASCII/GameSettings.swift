//
//  GameSettings.swift
//  LearnASCII
//
//  Created by Dinh Quang Hieu on 3/31/17.
//  Copyright © 2017 Dinh Quang Hieu. All rights reserved.
//

import UIKit

class GameSettings: NSObject {
    static let shared = GameSettings()
    
    private var _nQuiz: Int = -1
    private var _time: Int = -1
    private var _asciiSystem: AsciiSystem = .char
    
    public var nQuiz: Int {
        get {
            if self._nQuiz == -1 {
                if let nQuiz = UserDefaults.standard.value(forKey: "nQuiz") as? Int {
                    return nQuiz
                }
                return 30
            }
            return self._nQuiz
        }
    }
    
    public var time: Int {
        get {
            if self._time == -1 {
                if let time = UserDefaults.standard.value(forKey: "time") as? Int {
                    return time
                }
                return 2
            }
            return self._time
        }
    }
    
    public var asciiSystem: AsciiSystem {
        get {
            if self._asciiSystem == .char {
                if let system = UserDefaults.standard.value(forKey: "system") as? String {
                    return AsciiSystem(rawValue: system)!
                }
                return .hex
            }
            return self._asciiSystem
        }
    }
    
    func setTime(time: Int) {
        self._time = time
        UserDefaults.standard.set(time, forKey: "time")
    }
    
    func setNumberOfQuiz(nQuiz: Int) {
        self._nQuiz = nQuiz
        UserDefaults.standard.set(nQuiz, forKey: "nQuiz")
    }
    
    func setAsciiSystem(system: AsciiSystem) {
        self._asciiSystem = system
        UserDefaults.standard.set(system.rawValue, forKey: "asciiSystem")
    }
}
