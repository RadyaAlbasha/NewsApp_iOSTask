//
//  ViewController.swift
//  NewsApp
//
//  Created by Radya Albasha on 7/31/19.
//  Copyright © 2019 Ember. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NewsListViewController: UIViewController{ 

    @IBOutlet weak var newsTableView: UITableView!
    private var viewModel: NewsViewModel!
    private let cellIdentifier = "CustomCell"
    let disposeBag = DisposeBag()
    let dataAccess = DataAccess()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupViewModel()
        setupTableView()
        setupTableViewBinding()
        
        //save in core data
        if dataAccess.isEmpty{
            saveCountries()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        if let index = newsTableView.indexPathForSelectedRow{
            self.newsTableView.deselectRow(at: index, animated: true)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupViewModel() {
        self.viewModel = NewsViewModel()
        self.viewModel.recieveNetworkResponse(requestURL : Constants.HEADLINES_URL)
    }
    private func setupTableView() {
        //newsTableView.register(UINib.init(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    private func setupTableViewBinding() {
        
        viewModel?.dataObservable?.bind(to: newsTableView.rx.items(cellIdentifier: cellIdentifier, cellType: NewsTableViewCell.self)){ (row , element , cell) in
            cell.articleDetails = element
            //cell.configure(headLine: "element.title" , date: "element.publishedAt", imageURL: nil)
            var time = element.publishedAt.split(separator: "T").map(String.init)
            cell.configure(headLine: element.title , date: time[0], imageURL: element.urlToImage)
            
        }.disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        if segue.destination.restorationIdentifier == "ArticleDetailsVC"{
           
            let articleDetailsVC = segue.destination as! ArticleDetailsViewController
            let backItem = UIBarButtonItem()
            if let articleCell = sender as? NewsTableViewCell{
                articleDetailsVC.articleDetails = articleCell.articleDetails
                backItem.title = articleDetailsVC.articleDetails?.source.name
            }else{
                backItem.title = "Back"
            }
            navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        }else{
             let filterVC = segue.destination as! FilterPopUpViewController
             filterVC.newsViewModel = viewModel
        }
    }
    func saveCountries(){
        dataAccess.saveCountry(country: Country(code: "ae", name: "United Arab Emirates"))
        dataAccess.saveCountry(country: Country(code: "ar", name: "Argentina"))
        dataAccess.saveCountry(country: Country(code: "at", name: "Austria"))
        dataAccess.saveCountry(country: Country(code: "au", name: "Australia"))
        dataAccess.saveCountry(country: Country(code: "be", name: "Belgium"))
        dataAccess.saveCountry(country: Country(code: "bg", name: "Bulgaria"))
        dataAccess.saveCountry(country: Country(code: "br", name: "Brazil"))
        dataAccess.saveCountry(country: Country(code: "ca", name: "Canada"))
        dataAccess.saveCountry(country: Country(code: "ch", name: "Switzerland"))
        dataAccess.saveCountry(country: Country(code: "cn", name: "China"))
        dataAccess.saveCountry(country: Country(code: "co", name: "Colombia"))
        dataAccess.saveCountry(country: Country(code: "cu", name: "Cuba"))
        dataAccess.saveCountry(country: Country(code: "cz", name: "Czech Republic"))
        dataAccess.saveCountry(country: Country(code: "de", name: "Germany"))
        dataAccess.saveCountry(country: Country(code: "eg", name: "Egypt"))
        dataAccess.saveCountry(country: Country(code: "fr", name: "France"))
        dataAccess.saveCountry(country: Country(code: "gb", name: "United Kingdom"))
        dataAccess.saveCountry(country: Country(code: "gr", name: "Greece"))
        dataAccess.saveCountry(country: Country(code: "hk", name: "Hong Kong"))
        dataAccess.saveCountry(country: Country(code: "hu", name: "Hungary"))
        dataAccess.saveCountry(country: Country(code: "id", name: "Indonesia"))
        dataAccess.saveCountry(country: Country(code: "ie", name: "Ireland"))
        dataAccess.saveCountry(country: Country(code: "il", name: "Israel"))
        dataAccess.saveCountry(country: Country(code: "in", name: "India"))
        dataAccess.saveCountry(country: Country(code: "it", name: "Italy"))
        dataAccess.saveCountry(country: Country(code: "jp", name: "Japan"))
        dataAccess.saveCountry(country: Country(code: "kr", name: "Korea, Republic of"))
        dataAccess.saveCountry(country: Country(code: "lt", name: "Lithuania"))
        dataAccess.saveCountry(country: Country(code: "lv", name: "Latvia"))
        dataAccess.saveCountry(country: Country(code: "ma", name: "Morocco"))
        dataAccess.saveCountry(country: Country(code: "mx", name: "Mexico"))
        dataAccess.saveCountry(country: Country(code: "my", name: "Malaysia"))
        dataAccess.saveCountry(country: Country(code: "ng", name: "Nigeria"))
        dataAccess.saveCountry(country: Country(code: "nl", name: "Netherlands"))
        dataAccess.saveCountry(country: Country(code: "no", name: "Norway"))
        dataAccess.saveCountry(country: Country(code: "nz", name: "New Zealand"))
        dataAccess.saveCountry(country: Country(code: "ph", name: "Philippines"))
        dataAccess.saveCountry(country: Country(code: "pl", name: "Poland"))
        dataAccess.saveCountry(country: Country(code: "pt", name: "Portugal"))
        dataAccess.saveCountry(country: Country(code: "ro", name: "Romania"))
        dataAccess.saveCountry(country: Country(code: "rs", name: "Serbia"))
        dataAccess.saveCountry(country: Country(code: "ru", name: "Russian Federation"))
        dataAccess.saveCountry(country: Country(code: "sa", name: "Saudi Arabia"))
        dataAccess.saveCountry(country: Country(code: "se", name: "Sweden"))
        dataAccess.saveCountry(country: Country(code: "sg", name: "Singapore"))
        dataAccess.saveCountry(country: Country(code: "si", name: "Slovenia"))
        dataAccess.saveCountry(country: Country(code: "sk", name: "Slovakia"))
        dataAccess.saveCountry(country: Country(code: "th", name: "Thailand"))
        dataAccess.saveCountry(country: Country(code: "tr", name: "Turkey"))
        dataAccess.saveCountry(country: Country(code: "tw", name: "Taiwan, Province of China"))
        dataAccess.saveCountry(country: Country(code: "ua", name: "Ukraine"))
        dataAccess.saveCountry(country: Country(code: "us", name: "United States"))
        dataAccess.saveCountry(country: Country(code: "ve", name: "Venezuela, Bolivarian Republic of"))
        dataAccess.saveCountry(country: Country(code: "za", name: "South Africa"))
    }
    
    /*func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
    }*/

}

