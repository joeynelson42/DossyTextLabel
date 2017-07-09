//
//  DossyText.swift
//  DossyText
//
//  Created by Joey Nelson on 7/9/17.
//  Copyright © 2017 NelsonJE. All rights reserved.
//

import UIKit

@objc
public protocol DossyTextLabelDelegate {
    @objc optional func DossyTextLabel(_ label: DossyTextLabel, didFinishTypingText text: String)
    @objc optional func didFinishBlinking(_ label: DossyTextLabel)
}

open class DossyTextLabel: UILabel {
    
    private enum LabelState {
        case typing
        case blinking
        case idle
    }
    
    // MARK: - Properties
    
    //Public
    public var delegate: DossyTextLabelDelegate?
    public var blinksWhileIdle: Bool = true
    public var millisecondsPerLetter = 70
    
    // Private
    private var state: LabelState = .idle
    private var mostRecentAddition: String = ""
    private var currentText: String = ""
    private var fullText: String = ""
    private var blinkingText: String = ""
    private var blinking = false
    private var timer: Timer!
    
    // MARK: - Blinking
    public func blinkIndefinitely() {
        state = .blinking
        
        blink()
        
        blinking = true
    }
    
    public func blink(forInterval interval: TimeInterval) {
        blinkIndefinitely()
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(stopBlinking), userInfo: nil, repeats: false)
    }
    
    private func blink(_ repeats: Bool = true) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250)) {
            if self.text == self.blinkingText {
                self.text = "\(self.blinkingText)█"
            } else {
                self.text = self.blinkingText
            }
            
            if self.state == .blinking && repeats {
                self.blink()
            } else {
                self.delegate?.didFinishBlinking?(self)
            }
        }
    }
    
    public func stopBlinking() {
        state = .idle
    }
    
    
    // MARK: - Typing
    public func type(_ stringToType: String) {
        state = .typing
        mostRecentAddition = stringToType
        fullText = "\(fullText)\(stringToType)"
        type()
    }
    
    private func type() {
        if fullText == currentText {
            typingEnded()
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(millisecondsPerLetter)) {
            let stripped = self.fullText.replacingOccurrences(of: self.currentText, with: "")
            guard let char = stripped.characters.first else { return }
            self.currentText = self.currentText + String(describing: char)
            self.text = self.currentText
            self.type()
        }
    }
    
    private func typingEnded() {
        blinkingText = fullText
        
        if blinksWhileIdle {
            blinkIndefinitely()
        } else {
            state = .idle
        }
        
        delegate?.DossyTextLabel?(self, didFinishTypingText: mostRecentAddition)
    }
    
    // MARK: - Idling
    public func idle(){
        stopBlinking()
        text = fullText
        state = .idle
    }
}

