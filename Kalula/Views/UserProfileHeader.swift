//
//  UserProfileHeader.swift
//  Kalula
//
//  Created by Christopher Brandon Karani on 10/01/2018.
//  Copyright © 2018 Christopher Brandon Karani. All rights reserved.
//

import UIKit
import Sukari
import SnapKit
import Firebase
import Toaster
class UserProfileHeader: UICollectionViewCell {
    
    let imageView = UIImageView().this {
        $0.backgroundColor = .magenta
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 40 // half of the width
    }
    
    fileprivate func setupViews() {
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.left.equalTo(snp.left).offset(20)
            $0.top.equalTo(snp.top).offset(20)
            $0.width.equalTo(80)
            $0.height.equalTo(80)
        }
    }
    
    fileprivate func fetchProfilePhotoImage() {
        let uid = Auth.auth().currentUser.unwrap(debug: "No Current User").uid
        let ref = Database.database().reference().child("users").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else {
                return
            }
            guard let profileImageUrl = dictionary["profileImageUrl"] as? String else {
                Toast(text: "An Error Occurred when Accessing Firebase Database: profileUrl").show()
                return
            }
            let task = URLSession.shared.dataTask(with: profileImageUrl) { (data, response, error) in
                if let error = error {
                    Toast(text: error.localizedDescription)
                }
            }.resume()
            
            
        }) { (error) in
            Toast(text: error.localizedDescription).show()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        fetchProfilePhotoImage()

    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


