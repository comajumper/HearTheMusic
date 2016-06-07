//
//  GameLogic.swift
//  HearTheMusic
//
//  Created by Dmitry Bykov on 04/06/16.
//  Copyright © 2016 Dmitry Bykov. All rights reserved.
//

import Foundation

class Game: NSObject {
    
    // Уровень сложности определяет этапность игры
    // Начинается всё с определения одной ноты, потом интервалы, а заканчивается сложными аккордами
    // По умолчанию начинаем с первого уровня (для теста с третьего — интервалы)
    var currentLevel: Int = 3
    
    // По умолчанию начинаем с первого раунда
    var currentRound: Int = 1
    
    // Количество раундов в уровне
    let roundsPerLevel: Int = 3
    
    // Текущий вопрос в раунде
    var currentQuestion: Int = 1
    
    // Количество вопросов в раунде
    let questionsPerRound: Int = 7
    
    // Словарь нот и интервалов
    let musicLibrary = MusicLibrary()
    
    // Хранилище правильного ответа
    var correctAnswer: Interval = Interval(firstNote: "C3", secondNote: "C3")

    // Варианты ответов
    var answers: [String] = []
    

    func start() {
        self.nextQuestion()
    }
    
    func generateInterval() -> Interval {
        let notes = MusicLibrary().notes
        let firstNoteIndex = Int(arc4random_uniform(UInt32(notes.count)))
        var secondNoteIndex: Int
        let direction = Int(arc4random_uniform(2))
        if (direction < 0) {
            secondNoteIndex = firstNoteIndex + Int(arc4random_uniform(UInt32(self.currentRound * 4)))
        } else {
            secondNoteIndex = firstNoteIndex - Int(arc4random_uniform(UInt32(self.currentRound * 4)))
        }
        if (secondNoteIndex > 12) {
            secondNoteIndex = secondNoteIndex - 12
        } else if (secondNoteIndex < 0) {
            secondNoteIndex = abs(secondNoteIndex)
        }
        let firstNote = Note(name: MusicLibrary().notes[firstNoteIndex])
        let secondNote = Note(name: MusicLibrary().notes[secondNoteIndex])
        return Interval(firstNote: firstNote.name, secondNote: secondNote.name)
    }
    
    // Создаем задание
    func nextQuestion() {
        if (self.currentQuestion > self.questionsPerRound) {
           print("Round \(self.currentRound) has ended!")
        } else {
            print("Question \(self.currentQuestion)")
            let question = generateInterval()
            self.correctAnswer = question
            self.answers = generateAnswers(question.name)
            print(self.answers)
            print(self.correctAnswer.name)
        }
        currentQuestion += 1
    }
    
    // Генерируем варианты ответов в случайном порядке
    func generateAnswers(correctAnswer: String) -> [String] {
        let answerIndex = MusicLibrary().intervals.indexOf(correctAnswer)!
        var results = [correctAnswer]
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
    
    // Проверить ответ
    func checkAnswer(answer: String) -> Bool {
        return answer == self.correctAnswer.name
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