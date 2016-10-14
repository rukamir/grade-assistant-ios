//
//  PlaybackViewController.swift
//  Roland Grading Assistant
//
//  Created by Jimmy Roland on 10/6/16.
//  Copyright © 2016 Jimmy Roland. All rights reserved.
//

import UIKit
import AVFoundation

class PlaybackViewController: UIViewController, AVSpeechSynthesizerDelegate {
    // MARK: Properties
    let synth = AVSpeechSynthesizer()
    var speed = AVSpeechUtterance()
    var allSpeech: [AVSpeechUtterance] = []
    var collection: Collection
    var currentUtterance = 0
    @IBOutlet weak var textDisplay: UILabel!
    @IBOutlet weak var delaySlider: UISlider!
    @IBOutlet weak var playButton: UIButton!
    var playbackStopped = false
    
    // MARK: Inits
    required init?(coder aDecoder: NSCoder) {
        collection = Collection(name: "", answers: [""])
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        synth.delegate = self
        loadCollectionToUtterance()
        
        navigationItem.title = collection.name
        textDisplay.text = allSpeech[currentUtterance].speechString
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        synth.pauseSpeaking(at: .immediate)
    }
    
    // MARK: Play controls
    @IBAction func playButtonPressed(_ sender: UIButton) {
        playbackStopped = false
        if synth.isPaused {
            synth.continueSpeaking()
        } else {
            playButton.isEnabled = false
            synth.speak(allSpeech[currentUtterance])
        }
    }
    
    @IBAction func pauseButtonPressed(_ sender: UIButton) {
        synth.pauseSpeaking(at: .immediate)
        playButton.isEnabled = true
    }
    
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        
        let stopped = synth.stopSpeaking(at: .immediate)
        if !stopped {
            synth.stopSpeaking(at: .immediate)
        }
        playbackStopped = true
        playButton.isEnabled = true
        textDisplay.text = allSpeech[0].speechString
    }
    
    // MARK: Synth controls
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("at did finish")
        currentUtterance += 1
        
        if allSpeech.count > currentUtterance {
            if !playbackStopped {
                textDisplay.text = allSpeech[currentUtterance].speechString
                allSpeech[currentUtterance].postUtteranceDelay = TimeInterval(delaySlider.value)
                synth.speak(allSpeech[currentUtterance])
            } else {
                currentUtterance = 0
            }
        } else {
            currentUtterance = 0
        }
    }
    
    // MARK: handle collection
    func loadCollectionToUtterance() {
        var utterString: String
        
        for i in 0..<collection.answers.count {
            utterString = String(i+1) + " " + collection.answers[i]
            print(utterString)
            
            var theUtter = AVSpeechUtterance(string: utterString)
            theUtter.postUtteranceDelay = TimeInterval(1.0)
            
            allSpeech += [theUtter]
        }
    }
}
