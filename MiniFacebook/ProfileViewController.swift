//
//  ProfileViewController.swift
//  MiniFacebook
//
//  Created by DEVG-ODI-2552 on 28/10/2019.
//  Copyright © 2019 AWS, Inc. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileUsernameLabel: UILabel!
    @IBOutlet weak var profileEmailLabel: UILabel!
    @IBOutlet weak var profilePhoneLabel: UILabel!
    @IBOutlet weak var profileWebsiteLabel: UILabel!
    var data:NSObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(data?.value(forKey: "id") != nil){
            if let name: String = data?.value(forKey: "name") as? String {
                profileNameLabel.text = "Name: " + name
            }
            if let username: String = data?.value(forKey: "username") as? String {
                profileUsernameLabel.text = "Username: " + username
            }
            if let email: String = data?.value(forKey: "email") as? String {
                profileEmailLabel.text = "Email: " + email
            }
            if let phone: String = data?.value(forKey: "phone") as? String {
                profilePhoneLabel.text = "Phone: " + phone
            }
            if let website: String = data?.value(forKey: "website") as? String {
                profileWebsiteLabel.text = "Website: " + website
            }
            profileImage.layer.cornerRadius = 150;

        }
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}