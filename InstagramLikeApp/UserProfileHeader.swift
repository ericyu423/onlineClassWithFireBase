//
//  UserProfileHeader.swift
//  InstagramLikeApp
//
//  Created by eric yu on 4/7/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import UIKit
import Firebase

class UserProfileHeader: UICollectionReusableView {
    
    
    var user: User? {
        didSet {
            setupProfileImage()
            usernameLabel.text = user?.username
        }
    }
    
    let gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
       
        return button
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 80 / 2
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    
    let postsLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: [NSFontAttributeName:UIFont.boldSystemFont(ofSize: 14)])

        attributedText.append(NSAttributedString(string: "posts", attributes: [NSForegroundColorAttributeName: UIColor.lightGray, NSFontAttributeName: UIFont.systemFont(ofSize: 14)]))
        

        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let followersLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: [NSFontAttributeName:UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: "followers", attributes: [NSForegroundColorAttributeName: UIColor.lightGray, NSFontAttributeName: UIFont.systemFont(ofSize: 14)]))
        
        
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: [NSFontAttributeName:UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: "following", attributes: [NSForegroundColorAttributeName: UIColor.lightGray, NSFontAttributeName: UIFont.systemFont(ofSize: 14)]))
        
        
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
        return button
    }()
    
    
    
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
      
        addSubview(profileImageView)
        
        setupBottomToolbar()
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            ])
        
        addSubview(usernameLabel)
        
        NSLayoutConstraint.activate([

              usernameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 4),
            
                usernameLabel.bottomAnchor.constraint(equalTo: gridButton.topAnchor,constant: 0),
                
                usernameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
                
                usernameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 12)
            
        ])
        
        setupUserStatsView()
        
        addSubview(editProfileButton)
        editProfileButton.anchor(top: postsLabel.bottomAnchor, left: postsLabel.leftAnchor, bottom: nil, right: followingLabel.rightAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 34)

    
    }
    

    
    fileprivate func setupUserStatsView(){
        
        let stackView = UIStackView(arrangedSubviews: [postsLabel,followersLabel,followingLabel])
        
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 50)
        
        
        
    }
    
    fileprivate func setupBottomToolbar(){
        let stackView = UIStackView(arrangedSubviews: [gridButton,listButton, bookmarkButton])
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        
        
        NSLayoutConstraint.activate([
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
       
      
                // Add a thin light gray line to the top and bottom of the stack view
        [stackView.topAnchor, stackView.bottomAnchor].forEach {
                    let l = UIView()
                    self.addSubview(l)
                    l.backgroundColor = .lightGray
            
                    l.anchor(top: $0, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        }
        
        
     
    }

    fileprivate func setupProfileImage(){
        
        
        
        guard let profileImageUrl = user?.profileImageUrl else { return }
        
        guard let url = URL(string: profileImageUrl) else { return }
        
        
        URLSession.shared.dataTask(with: url) { (data, response, err ) in
            
            if let err = err {
                print ("failed to fetch profile image ")
            }
            
            //perhpas check for response status of 200 (sttp ok)
            
//MARK: check statusCode 200
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { print(response.debugDescription); return }
            
            
            guard let data = data else { return }
            
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
            
            
            }.resume()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
