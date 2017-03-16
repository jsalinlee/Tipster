//
//  ViewController.swift
//  Tipster
//
//  Created by Jonathan Salin Lee on 3/9/17.
//  Copyright © 2017 Jonathan Salin Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var preTotal = 0.0
    var groupSizer = 1
    var tipPercent = 0.0
    var tipAmount = 0.0
    var total = 0.0
    var totalString = String()
    @IBOutlet weak var preTipTotal: UILabel!
    @IBOutlet var tipInfo: [UILabel]!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var groupSizeLabel: UILabel!
    @IBOutlet weak var groupSizeSlider: UISlider!
    @IBAction func numPad(_ sender: UIButton) {
        if sender.tag < 10{
            totalString += String(sender.tag)
            preTotal = Double(totalString)! / Double(groupSizer)
        } else if sender.tag == 10{
            totalString = ""
            preTotal = 0
        } else if sender.tag == 11{
            totalString += "."
            preTotal = Double(totalString)! / Double(groupSizer)
            sender.isEnabled = false
        }
        if preTotal.truncatingRemainder(dividingBy: 1.0) == 0 && sender.tag != 11{
            totalString = String(Int(preTotal))
        }
        preTipTotal.text = totalString
        update()
    }
    @IBAction func tip(_ sender: UISlider) {
        tipPercent = Double(Int(sender.value)) / 100
        update()
        
    }
    @IBAction func groupSize(_ sender: UISlider) {
        groupSizer = Int(sender.value)
        groupSizeLabel.text = "Group Size: " + String(groupSizer)
        update()
    }
    func update(){
        let lowTip = tipPercent * preTotal
        let medTip = (tipPercent + 0.05) * preTotal
        let highTip = (tipPercent + 0.1) * preTotal
        tipInfo[0].text = String(Int(tipPercent * 100)) + "%"
        tipInfo[1].text = String(Int(tipPercent * 100 + 5)) + "%"
        tipInfo[2].text = String(Int(tipPercent * 100 + 10)) + "%"
        tipInfo[3].text = String(format: "%.2f", Double(Int(lowTip * 100)) / 100 / Double(groupSizer))
        tipInfo[4].text = String(format: "%.2f", Double(Int(medTip * 100)) / 100 / Double(groupSizer))
        tipInfo[5].text = String(format: "%.2f", Double(Int(highTip * 100)) / 100 / Double(groupSizer))
        tipInfo[6].text = String(format: "%.2f", Double(Int((preTotal + lowTip) * 100)) / 100 / Double(groupSizer))
        tipInfo[7].text = String(format: "%.2f", Double(Int((preTotal + medTip) * 100)) / 100 / Double(groupSizer))
        tipInfo[8].text = String(format: "%.2f", Double(Int((preTotal + highTip) * 100)) / 100 / Double(groupSizer))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        preTipTotal.text = ""
        tipSlider.minimumValue = 0
        tipSlider.maximumValue = 90
        groupSizeSlider.minimumValue = 1
        groupSizeSlider.maximumValue = 10
        update()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

