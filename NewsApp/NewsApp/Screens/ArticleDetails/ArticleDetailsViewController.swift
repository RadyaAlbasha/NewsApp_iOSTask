//
//  ArticleDetailsViewController.swift
//  NewsApp
//
//  Created by Radya Albasha on 8/2/19.
//  Copyright © 2019 Ember. All rights reserved.
//

import UIKit

class ArticleDetailsViewController: UIViewController {

    @IBOutlet weak var headLineLabel: UILabel!
    
    @IBOutlet weak var headLineV: UIView!
    
    @IBOutlet weak var authorImage: UIImageView!
    
    @IBOutlet weak var authorV: UIView!
    
    @IBOutlet weak var authorNameLabel: UILabel!
    
    @IBOutlet weak var articleTV: UITextView!
    
    @IBOutlet weak var articleView: UIView!
    
    @IBOutlet weak var articleV: UIView!
    
    @IBOutlet weak var urlView: UIView!
    
    @IBOutlet weak var urlV: UIView!
    
    @IBOutlet weak var sourceUrlLabel: UILabel!
    
    var articleDetails : Article?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        headLineLabel.adjustsFontSizeToFitWidth = true
        sourceUrlLabel.adjustsFontSizeToFitWidth = true
        authorNameLabel.adjustsFontSizeToFitWidth = true
        
        UIMethodsClass.roundedView(rView: articleV, radius: 15)
        UIMethodsClass.roundedView(rView: articleView, radius: 15)
        UIMethodsClass.roundedView(rView: urlV, radius: 15)
        UIMethodsClass.roundedView(rView: urlView, radius: 15)
        UIMethodsClass.roundedView(rView: authorV, radius: 15)
        UIMethodsClass.roundedView(rView: headLineV, radius: 15)
        
        authorImage.tintColor = CustomColor.blueIcons
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
