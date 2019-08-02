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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupViewModel()
        setupTableView()
        setupTableViewBinding()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupViewModel() {
        self.viewModel = NewsViewModel()
    }
    private func setupTableView() {
        //newsTableView.register(UINib.init(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    private func setupTableViewBinding() {
        
        viewModel?.dataObservable?.bind(to: newsTableView.rx.items(cellIdentifier: cellIdentifier, cellType: NewsTableViewCell.self)){ (row , element , cell) in
            //cell.configure(headLine: "element.title" , date: "element.publishedAt", imageURL: nil)
            var time = element.publishedAt.split(separator: "T").map(String.init)
            cell.configure(headLine: element.title , date: time[0], imageURL: element.urlToImage)
            
        }.disposed(by: disposeBag)
    }
    
    /*func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
    }*/

}

