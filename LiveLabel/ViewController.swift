//
//  ViewController.swift
//  LiveLabel
//
//  Created by Apple on 16/6/20.
//  Copyright © 2016年 HeheData. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lyricLabel: LyricLabel!
    @IBOutlet weak var liveLabel: LiveLabel!
    @IBOutlet weak var animateSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }
    
    /**
     Do some initialization
     */
    func setUp(){
        // LyricLabel Usage
        let timer = Timer.scheduledTimer(timeInterval: 1.0/40.0, target: self, selector: #selector(update), userInfo: nil, repeats: true);
        timer.fire()
        
        // LiveLabel Usage
        liveLabel.fromColor = UIColor.init(netHex: 0xD38312).cgColor
        liveLabel.toColor = UIColor.init(netHex: 0xA83279).cgColor

        animateSwitch.addTarget(self, action: #selector(controlState), for: UIControlEvents.valueChanged)
    }
    
    /**
        Update lyric progress(Only one line support)
     */
    func update(){
        lyricLabel.progress += 1
        if lyricLabel.progress > 100 {
            lyricLabel.progress = 1
        }
    }

    func controlState(_ sender : UISwitch){
        liveLabel.setAnimationEnabled(sender.isOn)
    }


}

