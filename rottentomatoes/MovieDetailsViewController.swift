//
//  MovieDetailsViewController.swift
//  rottentomatoes
//
//  Created by Jesse Smith on 9/14/14.
//  Copyright (c) 2014 Jesse Smith. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var fullImageView: UIImageView!
    
    var fullImageUrl: NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        if fullImageUrl != nil {
            let imageRequest = NSURLRequest(URL: NSURL(string: fullImageUrl!))
            self.fullImageView.setImageWithURLRequest(imageRequest, placeholderImage: nil, success:{ (request: NSURLRequest!, response: NSHTTPURLResponse!, image: UIImage!) in
                    self.fullImageView.image = image
                    MBProgressHUD.hideHUDForView(self.view, animated: true)
                }, failure: { (request: NSURLRequest!, response: NSHTTPURLResponse!, error: NSError!) in
                    //pass
            })
        }
    }
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    @IBOutlet var panner: UIPanGestureRecognizer!
    
    @IBAction func panAction(sender: AnyObject) {
        let translation = panner.translationInView(self.view)
        self.movieDescriptionLabel.center = CGPoint(x:self.panner.view!.center.x,
            y:self.panner.view!.center.y + translation.y)
        println(self.panner.view!.center.y)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
