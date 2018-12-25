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
        for index in 0..<wordArray.count {
            let word = String(wordArray)
            let removed = wordArray.removeFirst()
            wordArray.append(removed)
            print(word)
        }
        
        //print(wordArray)
        
    }
    
    func testWords(combinedWord: String) -> [String]{
        
        var stringArray: [String] = []
        let str = "elloh"
        let textChecker = UITextChecker()
        
        let misspelledRange = textChecker.rangeOfMisspelledWord(in: str, range: NSRange(0..<str.utf16.count), startingAt: 0, wrap: false, language: "en_US")
        if misspelledRange.location != NSNotFound,
            let guesses = textChecker.guesses(forWordRange: misspelledRange, in: str, language: "en_US") {
            
            for each in guesses {
                print(each)
            }
            
        }
        
        return stringArray
    }

}

