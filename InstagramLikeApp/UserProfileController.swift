//
//  UserProfileController.swift
//  InstagramLikeApp
//
//  Created by eric yu on 4/7/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import UIKit
import Firebase
/*
struct User {
    let username: String
    let profileImageUrl: String
    
    init(dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"]  as? String ?? ""
    }
}*/

class UserProfileController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    let reuseIdentifier = "cell"
    let headerIdentifier = "hcell"
    let minimumSpacing:CGFloat = 1
    var user: User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier )
        
        collectionView?.backgroundColor = .white
        
        
        navigationItem.title = FIRAuth.auth()?.currentUser?.uid
        fetchUser()
        
     
        
        setupLogoutButton()
    
    }
    


    fileprivate func setupLogoutButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLogOut))
    
       
    }
    
    func handleLogOut() {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { (_) in
            print("perfrom Log out")
        }))
        
        alertController.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
        
        do {
            try FIRAuth.auth()?.signOut()
        } catch let signOutErr {
            print("Failed to sign out:", signOutErr)
        }
    
        
    }






    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 17
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumSpacing
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.width - 2 * minimumSpacing) / 3
        
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! UserProfileHeader
     
        header.user = self.user
        
        return header
    }
    
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        
        return CGSize(width: view.frame.width, height: 200)
        
    }
    
    fileprivate func fetchUser() {
        
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {return}
        FIRDatabase.database().reference().child("user").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            
            self.user = User(dictionary: dictionary)
            
            /*
            let value = snapshot.value as? NSDictionary
            
            
            let username = value?["username"] as? String ?? ""
            let user1 = User.init(dictionary: username)*/
            
            
            
            self.navigationItem.title = self.user?.username
    
            
            self.collectionView?.reloadData()
            
        
            
        }) { (err ) in
            print("faile to fetch user:", err)
        }
    }
}



