//
//  TableViewController.swift
//  MiniFacebook
//
//  Created by DEVG-ODI-2552 on 28/10/2019.
//  Copyright © 2019 AWS, Inc. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var userArray: NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let session = URLSession(configuration: .default)
        let urlUsers = URL(string: "https://jsonplaceholder.typicode.com/users")!
        let taskUsers = session.dataTask(with: urlUsers, completionHandler: { data, response, error in
            do {
                if let json:NSArray = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray {
                    self.userArray = json;
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
            
        })
        
        taskUsers.resume()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let count: Int = userArray?.count ?? 0
        return count;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "users", for: indexPath) as! TableViewCell
        if((userArray?.firstObject) != nil){
            if let name: String = (userArray?.object(at: indexPath.row) as AnyObject).value(forKey: "name") as? String {
                    cell.userNameLabel.text = "Name: " + name;
            }
            if let email: String = (userArray?.object(at: indexPath.row) as AnyObject).value(forKey: "email") as? String {
                    cell.userEmailLabel.text = "Email: " + email;
            }
            
        }
        
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150;
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            if let identifier = segue.identifier, identifier == "tab" {
                if let vc = segue.destination as? TabViewController{
                    if let data = self.userArray?.object(at: indexPath.row) as? NSObject{
                        (vc.viewControllers![0] as? ProfileViewController)?.data = data
                        (vc.viewControllers![1] as? PostsViewController)?.dataMain = data
                        (vc.viewControllers![2] as? AlbumCollectionViewController)?.dataMain = data
                    }
                }
            }
        }
        

    }
    
}
