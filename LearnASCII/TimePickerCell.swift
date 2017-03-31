//
//  TimePickerCell.swift
//  LearnASCII
//
//  Created by Dinh Quang Hieu on 3/31/17.
//  Copyright © 2017 Dinh Quang Hieu. All rights reserved.
//

import UIKit

protocol TimePickerCellDelegate {
    func didPickTime(minutes: Int)
}

class TimePickerCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {

    var pickerView: UIPickerView!
    
    var pickerData:[Int] = [1,2,3,4,5,6,7,8,9,10]
    var delegate: TimePickerCellDelegate?
    
    func setup() {
        pickerView = UIPickerView(frame: CGRect(x: UIScreen.main.bounds.width - 70, y: 0, width: 50, height: self.frame.height))
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.clipsToBounds = true
        pickerView.showsSelectionIndicator = false
        pickerView.reloadAllComponents()
        pickerView.selectRow(pickerData.index(of: GameSettings.shared.time)!, inComponent: 0, animated: false)
        addSubview(pickerView)
        
        textLabel?.text = "Time in minutes"
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return self.frame.height
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerData[row])
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.didPickTime(minutes: pickerData[row])
    }

}
