//
//  LoginController.swift
//  InstagramLikeApp
//
//  Created by eric yu on 4/11/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Don't have an account? Sign up.", for: .normal)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    func handleSignUp()
    {
        
        let signUpController = SignUpController()
        navigationController?.pushViewController(signUpController, animated: true)
        
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         navigationController?.isNavigationBarHidden = true

       view.backgroundColor = .white
        view.addSubview(signUpButton)
        signUpButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    }

  }
