//
//  ViewController.swift
//  MixpanelDemo
//
//  Created by Simon Ng on 2/3/2017.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit
import Mixpanel

class ViewController: UIViewController {

    @IBOutlet var counterLabel: UILabel!
    
    var counter = 60
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counterLabel.text = String(counter)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startClick(_ sender: Any) {
        
        if timer.isValid {
            timer.invalidate()
        }
        
        counter = 60
        counterLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.countdown), userInfo: nil, repeats: true)
        
        //Track Event
        Mixpanel.mainInstance().time(event: "Timer Started")
    }

    @IBAction func stopClick(_ sender: Any) {
        timer.invalidate()
        
        //Track event with property
        Mixpanel.mainInstance().track(event: "Timer Stopped", properties: ["Counter":counterLabel.text!])
        Mixpanel.mainInstance().people.set(property:"Latest Time Record", to: counterLabel.text!)
        Mixpanel.mainInstance().people.increment(property: "Stop hits",by: 1)
    }
    
    func countdown() {
        if(counter > 0){
            counter -= 1
            counterLabel.text = String(counter)
        }
        else {
            timer.invalidate()
        }
    }
}


