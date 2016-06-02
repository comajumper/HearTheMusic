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

struct Interval {
    let name: String
    
    init(firstNote: String, secondNote: String) {
        let firstNoteIndex = MusicLibrary().notes.indexOf(firstNote)!
        let secondNoteIndex = MusicLibrary().notes.indexOf(secondNote)!
        self.name = MusicLibrary().intervals[abs(firstNoteIndex - secondNoteIndex)]
    }
}

struct MusicLibrary {
    
    let notes = [
        "C3", "Db3", "D3", "Eb3", "E3", "F3", "Gb3", "G3", "Ab3", "A3", "Bb3", "B3"
    ]
    
    let intervals = [
        "Unison",
        "Minor 2nd",
        "Major 2nd",
        "Minor 3rd",
        "Major 3rd",
        "Perfect 4th",
        "Tritone",
        "Perfect 5th",
        "Minor 6th",
        "Major 6th",
        "Minor 7th",
        "Major 7th",
        "Octave"
    ]
    
}