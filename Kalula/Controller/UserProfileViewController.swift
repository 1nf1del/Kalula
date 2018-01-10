//
//  UserProfileViewController.swift
//  Kalula
//
//  Created by Christopher Brandon Karani on 09/01/2018.
//  Copyright © 2018 Christopher Brandon Karani. All rights reserved.
//

import UIKit
import Firebase
import Toaster

class UserProfileViewController: UICollectionViewController {
    
    let headerID : String = "HeaderID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        fetchUser()
        registerCells()
    }
    
    fileprivate func registerCells() {
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID)
    }
    
    fileprivate func fetchUser() {
        let uid = Auth.auth().currentUser.unwrap(debug: "No Current User").uid
        let ref = Database.database().reference().child("users").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else {
                return
            }
            
            let name = dictionary["username"] as? String
            self.navigationItem.title = name.unwrap()
            
        }) { (error) in
            Toast(text: error.localizedDescription).show()
        }
    }
}

extension UserProfileViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
}

extension UserProfileViewController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID, for: indexPath)
        
        return header
    }
}
