//
//  mViewController.swift
//  InstagramLikeApp
//
//  Created by eric yu on 4/4/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import UIKit
import Firebase

class mViewController: UIViewController {
    
    let imageButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "addPhoto").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        
        //button disable unless all field have characters
        
        textField.addTarget(self, action: #selector(handleTextInputChnage), for: .editingChanged)
        
        return textField
    }()

    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
    
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        
        //button disable unless all field have characters
        
        textField.addTarget(self, action: #selector(handleTextInputChnage), for: .editingChanged)
        
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        
        //button disable unless all field have characters
        
        textField.addTarget(self, action: #selector(handleTextInputChnage), for: .editingChanged)
        
        return textField
        
    }()
    
    
    let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 255/255, alpha: 1)
        
        
        
        button.layer.cornerRadius = 5
        
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        //button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: UIFontWeightBold)
        
      button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        
        return button
        
    }()
    
    func handleSignUp(){
        guard let email = emailTextField.text, email.characters.count > 0 else { return}
        guard let username = usernameTextField.text, username.characters.count > 0 else {return}
        guard let password = passwordTextField.text, password.characters.count > 0 else {return}
        

        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error: Error?) in
            
            if let err = error {
                print("Failed to create user:",err)
                return
            }
            
            print("Successfully created user:",user?.uid ?? "")
        })
    }
    

    func handleTextInputChnage(){
        
        let isFormValid = emailTextField.text?.characters.count ?? 0 > 0 && usernameTextField.text?.characters.count ?? 0 > 0 && passwordTextField.text?.characters.count ?? 0 > 0
        
        if isFormValid {
             signupButton.isEnabled = true
            signupButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        }else{
             signupButton.isEnabled = false
            signupButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 245)
        }
    }
   
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        view.addSubview(imageButton)
        imageButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
        
        imageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
      
        setupInputField()

    }
    
    fileprivate func setupInputField(){
        
        let testView = UIView()
        testView.backgroundColor = .red
        let stackView = UIStackView(arrangedSubviews: [emailTextField,usernameTextField,passwordTextField,signupButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
    
        view.addSubview(stackView)
        
        stackView.anchor(top: imageButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 200)
      
        

    }
}

