//
//  Extensions.swift
//  InstagramLikeApp
//
//  Created by eric yu on 4/4/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import UIKit

extension UIColor {
    
    //without static you can't do this -> UIColor.rgb
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}


extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
}

extension String {
    public var isEmail: Bool {
        let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let firstMatch = dataDetector?.firstMatch(in: self, options: .reportCompletion, range: NSRange(location: 0, length: length))
        return (firstMatch?.range.location != NSNotFound && firstMatch?.url?.scheme == "mailto")
    }
    
    public var length: IndexDistance {
        return self.characters.count
    }
}

/*
@objc func handleTextInputChange(_ sender: UITextField){
    
    guard let email = emailTextField.text, let username = usernameTextField.text, let password = passwordTextField.text else { return }
    
    let isEmailValid = email.isEmail // valid email syntax?
    let isUsernameValid = username.length > 0 // length is same as characters.count
    let isPasswordValid = password.length > 0
    
    let isFormValid = isEmailValid && isUsernameValid && isPasswordValid
    
    signUpButton.isEnabled = isFormValid
    
    signUpButton.backgroundColor = signUpButton.isEnabled ? UIColor(r: 17, g: 154, b: 237) : UIColor(r: 149, g: 204, b: 244)
}*/



