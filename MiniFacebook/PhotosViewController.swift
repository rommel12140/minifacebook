//
//  PhotosViewController.swift
//  MiniFacebook
//
//  Created by Rommel Gallofin on 31/10/2019.
//  Copyright © 2019 AWS, Inc. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UIScrollViewDelegate {
    var imageArray: NSArray = NSArray()
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    var slides:[Slide] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        
        // Do any additional setup after loading the view.
    }
    
    func createSlides() -> [Slide] {
        var createSlidesArray: [Slide] = []
        for count in 0..<imageArray.count{
            createSlidesArray.append(Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide)
            if let url = URL(string: (imageArray.object(at: count) as? AnyObject)?.value(forKey: "url") as! String) {
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        if let image = UIImage(data: data!){
                            (createSlidesArray[count]).imageView.image = image
                        }
                    }
                }
                
            }
        }
        
        
        return createSlidesArray
    }
    
    func setupSlideScrollView(slides : [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }

}
