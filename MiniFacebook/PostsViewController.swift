//
//  PostsViewController.swift
//  MiniFacebook
//
//  Created by DEVG-ODI-2552 on 29/10/2019.
//  Copyright © 2019 AWS, Inc. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    var postsArray: NSMutableArray = NSMutableArray()
    var dataMain: NSObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let session = URLSession(configuration: .default)
        let urlPosts = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        let taskPosts = session.dataTask(with: urlPosts, completionHandler: { data, response, error in
            do {
                if let json:NSArray = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray {
                    for post in json{
                        if let object = post as? AnyObject, let userid = object.value(forKey: "userId") as? Int, userid == self.dataMain?.value(forKey: "id") as? Int{
                            self.postsArray.add(post)
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
            
        })
        if let name = dataMain?.value(forKey: "name") as? String{
                nameLabel.text = name
        }
        taskPosts.resume()
        
        
        
        // Do any additional setup after loading the view.
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postsArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "posts", for: indexPath) as! PostsTableViewCell
        
        if let postTitle = ((postsArray.object(at: indexPath.row)) as AnyObject).value(forKey: "title") as? String{
                cell.postLabel.text = postTitle
        }
        if let postBody = ((postsArray.object(at: indexPath.row)) as AnyObject).value(forKey: "body") as? String{
            cell.bodyLabel.text = postBody
        }
        
        
        // Configure the cell...
        
        return cell
    }
    


}
