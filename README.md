# LiveLabel
Dynamic gradient label and Lyric Label for iOS

## Overview
UILabel for shimmer and lyric effect

## Basic usage 
Import LiveLabel.swift and LyricLabel.swift into you project first.

![Demo Overview](https://raw.githubusercontent.com/LitleCarl/LiveLabel/master/out.gif)

``` swift
  // LyricLabel Usage
  let timer = Timer.scheduledTimer(timeInterval: 1.0/40.0, target: self, selector: #selector(update), userInfo: nil, repeats: true);
  timer.fire()
  
  // LiveLabel Usage 
  liveLabel.fromColor = UIColor.init(netHex: 0x00C9FF).cgColor // Here is an entension init method for UIColor from LiveLabel.swift
  liveLabel.toColor = UIColor.init(netHex: 0x92FE9D).cgColor // Here is an entension init method for UIColor from LiveLabel.swift
  liveLabel.setAnimationEnabled(sender.isOn)
  ...
    
  /**
      Update lyric progress(Only one line support)
  */
  func update(){
      lyricLabel.progress += 1
      if lyricLabel.progress > 100 {
        lyricLabel.progress = 1
      }
  }

```

##Installation
Download or clone this repo and import LiveLable.swift & LyricLable.swift and you are ready to go.

##TODO
Objective-C implemention

##License
MIT
