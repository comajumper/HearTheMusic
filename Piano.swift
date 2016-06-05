//
//  Piano.swift
//  HearTheMusic
//
//  Created by Dmitry Bykov on 04/06/16.
//  Copyright © 2016 Dmitry Bykov. All rights reserved.
//

import Foundation
import AVFoundation

struct Piano {
    
    func playInterval(interval: Interval) {
        
    }
    
    func setupNoteAudioPlayer(note: Note) -> AVAudioPlayer? {
        return try! AVAudioPlayer(contentsOfURL: note.audioFileURL, fileTypeHint: nil)
    }
    
}

//func playInterval(firstNote: Note, secondNote: Note) {
//    let firstNotePlayer: AVAudioPlayer!
//    let secondNotePlayer: AVAudioPlayer!
//    do {
//        try firstNotePlayer = AVAudioPlayer(contentsOfURL: firstNote.audioFileURL(), fileTypeHint: nil)
//        try secondNotePlayer = AVAudioPlayer(contentsOfURL: secondNote.audioFileURL(), fileTypeHint: nil)
//        playNote(secondNotePlayer, start: 0.5, stop: 3, phase: 0.5)
//        playNote(firstNotePlayer, start: 0.0, stop: 3, phase: 0.5)
//    } catch {}
//}
//
//// Play a single note
//func playNote(player: AVAudioPlayer, start: Double, stop: Double, phase: Double) {
//    let startTime = start * Double(NSEC_PER_SEC)
//    let stopTime = stop * Double(NSEC_PER_SEC)
//    // Start playback after delay
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(startTime)), dispatch_get_main_queue(), {
//        player.stop()
//        player.currentTime = phase
//        player.play()
//    })
//    // Stop playback after delay
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(stopTime)), dispatch_get_main_queue(), {
//        player.stop()
//    })
//}


//
//struct Settings {
//    private let lastLevelKey = "lastLevelKey"
//    private let gamePointsKey = "gamePointsKey"
//
//    private func writeInt(value: Int, forKey key: String) {
//        let defaults = NSUserDefaults.standardUserDefaults()
//        defaults.setInteger(value, forKey: key)
//        defaults.synchronize()
//    }
//
//    private func readInt(forKey key: String) -> Int? {
//        let defaults = NSUserDefaults.standardUserDefaults()
//        return defaults.integerForKey(key)
//    }
//
//    var lastLevel: Int {
//        get {
//            if let level = readInt(forKey: lastLevelKey) {
//                return level
//            } else {
//                return 0
//            }
//        }
//
//        set {
//            writeInt(newValue, forKey: lastLevelKey)
//        }
//    }
//
//    var gamePoints: Int {
//        get {
//            if let points = readInt(forKey: gamePointsKey) {
//                return points
//            } else {
//                return 0
//            }
//        }
//        set {
//            writeInt(newValue, forKey: gamePointsKey)
//        }
//    }
//}