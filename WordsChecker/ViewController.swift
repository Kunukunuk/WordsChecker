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
    var allPossibleWords = Set<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func checkWords(_ sender: UIButton) {
        
        let userInput = inputText.text
        let characterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        
        if userInput == "" {
            createAlert(errorCode: 2)
        } else if userInput?.rangeOfCharacter(from: characterSet.inverted) != nil {
            createAlert(errorCode: 1)
        } else if (userInput?.count)! >= 1 {
            createAlert(errorCode: 2)
        } else {
            checkPossibleWords(of: userInput!)
            
            performSegue(withIdentifier: "displayPossibleWords", sender: nil)
        }
        
    }
    
    func createAlert(errorCode: Int) {
        
        if errorCode == 1 {
            let alert = UIAlertController(title: "Invalid Input", message: "The string you inputed contains non English alphabet characters", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        } else if errorCode == 2 {
            let alert = UIAlertController(title: "Invalid Length", message: "The string you inputed is too short to form a word", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
    }
    func checkPossibleWords(of: String) {
        
        var wordArray = Array(of)
        var permutationWords = Array<String>()
        
        permutations(size: wordArray.count, charArray: &wordArray, possibleArray: &permutationWords)
        
        for each in permutationWords {
            let array = getPossibleWords(combinedWord: each)
            allPossibleWords = allPossibleWords.union(array)
        }
        
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
    
    func getPossibleWords(combinedWord: String) -> [String]{
        
        var stringArray: [String] = []
        let textChecker = UITextChecker()
        let originalCharArray = Array(combinedWord).sorted()
        
        let misspelledRange = textChecker.rangeOfMisspelledWord(in: combinedWord, range: NSRange(0..<combinedWord.utf16.count), startingAt: 0, wrap: false, language: "en_US")
        if misspelledRange.location != NSNotFound,
            let guesses = textChecker.guesses(forWordRange: misspelledRange, in: combinedWord, language: "en_US") {
            
            for each in guesses {
                let eachCharArray = Array(each).sorted()
                if each.count <= combinedWord.count && originalCharArray == eachCharArray{
                    stringArray.append(each)
                }
            }
            
        }
        
        return stringArray
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "displayPossibleWords" {
            let destinationVC = segue.destination as! DisplayTableViewController
            destinationVC.possibleSetOfWords = Array(allPossibleWords)
        }
    }
}

