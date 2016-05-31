//
//  SoundLibrary.swift
//  HearTheMusic
//
//  Created by Dmitry Bykov on 31/05/16.
//  Copyright © 2016 Dmitry Bykov. All rights reserved.
//

import Foundation

struct Note {
    let pitch: String
    func audioFileURL() -> NSURL {
        return NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(self.pitch, ofType: "aiff")!)
    }
}

struct MusicLibrary {
    
    let notes = [
        "C3", "Db3", "D3", "Eb3", "E3", "F3", "Gb3", "G3", "Ab3", "A3", "Bb3", "B3"
    ]
    
    let intervals = [
        "Unison"
    ]
    
}