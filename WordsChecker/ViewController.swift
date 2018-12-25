//
//  ViewController.swift
//  WordsChecker
//
//  Created by Kun Huang on 12/24/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func checkWords(_ sender: UIButton) {
        
        let userInput = inputText.text
        checkPossibleWords(of: userInput!)
        
    }
    
    func checkPossibleWords(of: String) {
        
        var wordArray = Array(of)
        var numberOfPossibleWord: [String] = []
        for _ in 0..<wordArray.count {
            let word = String(wordArray)
            let returnedWords = testWords(combinedWord: word)
            let removed = wordArray.removeFirst()
            wordArray.append(removed)
            print(word)
            //numberOfPossibleWord.append(contentsOf: returnedWords)
        }
        
        var finalWords = Set(numberOfPossibleWord)
        
        let filteredWords = finalWords.filter { $0.count <= of.count}
        
        for each in filteredWords {
            print(each)
        }
        //print(wordArray)
        
    }
    
    func testWords(combinedWord: String) -> [String]{
        
        var stringArray: [String] = []
        let textChecker = UITextChecker()
        
        let misspelledRange = textChecker.rangeOfMisspelledWord(in: combinedWord, range: NSRange(0..<combinedWord.utf16.count), startingAt: 0, wrap: false, language: "en_US")
        if misspelledRange.location != NSNotFound,
            let guesses = textChecker.guesses(forWordRange: misspelledRange, in: combinedWord, language: "en_US") {
            
            for each in guesses {
                stringArray.append(each)
            }
            
        }
        
        return stringArray
    }

}

