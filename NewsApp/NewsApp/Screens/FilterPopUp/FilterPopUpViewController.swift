//
//  FilterPopUpViewController.swift
//  NewsApp
//
//  Created by Radya Albasha on 8/2/19.
//  Copyright © 2019 Ember. All rights reserved.
//

import UIKit

class FilterPopUpViewController: UIViewController {

    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var filterBtn: UIButton!
    
    @IBOutlet weak var popUpView: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UIMethodsClass.roundedView(rView: cancelBtn, radius: 15)
        UIMethodsClass.roundedView(rView: filterBtn, radius: 15)
        UIMethodsClass.roundedView(rView: popUpView, radius: 15)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
