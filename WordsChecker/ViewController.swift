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
        testWords()
    }
    
    @IBAction func checkWords(_ sender: UIButton) {
    }
    
    func testWords() {
        var correctStr : String = String()
        let str = "elloh"
        let textChecker = UITextChecker()
        
        let misspelledRange = textChecker.rangeOfMisspelledWord(in: str, range: NSRange(0..<str.utf16.count), startingAt: 0, wrap: false, language: "en_US")
        if misspelledRange.location != NSNotFound,
            let guesses = textChecker.guesses(forWordRange: misspelledRange, in: str, language: "en_US") {
            
            for each in guesses {
                print(each)
            }
            
        }
        
        //print(correctStr)
    }

}

