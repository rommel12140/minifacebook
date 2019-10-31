//
//  AlbumCollectionViewController.swift
//  MiniFacebook
//
//  Created by DEVG-ODI-2552 on 29/10/2019.
//  Copyright © 2019 AWS, Inc. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class AlbumCollectionViewController: UICollectionViewController {
    var dataMain: NSObject?
    var imageCollectionArray: NSMutableArray = NSMutableArray()
    var photosArray: NSMutableArray = NSMutableArray()
    var albumsArray: NSMutableArray = NSMutableArray()
    var id: NSMutableArray = NSMutableArray()
    var albumPhotos = [String: NSMutableArray]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let session = URLSession(configuration: .default)
        let urlAlbums = URL(string: "https://jsonplaceholder.typicode.com/albums")!
        let taskAlbum = session.dataTask(with: urlAlbums, completionHandler: { data, response, error in
            do {
                if let json:NSArray = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray {
                    for album in json{
                        if let object = album as? AnyObject, let userid = object.value(forKey: "userId") as? Int, userid == self.dataMain?.value(forKey: "id") as? Int{
                            self.id.add(object.value(forKey: "id") as? Int);
                            self.imageCollectionArray.add(album)
                        }
                    }
                }
                
                let urlPhotos = URL(string: "https://jsonplaceholder.typicode.com/photos")!
                let taskPhotos = session.dataTask(with: urlPhotos, completionHandler: { data, response, error in
                    do {
                        if let json:NSArray = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray {
                            for photo in json{
                                if let object = photo as? AnyObject{
                                    if let albumid = object.value(forKey: "albumId") as? Int, self.id.contains(albumid){
                                        if let album = self.albumPhotos["\(albumid)"]{
                                            album.add(photo)
                                        }else{
                                            self.albumPhotos["\(albumid)"] = NSMutableArray(object: photo)
                                        }
                                    }
                                
                                }
                            }
                        }
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                        
                    } catch {
                        print("JSON error: \(error.localizedDescription)")
                    }
                    
                })
                taskPhotos.resume()
                
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
            
        })
        
        taskAlbum.resume()
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.id.count;
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AlbumCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "albums", for: indexPath) as! AlbumCollectionViewCell
        
        if let photoId = self.id.object(at: indexPath.row) as? Int , let first = self.albumPhotos["\(photoId)"]?.firstObject as? AnyObject, let url = URL(string: first.value(forKey: "url") as! String) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let image = UIImage(data: data!){
                        cell.albumImage.image = image
                    }
                }
            }

        }
        // Configure the cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  500
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selected = collectionView.indexPathsForSelectedItems{
            if let identifier = segue.identifier, identifier == "photos" {
                if let vc = segue.destination as? PhotosViewController{
                    if let selectedIndex = selected.first?.row{
                        if let array = albumPhotos["\(selectedIndex + 1)"]{
                            vc.imageArray = array
                        }
                    }
                }
            }
        }
    }

}
