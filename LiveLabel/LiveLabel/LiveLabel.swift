//
//  LiveLabel.swift
//  LiveLabel
//
//  Created by Apple on 16/6/20.
//  Copyright © 2016年 HeheData. All rights reserved.
//

import UIKit
import Foundation

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

class LiveLabel: UILabel {

    private var progress : Int = 0
    private var image2Use : UIImage?
    
    var timer : Timer?
    
    var fromColor : CGColor = UIColor.init(netHex: 0xC9FFBF).cgColor
    var toColor : CGColor = UIColor.init(netHex: 0xFFAFBD).cgColor
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUp()
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.setUp()
    }

    private func setUp(){
        timer = Timer.scheduledTimer(timeInterval: 1.0/100.0, target: self, selector: #selector(update), userInfo: nil, repeats: true);
        timer?.fire()
    }

    // Update gradient position & redraw the view
    @objc private func update(){
        progress += 1
        if progress > 66 {
            progress = 1
        }
        self.setNeedsDisplay()
    }
    
    // Get UIImage from CALayer
    private func getImageWithCALayer(_ layer:CALayer,_ progress:Int) -> UIImage?{
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image : UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return UIImage(cgImage: (image?.cgImage)!.cropping(to: CGRect(x: (image?.size.width)! * CGFloat(progress) * 0.01, y: 0, width: (image?.size.width)! * 1.0/3.0, height: (image?.size.height)!))!)
    }
    
    /**
     Control state of animation state, if disabled, the animation stops.
     
     - parameter enabled: whether enable the animation
     */
    func setAnimationEnabled(_ enabled : Bool){
        if enabled && !((timer?.isValid)!) {
            timer = Timer.scheduledTimer(timeInterval: 1.0/100.0, target: self, selector: #selector(update), userInfo: nil, repeats: true);
            timer?.fire()
        }
        else{
            timer?.invalidate()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let size = self.frame.size
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: size.width * 3, height: size.height)
        gradient.colors = [fromColor, toColor, fromColor, toColor]
        
        gradient.endPoint = CGPoint(x: 0, y: 0.5)
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        getImageWithCALayer(gradient, progress)?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height), blendMode: CGBlendMode.sourceAtop, alpha: 1)
        
    }
}
