//
//  LiveViewController.swift
//  DouYuTest
//
//  Created by 华罗庚 on 2019/4/11.
//  Copyright © 2019年 华罗庚. All rights reserved.
//

import UIKit

class LiveViewController: UIViewController {

    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    
    var timer : Timer? = Timer()
    var isPlaying = false
    var counter : Float = 0.0 {
        didSet {
            countLabel.text = String(format: "%.1f", counter)
        }
    }
    
    
    
    
    @IBAction func resetBtnDidClicked(_ sender: UIButton) {
        if let timerTemp = timer {
            timerTemp.invalidate()
        }
        timer = nil
        isPlaying = false
        counter = 0
        startBtn.isEnabled = true
        pauseBtn.isEnabled = true
    }
    @IBAction func startBtnDidClicked(_ sender: UIButton) {
        startBtn.isEnabled = false
        pauseBtn.isEnabled = true
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        isPlaying = true;
    }
    @IBAction func pauseBtnDidClicked(_ sender: Any) {
        startBtn.isEnabled = true
        pauseBtn.isEnabled = false
        if let timerTemp = timer {
            timerTemp.invalidate()
        }
        timer = nil
        isPlaying = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        counter = 0.0
        
    }
    
    @objc func updateTimer() {
        counter = counter + 0.1
    }

}


