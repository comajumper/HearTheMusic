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
    
    var game = Game()
    
    // Create control outlets
    @IBOutlet weak var buttonPlayQuestion: UIButton!
    @IBOutlet weak var buttonAnswerFirst: UIButton!
    @IBOutlet weak var buttonAnswerSecond: UIButton!
    @IBOutlet weak var buttonAnswerThird: UIButton!
    @IBOutlet weak var buttonAnswerFourth: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Start the game
        game.start()
        prepareTheStage(game.answers)
        
        // Round button corners
        for button in [buttonAnswerFirst, buttonAnswerSecond, buttonAnswerThird,buttonAnswerFourth] {
            button.layer.cornerRadius = button.frame.size.height / 2
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func prepareTheStage(answers: [String]) {
        buttonAnswerFirst.setTitle(answers[0], forState: .Normal)
        buttonAnswerSecond.setTitle(answers[1], forState: .Normal)
        buttonAnswerThird.setTitle(answers[2], forState: .Normal)
        buttonAnswerFourth.setTitle(answers[3], forState: .Normal)
    }
    
    // Action for Play button
    @IBAction func playQuestion(sender: AnyObject) {
//        noteAudioPlayer.play()
//        playInterval(notesToPlay[0], secondNote: notesToPlay[1])
    }
    
    // User clicks an answer
    @IBAction func answerOne(sender: UIButton) {
        let success = game.checkAnswer(sender.currentTitle!)
        if (success) {
            print("You've heard it. Great job!")
        } else {
            print("You should try harder.")
        }
    }
    @IBAction func answerTwo(sender: UIButton) {
        let success = game.checkAnswer(sender.currentTitle!)
        if (success) {
            print("You've heard it. Great job!")
        } else {
            print("You should try harder.")
        }
    }
    @IBAction func answerThree(sender: UIButton) {
        let success = game.checkAnswer(sender.currentTitle!)
        if (success) {
            print("You've heard it. Great job!")
        } else {
            print("You should try harder.")
        }
    }
    @IBAction func answerFour(sender: UIButton) {
        let success = game.checkAnswer(sender.currentTitle!)
        if (success) {
            print("You've heard it. Great job!")
        } else {
            print("You should try harder.")
        }
    }
  
    
    
    
    
    
    //
//    // Play an interval
//    func playInterval(firstNote: Note, secondNote: Note) {
//        let firstNotePlayer: AVAudioPlayer!
//        let secondNotePlayer: AVAudioPlayer!
//        do {
//            try firstNotePlayer = AVAudioPlayer(contentsOfURL: firstNote.audioFileURL(), fileTypeHint: nil)
//            try secondNotePlayer = AVAudioPlayer(contentsOfURL: secondNote.audioFileURL(), fileTypeHint: nil)
//            playNote(secondNotePlayer, start: 0.5, stop: 3, phase: 0.5)
//            playNote(firstNotePlayer, start: 0.0, stop: 3, phase: 0.5)
//        } catch {}
//    }
//    
//    // Play a single note
//    func playNote(player: AVAudioPlayer, start: Double, stop: Double, phase: Double) {
//        let startTime = start * Double(NSEC_PER_SEC)
//        let stopTime = stop * Double(NSEC_PER_SEC)
//        // Start playback after delay
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(startTime)), dispatch_get_main_queue(), {
//            player.stop()
//            player.currentTime = phase
//            player.play()
//        })
//        // Stop playback after delay
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(stopTime)), dispatch_get_main_queue(), {
//            player.stop()
//        })
//    }
}