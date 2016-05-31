//
//  ViewController.swift
//  HearTheMusic
//
//  Created by Dmitry Bykov on 21/05/16.
//  Copyright © 2016 Dmitry Bykov. All rights reserved.
//

import UIKit
import AVFoundation

class GameRoundAnswerViewController: UIViewController {

    @IBOutlet weak var buttonPlayQuestion: UIButton!

    @IBOutlet weak var buttonAnswerFirst: UIButton!
    @IBOutlet weak var buttonAnswerSecond: UIButton!
    @IBOutlet weak var buttonAnswerThird: UIButton!
    @IBOutlet weak var buttonAnswerFourth: UIButton!
    var answerButtons: [UIButton] = []
    var roundNum: Int = 1

    let notes = MusicLibrary().notes
    
    
    // Setup a question
    // Select 2 random notes and define the answer
    
    // Create audio players for 2 notes
    
    var firstNotePlayer: AVAudioPlayer!
    var secondNotePlayer: AVAudioPlayer!
    
    func playFirstNote(note: String) {
        let audioPath = NSBundle.mainBundle().pathForResource(note, ofType: "aiff")!
        let audioURL = NSURL(fileURLWithPath: audioPath)
        do {
            try firstNotePlayer = AVAudioPlayer(contentsOfURL: audioURL, fileTypeHint: nil)
        } catch {
            //Handle the error
        }
    }
    
    func playSecondNote(note: String) {
        let audioPath = NSBundle.mainBundle().pathForResource(note, ofType: "aiff")!
        let audioURL = NSURL(fileURLWithPath: audioPath)
        do {
            try secondNotePlayer = AVAudioPlayer(contentsOfURL: audioURL, fileTypeHint: nil)
        } catch {
            //Handle the error
        }
    }
    
    func playNote(player: AVAudioPlayer, start: Double, stop: Double, phase: Double) {
        let startTime = start * Double(NSEC_PER_SEC)
        let stopTime = stop * Double(NSEC_PER_SEC)
        // Start playback after defined amount of seconds
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(startTime)), dispatch_get_main_queue(), {
            player.stop()
            player.currentTime = phase
            player.play()
        })
        // Stop playback after defined amount of seconds
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(stopTime)), dispatch_get_main_queue(), {
            player.stop()

        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create question
        let firstNoteIndex = Int(arc4random_uniform(UInt32(notes.count)))
        let direction = Int(arc4random_uniform(UInt32(2)))
        var secondNoteIndex: Int = 1
        
        if (direction > 0) {
            secondNoteIndex = firstNoteIndex - Int(arc4random_uniform(UInt32(roundNum + 1)))
        } else {
            secondNoteIndex = firstNoteIndex + Int(arc4random_uniform(UInt32(roundNum + 1)))
        }
        
        if (secondNoteIndex < 0) {
            secondNoteIndex = 0
        }
        
        print(firstNoteIndex)
        print(secondNoteIndex)
        
        playFirstNote(notes[firstNoteIndex])
        playSecondNote(notes[secondNoteIndex])
        
        // Create answers

        // Round button corners
        answerButtons += [buttonAnswerFirst, buttonAnswerSecond, buttonAnswerThird,buttonAnswerFourth]
        for button in answerButtons {
            button.layer.cornerRadius = button.frame.size.height / 2
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playQuestion(sender: AnyObject) {
        // Repeat the question
        playNote(firstNotePlayer, start: 0.0, stop: 3, phase: 0.5)
        playNote(secondNotePlayer, start: 0.5, stop: 3, phase: 0.5)
    }

}

