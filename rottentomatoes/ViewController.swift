//
//  ViewController.swift
//  rottentomatoes
//
//  Created by Jesse Smith on 9/14/14.
//  Copyright (c) 2014 Jesse Smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var movieTableView: UITableView!

    var moviesArray: NSArray?
    
    let RottenTomatoesAPIKey = "3ep56bczb367ku9hruf7xpdq"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getMovieData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (moviesArray != nil) ?
            moviesArray!.count :
            0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = movieTableView.dequeueReusableCellWithIdentifier("com.codepath.rottentomatoes.moviecell") as MovieTableViewCell
        let movieDictionary = self.moviesArray![indexPath.row] as NSDictionary
        
        cell.titleLabel.text = movieDictionary["title"] as NSString
        cell.descriptionLabel.text = movieDictionary["synopsis"] as NSString
        
        
        let postersDict = movieDictionary["posters"] as NSDictionary
        let thumbUrl = postersDict["thumbnail"] as NSString
        
        cell.thumbnailImageView.setImageWithURL(NSURL(string: thumbUrl))
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailsViewController = MovieDetailsViewController(nibName: "MovieDetails", bundle: nil)
        
        let movieDictionary = self.moviesArray![indexPath.row] as NSDictionary
        let postersDict = movieDictionary["posters"] as NSDictionary
        
        let thumbUrl = postersDict["thumbnail"] as NSString
        detailsViewController.fullImageUrl = thumbUrl.stringByReplacingOccurrencesOfString("tmb", withString: "ori")
        detailsViewController.movieDescriptionDict = movieDictionary
        
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    func getMovieData() {
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=" + RottenTomatoesAPIKey
        
        let manager = AFHTTPRequestOperationManager()
        
        manager.GET(RottenTomatoesURLString, parameters: nil,
            success: self.updateViewWithMovies,
            failure: self.fetchMoviesError)
        
        let request = NSMutableURLRequest(URL: NSURL.URLWithString(RottenTomatoesURLString))
        
    }
    
    func updateViewWithMovies(operation: AFHTTPRequestOperation!,
        responseObject: AnyObject!) -> Void {
            self.moviesArray = responseObject["movies"] as? NSArray
            self.movieTableView.reloadData()
            
        
    }
    
    func fetchMoviesError(operation: AFHTTPRequestOperation!,
        error: NSError!) -> Void {
            println("Error: " + error.localizedDescription)
    }
}

