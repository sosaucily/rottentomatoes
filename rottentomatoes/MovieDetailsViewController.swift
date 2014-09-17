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
    
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    @IBOutlet var panOutlet: UIPanGestureRecognizer!

    var y_coord: Int = 454;
    
    var fullImageUrl: NSString?
    
    var movieDescriptionDict: NSDictionary?
    
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
        
        
        let synopsis = movieDescriptionDict!["synopsis"] as NSString
        let title = movieDescriptionDict!["title"] as NSString
        let year = movieDescriptionDict!["year"] as Int
        let mpaa_rating = movieDescriptionDict!["mpaa_rating"] as NSString
        let critics_score = (movieDescriptionDict!["ratings"] as NSDictionary)["critics_score"] as Int
        let audience_score = (movieDescriptionDict!["ratings"] as NSDictionary)["audience_score"] as Int
        
        self.movieDescriptionLabel?.text = "\(title) (\(year))Critics Score: \(critics_score), Audience Score: \(audience_score)\(mpaa_rating)\(synopsis)"
        
    }
    
    @IBAction func panGestureAction(sender: AnyObject) {
        let translation = panOutlet.translationInView(self.view)
        self.movieDescriptionLabel.center = CGPoint(x:self.panOutlet.view!.center.x,
            y:CGFloat(self.y_coord) + translation.y)
        
        if panOutlet.state == UIGestureRecognizerState.Ended {
            self.y_coord = self.y_coord + Int(translation.y)
        }
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
