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
    
    // MARK: - Properties
    
    //Public
    public var delegate: DossyTextLabelDelegate?
    
    /// Upon finishing typing the blinking box will (or will not) begin blinking automatically
    public var blinksWhileIdle: Bool = true
    
    /// Adjusts the speed of the typing, 70 is a good place to start
    public var millisecondsPerLetter = 70
    
    // Private
    private enum LabelState {
        case typing
        case blinking
        case idle
    }
    
    private var state: LabelState = .idle
    private var mostRecentAddition: String = ""
    private var currentText: String = ""
    private var fullText: String = ""
    private var blinkingText: String = ""
    private var blinking = false
    private var timer: Timer!
    
    // MARK: - Blinking
    
    /// Will begin the blinking box and won't stop until stopBlinking() is called
    public func blinkIndefinitely() {
        state = .blinking
        blink()
        blinking = true
    }
    
    
    /**
     Blinks the blnking box for specified TimeInterval.
     - Parameter interval:   The specified interval.
     */
    public func blink(forInterval interval: TimeInterval) {
        blinkIndefinitely()
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(stopBlinking), userInfo: nil, repeats: false)
    }
    
    /**
     Blinks the blnking box recursively.
     - Parameter repeats: If enabled the blinking will blink indefinitely.
     */
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
    
    /// Will force the blinking box to stop blinking
    public func stopBlinking() {
        state = .idle
    }
    
    
    // MARK: - Typing
    
    /**
     Types out a given string
     - Parameter stringToType: The given string to be typed out.
     */
    public func type(_ stringToType: String) {
        state = .typing
        mostRecentAddition = stringToType
        fullText = "\(fullText)\(stringToType)"
        type()
    }
    
    /// Calculates and types out the next character to match currentText to fullText, upon typing out all of fullText the recursion will end.
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
    
    /// Called when the typing animation has ended.
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
    
    /// Brings everything to a halt.
    public func idle(){
        stopBlinking()
        text = fullText
        state = .idle
    }
}

