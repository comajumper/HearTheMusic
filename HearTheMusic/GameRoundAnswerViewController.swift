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
    
    var gameRound: Int = 1
    var questionNum: Int = 1
    var maxQuestionCount: Int = 7
    var correctAnswer: String = ""
    var answerButtons: [UIButton] = []
    var notesToPlay: [Note] = []
    
    // Create control outlets
    @IBOutlet weak var buttonPlayQuestion: UIButton!
    @IBOutlet weak var buttonAnswerFirst: UIButton!
    @IBOutlet weak var buttonAnswerSecond: UIButton!
    @IBOutlet weak var buttonAnswerThird: UIButton!
    @IBOutlet weak var buttonAnswerFourth: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextQuestion()

        // Round button corners
        answerButtons = [buttonAnswerFirst, buttonAnswerSecond, buttonAnswerThird,buttonAnswerFourth]
        for button in answerButtons {
            button.layer.cornerRadius = button.frame.size.height / 2
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func nextQuestion() {
        if (questionNum > maxQuestionCount) {
            print("Round \(gameRound) ended")
        } else {
            questionNum += 1
            
            // Generate random question based for this round
            generateRandomQuestion(gameRound)
            for button in answerButtons {
                button.alpha = 0.0
            }
            // Calculate interval
            let answers = createAnswers()
            
            buttonAnswerFirst.setTitle(answers[0], forState: .Normal)
            buttonAnswerSecond.setTitle(answers[1], forState: .Normal)
            buttonAnswerThird.setTitle(answers[2], forState: .Normal)
            buttonAnswerFourth.setTitle(answers[3], forState: .Normal)
            
            let delay = 1 * Double(NSEC_PER_SEC)
            // Start playback after delay
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay)), dispatch_get_main_queue(), {
                for button in self.answerButtons {
                    button.alpha = 1.0
                }
            })
            
            
            
            
        }
    }
    
    // Action for Play button
    @IBAction func playQuestion(sender: AnyObject) {
        playInterval(notesToPlay[0], secondNote: notesToPlay[1])
    }
    
    // Answer buttons
    
    @IBAction func answerOne(sender: UIButton) {
        checkIfCorrectAnswer(sender.currentTitle!, sender: sender)
    }
    @IBAction func answerTwo(sender: UIButton) {
        checkIfCorrectAnswer(sender.currentTitle!, sender: sender)
    }
    @IBAction func answerThree(sender: UIButton) {
        checkIfCorrectAnswer(sender.currentTitle!, sender: sender)
    }
    @IBAction func answerFour(sender: UIButton) {
        checkIfCorrectAnswer(sender.currentTitle!, sender: sender)
    }
    
    // Check if the answer is correct
    func checkIfCorrectAnswer(answer: String, sender: UIButton) {
        if (answer == correctAnswer) {
            print("\(answer) is correct!")
            for (index, button) in answerButtons.enumerate() {
                if (index != answerButtons.indexOf(sender)!) {
                    button.alpha = 0.0
                }
            }
            let delay = 1.5 * Double(NSEC_PER_SEC)
            // Start playback after delay
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay)), dispatch_get_main_queue(), {
              self.nextQuestion()
            })
        } else {
            print("\(answer) is wrong!")
            nextQuestion()
        }
        
    }
    
    // Generate an array with notes for this question
    func generateRandomQuestion(round: Int) {
        let notes = MusicLibrary().notes
        let firstNoteIndex = Int(arc4random_uniform(UInt32(notes.count)))
        let direction = Int(arc4random_uniform(UInt32(2)))
        var secondNoteIndex: Int = 1
        if (direction < 0 && firstNoteIndex <= notes.count) {
            secondNoteIndex = firstNoteIndex + Int(arc4random_uniform(UInt32(round + 1)))
        } else {
            secondNoteIndex = firstNoteIndex - Int(arc4random_uniform(UInt32(round + 1)))
        }
        if (secondNoteIndex < 0) { secondNoteIndex = 0 }
        notesToPlay = [Note(pitch: notes[firstNoteIndex]), Note(pitch: notes[secondNoteIndex])]
        correctAnswer = Interval(firstNote: notesToPlay[0].pitch, secondNote: notesToPlay[1].pitch).name
    }
    
    // Return an array with answers
    func createAnswers() -> [String] {
        let answer = correctAnswer
        let answerIndex = MusicLibrary().intervals.indexOf(answer)!
        var results = [answer]
        if (answerIndex < 4) {
            for _ in 1...3 {
                var intervalIndex = Int(arc4random_uniform(UInt32(answerIndex + 4)))
                var interval = MusicLibrary().intervals[intervalIndex]
                while (results.contains(interval)) {
                    intervalIndex = Int(arc4random_uniform(UInt32(answerIndex + 4)))
                    interval = MusicLibrary().intervals[intervalIndex]
                }
                results.append(interval)
            }
        } else {
            for _ in 1...3 {
                var intervalIndex = Int(arc4random_uniform(UInt32(7))) + answerIndex - 3
                var interval = MusicLibrary().intervals[intervalIndex]
                while (results.contains(interval)) {
                    intervalIndex = Int(arc4random_uniform(UInt32(7))) + answerIndex - 3
                    interval = MusicLibrary().intervals[intervalIndex]
                }
                results.append(interval)
            }
        }
        return results.shuffle()
    }
    
    // Play an interval
    func playInterval(firstNote: Note, secondNote: Note) {
        let firstNotePlayer: AVAudioPlayer!
        let secondNotePlayer: AVAudioPlayer!
        do {
            try firstNotePlayer = AVAudioPlayer(contentsOfURL: firstNote.audioFileURL(), fileTypeHint: nil)
            try secondNotePlayer = AVAudioPlayer(contentsOfURL: secondNote.audioFileURL(), fileTypeHint: nil)
            playNote(secondNotePlayer, start: 0.5, stop: 3, phase: 0.5)
            playNote(firstNotePlayer, start: 0.0, stop: 3, phase: 0.5)
        } catch {}
    }
    
    // Play a single note
    func playNote(player: AVAudioPlayer, start: Double, stop: Double, phase: Double) {
        let startTime = start * Double(NSEC_PER_SEC)
        let stopTime = stop * Double(NSEC_PER_SEC)
        // Start playback after delay
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(startTime)), dispatch_get_main_queue(), {
            player.stop()
            player.currentTime = phase
            player.play()
        })
        // Stop playback after delay
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(stopTime)), dispatch_get_main_queue(), {
            player.stop()
        })
    }
}

extension CollectionType {
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollectionType where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}

