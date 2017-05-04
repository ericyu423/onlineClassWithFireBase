//
//  MainTabBarController.swift
//  InstagramLikeApp
//
//  Created by eric yu on 4/7/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if FIRAuth.auth()?.currentUser == nil{
            
            DispatchQueue.main.async {
           //wait for maintap controller
                //to be setup
                //so you can add the window into the view
                
                let loginController = LoginController()
  
                
                let navController = UINavigationController(rootViewController: loginController)
                
                 self.present(navController, animated: true, completion: nil)
                
                //self.present(loginController, animated: true, completion: nil)
            }
            
            return
            
        }
        
        
        
        view.backgroundColor = .blue
  
        
        let layout = UICollectionViewFlowLayout()
        
        //'UICollectionView must be initialized with a non-nil layout parameter'
        let userProfileController = UserProfileController(collectionViewLayout: layout)

        let navController = UINavigationController(rootViewController: userProfileController)
        
         navController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
         navController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        
        tabBar.tintColor = .black
    
         viewControllers = [navController, UIViewController()]
        
        
        
    }

}
