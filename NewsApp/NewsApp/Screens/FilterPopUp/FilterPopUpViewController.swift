//
//  FilterPopUpViewController.swift
//  NewsApp
//
//  Created by Radya Albasha on 8/2/19.
//  Copyright © 2019 Ember. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import DLRadioButton

class FilterPopUpViewController: UIViewController {

    @IBOutlet weak var countryPickerV: UIPickerView!
    
    @IBOutlet weak var sourcePickerV: UIPickerView!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var filterBtn: UIButton!
    
    @IBOutlet weak var popUpView: UIView!
    
    @IBOutlet weak var countryRbtn: DLRadioButton!
    
    @IBOutlet weak var srcRbtn: DLRadioButton!
  
    let dataAccess = DataAccess()
    
    let disposeBag = DisposeBag()
    
    private var viewModel: FilterViewModel!
    
    var newsViewModel: NewsViewModel!
    
    var countryArr : Array<Country>?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //get data from core data
        if dataAccess.isEmpty == false{
            countryArr = dataAccess.retriveCountries()
            
            //put countries in picker
            if(countryArr != nil)
            {
                let countriesName = getCountriesName(countries: countryArr!)
                setupCountryPickerViewBinding(countriesName: countriesName)
            }
        }
        
        setupViewModel()
        setupSourcesPickerViewBinding()
        UIMethodsClass.roundedView(rView: cancelBtn, radius: 15)
        UIMethodsClass.roundedView(rView: filterBtn, radius: 15)
        UIMethodsClass.roundedView(rView: popUpView, radius: 15)
        UIMethodsClass.roundedView(rView: countryPickerV, radius: 15)
        UIMethodsClass.roundedView(rView: sourcePickerV, radius: 15)
        
        //start with filter by country
        setupCountryRbtn()
        
        //to enable multiple selection
        //countryRbtn.isMultipleSelectionEnabled = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if CheckInternet.Connection() == false{
            UIMethodsClass.showInternetConnectionAlert(viewController: self)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectBtnAction(_ sender: DLRadioButton) {
        if sender.tag == 1 {//country
            countryPickerV.isUserInteractionEnabled = true
            sourcePickerV.isUserInteractionEnabled = false
            sourcePickerV.backgroundColor = CustomColor.lightGray
            countryPickerV.backgroundColor = CustomColor.lightCyan
            
        }else{//source
            countryPickerV.isUserInteractionEnabled = false
            sourcePickerV.isUserInteractionEnabled = true
            sourcePickerV.backgroundColor = CustomColor.lightCyan
            countryPickerV.backgroundColor = CustomColor.lightGray
        }
    }
    
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func filter(_ sender: UIButton) {
        
        guard newsViewModel != nil else {
            return
        }
        /*
        if self.viewModel.sourcesArr.isEmpty == false{//filter by source&country
            filterBySource()
        }else{//filter by country
           filterByCountry()
        }*/
        if countryRbtn.isSelected{
            filterByCountry()
        }else{
            filterBySource()
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    private func setupCountryRbtn(){
        countryRbtn.isSelected = true
        sourcePickerV.isUserInteractionEnabled = false
    }
    private func setupViewModel() {
        self.viewModel = FilterViewModel()
        if CheckInternet.Connection() {
            self.viewModel.recieveNetworkResponse(requestURL: Constants.ALL_SOURCES_URL)
        }
    }
    private func setupCountryPickerViewBinding(countriesName : Array<String>) {
        //show data in picker
        Observable.just(countriesName)
            .bind(to: countryPickerV.rx.itemTitles) { _, item in
                return "\(item)"
            }
            .disposed(by: disposeBag)
        
        //handle picker selection
         //countryPickerV.rx.itemSelected.debounce(1, scheduler : MainScheduler.asyncInstance)
        /*countryPickerV.rx.itemSelected
            .subscribe(onNext: { [weak self] (row, value) in
                
                
                if ((self?.countryRbtn.isSelected)! && (self?.srcRbtn.isSelected)!) || ((self?.countryRbtn.isSelected)! == false && (self?.srcRbtn.isSelected)! == false){
                    //when choose country and source OR country and source not selected
                    self?.handleCountryPickerWhenChooseCountryAndSource(row: row)
                    print("country and src")
                }
              
            })
            .disposed(by: disposeBag)*/
        
        //pselect the second item in pickerView
        countryPickerV.selectRow(51, inComponent: 0, animated: true)
    }
    
    private func filterByCountry(){
        let countryRow = self.countryPickerV.selectedRow(inComponent: 0)
        let selectedCountry = self.countryArr![countryRow]
        NSLog("selected: \(selectedCountry.code)")
        self.newsViewModel.recieveNetworkResponse(requestURL: "https://newsapi.org/v2/top-headlines?country=\(selectedCountry.code)&apiKey=\(Constants.API_KEY)")
        self.newsViewModel.title = "\(String(selectedCountry.code).uppercased())"
    }
    
    private func filterBySource(){
        let sourceRow = self.sourcePickerV.selectedRow(inComponent: 0)
        let selectedSource = self.viewModel.sourcesArr[sourceRow]
        NSLog("selected: \(selectedSource.id)")
        self.newsViewModel.recieveNetworkResponse(requestURL: "https://newsapi.org/v2/top-headlines?sources=\(selectedSource.id)&apiKey=\(Constants.API_KEY)")
        self.newsViewModel.title = "\(selectedSource.name)"
    }
    
    private func handleCountryPickerWhenChooseCountryAndSource(row : Int){
        let country = self.countryArr![row].code
        let url = "https://newsapi.org/v2/sources?country=\(country)&apiKey=\(Constants.API_KEY)"
        self.viewModel.recieveNetworkResponse(requestURL: url)
    }
    private func setupSourcesPickerViewBinding() {
        viewModel?.dataObservable?
            .bind(to: sourcePickerV.rx.itemTitles) { _, item in
                //self?.sourcePickerV.isUserInteractionEnabled = true
                return "\(item.name)"
            }
            .disposed(by: disposeBag)
    }
    
    func getCountriesName(countries : Array<Country>) -> Array<String>{
        var countriesName = Array<String>()
        for c in countries{
            countriesName.append(c.name)
        }
        return countriesName
    }


}
