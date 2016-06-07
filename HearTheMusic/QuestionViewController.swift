//
//  ViewController.swift
//  HearTheMusic
//
//  Created by Dmitry Bykov on 21/05/16.
//  Copyright © 2016 Dmitry Bykov. All rights reserved.
//

import UIKit
import AVFoundation

class QuestionViewController: UIViewController {
    
    var game = Game()
	
	// Generate default Piano
	var musicPiano = Piano(interval: Interval(firstNote: "A3", secondNote: "B3"))
	var correctAnswerType: String = ""
    
    // Create control outlets
    @IBOutlet weak var buttonPlayQuestion: UIButton!
    @IBOutlet weak var buttonAnswerFirst: UIButton!
    @IBOutlet weak var buttonAnswerSecond: UIButton!
    @IBOutlet weak var buttonAnswerThird: UIButton!
    @IBOutlet weak var buttonAnswerFourth: UIButton!
    
    var answerButtons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerButtons = [buttonAnswerFirst, buttonAnswerSecond, buttonAnswerThird,buttonAnswerFourth]
        // Start the game
        game.start()
        prepareTheStage(game.answers)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func prepareTheStage(answers: [String]) {
        // Round button corners
        buttonAnswerFirst.setTitle(answers[0], forState: .Normal)
        buttonAnswerSecond.setTitle(answers[1], forState: .Normal)
        buttonAnswerThird.setTitle(answers[2], forState: .Normal)
        buttonAnswerFourth.setTitle(answers[3], forState: .Normal)
		
		correctAnswerType = String(Mirror(reflecting: game.correctAnswer).subjectType)
		
		if (correctAnswerType == "Interval") {
			musicPiano = Piano(interval: game.correctAnswer)
		}
        
        for button in answerButtons {
            button.layer.cornerRadius = button.frame.size.height / 2
            button.layer.backgroundColor = UIColor.whiteColor().CGColor
            button.alpha = 1.0
        }
    }
	
    // Action for Play button
    @IBAction func playQuestion(sender: AnyObject) {
		if (correctAnswerType == "Interval") {
			musicPiano.playInterval()
		}
    }
    
    // User clicks an answer
    @IBAction func answerOne(sender: UIButton) {
        answerButtonClicked(sender)
    }
    @IBAction func answerTwo(sender: UIButton) {
        answerButtonClicked(sender)
    }
    @IBAction func answerThree(sender: UIButton) {
        answerButtonClicked(sender)
    }
    @IBAction func answerFour(sender: UIButton) {
        answerButtonClicked(sender)
    }
    
    func answerButtonClicked(answer: UIButton) {
        let success = game.checkAnswer(answer.currentTitle!)
        
        if (success) {
            print("You've heard it. Great job!")
            answer.layer.backgroundColor =
                UIColor(red: 185/255, green: 218/255, blue: 143/255, alpha: 1.0).CGColor
            
            for button in answerButtons {
                if(button != answer) {
                    button.alpha = 0.0
                }
            }
        } else {
            print("You should try harder.")
            answer.layer.backgroundColor =
                UIColor(red: 247/255, green: 114/255, blue: 101/255, alpha: 1.0).CGColor
            for button in answerButtons {
                if(button.currentTitle == game.correctAnswer.name) {
                    button.layer.backgroundColor =
                        UIColor(red: 185/255, green: 218/255, blue: 143/255, alpha: 1.0).CGColor
                } else if (button != answer) {
                    button.alpha = 0.0
                }
            }
        }
        
        executeAfterDelay(1) {
            for button in self.answerButtons {
                button.alpha = 0
            }
            self.executeAfterDelay(1) {
                self.game.nextQuestion()
                self.prepareTheStage(self.game.answers)
            }
        }
        
    }
    
    // Отложенный запуск функции
    func executeAfterDelay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(),
            closure
        )
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