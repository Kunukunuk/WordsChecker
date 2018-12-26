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
        var possibleWords = Array<String>()
        
        permutations(size: wordArray.count, charArray: &wordArray, possibleArray: &possibleWords)
        
        print(possibleWords)
        
    }
    
    func permutations(size: Int, charArray: inout Array<Character>, possibleArray: inout Array<String>){
        
        if size == 1 {
            let word = String(charArray)
            possibleArray.append(word)
            return
        }
        
        for index in 0..<size-1 {
            permutations(size: size - 1, charArray: &charArray, possibleArray: &possibleArray)
            charArray.swapAt(size-1, (size%2==1) ? 0:index)
        }
        permutations(size: size-1, charArray: &charArray, possibleArray: &possibleArray)
        
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

