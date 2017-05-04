//
//  ViewController.swift
//  InstagramLikeApp
//
//  Created by eric yu on 4/4/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import GoogleSignIn
import TwitterKit

class SignUpController: UIViewController,FBSDKLoginButtonDelegate,GIDSignInUIDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var twitterButton = TWTRLogInButton()
    
    lazy var googleButton:GIDSignInButton = {
        let button = GIDSignInButton()
        GIDSignIn.sharedInstance().uiDelegate = self
        return button
    }()
    
    lazy var cgoogleButton:UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .orange
        button.setTitle("Custom Button", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        button.addTarget(self , action: #selector(handleCustomGoogleLogin), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        
        
        
        
        return button
    }()

    lazy var facebookButton:FBSDKLoginButton = {
        let button = FBSDKLoginButton()
       
        button.readPermissions = ["email", "public_profile"]
        button.delegate = self
        
        return button
    }()
    
    lazy var cfacebookButton:UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.setTitle("Custom Button", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
       
        button.addTarget(self , action: #selector(handleCustomFBLogin), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        
        
        
        return button
    }()
    
  
    
    func handleCustomFBLogin(){
        FBSDKLoginManager().logIn(withReadPermissions: ["email","public_profile"], from: self) { (result, err) in
            if err != nil {
                print("Custom FB Login failed:", err!)
                return
            }
            
            self.showEmailAddress()
            //print(result?.token.tokenString as Any)
        }
        
    }
    
    func handleCustomGoogleLogin(){

        GIDSignIn.sharedInstance().signIn()
        
        /* sign out
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }*/
        
        
        
    }
    
    fileprivate func steupTwitterButton(){
        twitterButton = TWTRLogInButton { (session, error) in
            if let err = error {
                print("Faield to login via Twitter: ",err)
            }
            
            print("Successfully logged in under Twitter...")
     
        
        guard let token = session?.authToken else {return}
        guard let secret = session?.authTokenSecret else {return}
        
        let credentials = FIRTwitterAuthProvider.credential(withToken: token, secret: secret)
        
        
        FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
            
            if let err = error {
                print("Failed to login to Firebase with Twitter: ", err)
                return
            }
            
            print("Successfully created a Firebase-Twitter user: ", user?.uid ?? "")
        })
        
        }
    
        
    }
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of facebook")
        
        
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        
        
        if error != nil {
            print(error)
            return
        }
        
        print("Successfully logged in with facebook...")
        
        showEmailAddress()
        
    }
    
    func showEmailAddress(){
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else {return}
        
        let credentials = FIRFacebookAuthProvider.credential(withAccessToken: accessTokenString)
        
        FIRAuth.auth()?.signIn(with:credentials, completion: { (user, err) in
            if err != nil {
                print("something wrong with out FB user: ", err ?? "")
            }
            print("successfully logged in with our user: ", user ?? "")
        })
        
   
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields":"id, name, email"]).start { (connection, result,
            err) in
            if err != nil {
                print("Failed to start graph request:", err ?? "")
                return
            }
            
            print(result ?? "")
            
        }
        

    }
    
    let iconButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "addPhoto").withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
        
        return button
    }()
    
    let emailTextField: UITextField = { (placeholderName: String)  in
        let textField = UITextField()
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.placeholder = placeholderName
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        
        return textField
    }("Email")
    
    let usernameTextField: UITextField = { (placeholderName: String) in
        let textField = UITextField()
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.placeholder = placeholderName
        textField.borderStyle = .roundedRect
        textField.addTarget(self , action: #selector(handleTextChange), for: .editingChanged)
        return textField
    }("Username")
    
    let passwordTextField: UITextField = { (placeholderName: String) in
        let textField = UITextField()
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.placeholder = placeholderName
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.addTarget(self , action: #selector(handleTextChange), for: .editingChanged)
        return textField
    }("Password")
    
    let signupButton: UIButton = { (title: String) in
        let button = UIButton(type: .system)
        
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 255)
 
        button.setTitle(title, for: .normal)
        
        button.setTitleColor(.white, for: .normal)
        
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    
        button.isEnabled = false
        button.layer.cornerRadius = 4
        
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        
        return button
    
    }("Login/Register")
    
    func handlePlusPhoto(){
        let imagePickerController = UIImagePickerController()
        present(imagePickerController, animated: true, completion: nil)
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            iconButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
            
        }else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            iconButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        iconButton.layer.cornerRadius = iconButton.frame.width/2
        iconButton.layer.masksToBounds = true
        iconButton.layer.borderColor = UIColor.black.cgColor
        iconButton.layer.borderWidth = 3
        
        
        dismiss(animated: true, completion: nil)
       
        
        
    }
    
    func handleSignup() {
        //sign up manually - not using facebook/google/twitter
        
        guard let email = emailTextField.text, email.characters.count > 0 else { return}
        
        guard let username = usernameTextField.text, username.characters.count > 0 else {return}
        
        guard let password = passwordTextField.text, password.characters.count > 0 else {return}
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?,error: Error?) in
            
            if let err = error {
                print("Failed to create user:",err)
                return
            }
            
            print("Successfully created user:",user?.uid ?? "")
        
            
            guard let image = self.iconButton.imageView?.image else { return }
            
            guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else {return}
            
            let filename = NSUUID().uuidString
            
        FIRStorage.storage().reference().child("profile_image").child("profile_image").child(filename).put(uploadData, metadata: nil, completion: { (metadata, err ) in
            
            if let err = err {
                print("Failed to upload profile image: ",err)
                return
            }
            
            guard let profileImageUrl = metadata?.downloadURL()?.absoluteString else { return }
            
            print("Successfully uploaded profile image:",profileImageUrl)
            
    
            guard let uid = user?.uid else {return}
            let dictionaryValues = ["username":username, "profileImageUrl":profileImageUrl]
            let value = [uid: dictionaryValues]

        FIRDatabase.database().reference().child("users").updateChildValues(value, withCompletionBlock: { (err , ref) in
                
                if let err = err {
                    print("failed to save user info into db: ", err)
                    return
                }
                
                print("Successfully save uer info to db")
                
            })  

        })  
            
            
        })
        
        
        
    }
    func handleTextChange(){
        
        let isFormValid = emailTextField.text?.characters.count ?? 0 > 0 && usernameTextField.text?.characters.count ?? 0 > 0 && passwordTextField.text?.characters.count ?? 0 > 0
        
        if isFormValid {
            signupButton.isEnabled = true
            signupButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        }else{
            
            signupButton.isEnabled = false
            signupButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 255)
        }

        
    }
    
    
      override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        DispatchQueue.global(qos: .userInteractive).async {
            //do this asyn don't wait 
            DispatchQueue.main.async {
                //keep doing this on
            }
            
        }
        
        steupTwitterButton()
       //google sign in
       // GIDSignIn.sharedInstance().uiDelegate = self
        
        view.addSubview(iconButton)
        
       NSLayoutConstraint.activate([
            iconButton.heightAnchor.constraint(equalToConstant: 140),
            iconButton.widthAnchor.constraint(equalToConstant: 140),
            iconButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            iconButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        setupInputView()
    }
    
    func setupInputView(){
    
        let stackView = UIStackView(arrangedSubviews: [emailTextField,usernameTextField,passwordTextField,signupButton,facebookButton,googleButton,twitterButton])
        
        stackView.spacing = 4
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 350),
            stackView.topAnchor.constraint(equalTo: iconButton.bottomAnchor, constant: 40),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40)
        ])
        
        
        
        
        
    }
    
    
 
}

