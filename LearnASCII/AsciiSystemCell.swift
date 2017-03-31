//
//  AsciiSystemCell.swift
//  LearnASCII
//
//  Created by Dinh Quang Hieu on 3/31/17.
//  Copyright © 2017 Dinh Quang Hieu. All rights reserved.
//

import UIKit

protocol AsciiSystemCellDelegate {
    func didPickAsciiSystem(system: AsciiSystem)
}

class AsciiSystemCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pickerView: UIPickerView!
    
    var pickerData:[AsciiSystem] = [.bin, .oct, .dec, .hex]
    var delegate: AsciiSystemCellDelegate?
    
    func setup() {
        pickerView = UIPickerView(frame: CGRect(x: UIScreen.main.bounds.width - 170, y: 0, width: 150, height: self.frame.height))
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.clipsToBounds = true
        pickerView.showsSelectionIndicator = false
        pickerView.reloadAllComponents()
        pickerView.selectRow(pickerData.index(of: GameSettings.shared.asciiSystem)!, inComponent: 0, animated: false)
        addSubview(pickerView)
        
        textLabel?.text = "System"
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 150
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return self.frame.height
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: pickerView.frame)
        label.text = pickerData[row].rawValue
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.didPickAsciiSystem(system: pickerData[row])
    }
    
}

