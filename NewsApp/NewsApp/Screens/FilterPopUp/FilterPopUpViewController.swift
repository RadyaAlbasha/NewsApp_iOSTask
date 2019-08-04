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

class FilterPopUpViewController: UIViewController {

    @IBOutlet weak var countryPickerV: UIPickerView!
    
    @IBOutlet weak var sourcePickerV: UIPickerView!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var filterBtn: UIButton!
    
    @IBOutlet weak var popUpView: UIView!
   
    let dataAccess = DataAccess()
    
    let disposeBag = DisposeBag()
    
    private var viewModel: FilterViewModel!
    
    var newsViewModel: NewsViewModel!
    
    var countryArr : Array<Country>?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       /* //save in core data
        if dataAccess.isEmpty{
            saveCountries()
        }*/
        
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func filter(_ sender: UIButton) {
        
        guard newsViewModel != nil else {
            return
        }
        
        if self.viewModel.sourcesArr.isEmpty == false{//filter by source&country
            
            let sourceRow = self.sourcePickerV.selectedRow(inComponent: 0)
            let selectedSource = self.viewModel.sourcesArr[sourceRow]
            NSLog("selected: \(selectedSource.id)")
            self.newsViewModel.recieveNetworkResponse(requestURL: "https://newsapi.org/v2/top-headlines?sources=\(selectedSource.id)&apiKey=\(Constants.API_KEY)")
            
        }else{//filter by country
            
            let countryRow = self.countryPickerV.selectedRow(inComponent: 0)
            let selectedCountry = self.countryArr![countryRow]
            NSLog("selected: \(selectedCountry.code)")
            self.newsViewModel.recieveNetworkResponse(requestURL: "https://newsapi.org/v2/top-headlines?country=\(selectedCountry.code)&apiKey=\(Constants.API_KEY)")
        }
        dismiss(animated: true, completion: nil)
        
    }
    private func setupViewModel() {
        self.viewModel = FilterViewModel()
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
        countryPickerV.rx.itemSelected
            .subscribe(onNext: { [weak self] (row, value) in
                
                let country = self?.countryArr![row].code
                let url = "https://newsapi.org/v2/sources?country=\(country!)&apiKey=\(Constants.API_KEY)"
                self?.viewModel.recieveNetworkResponse(requestURL: url)
                //self?.sourcePickerV.isUserInteractionEnabled = false
            })
            .disposed(by: disposeBag)
        
        //pselect the second item in pickerView
        countryPickerV.selectRow(51, inComponent: 0, animated: true)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
