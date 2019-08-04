//
//  DataAccess.swift
//  NewsApp
//
//  Created by Radya Albasha on 8/3/19.
//  Copyright © 2019 Ember. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataAccess {
    var appDeleget : AppDelegate?
    let managerContext : NSManagedObjectContext?
    let countryEntity : NSEntityDescription?
    init() {
        self.appDeleget = (UIApplication.shared.delegate as! AppDelegate)
        managerContext = appDeleget?.persistentContainer.viewContext
        countryEntity = NSEntityDescription.entity(forEntityName: "CountryEntity", in: managerContext!)
    }
    func saveCountry(country: Country) {
        saveCountryToCDCountry(country: country)
        do{
            try managerContext?.save()
        }catch{
            print("Saving error")
        }
    }
    private func saveCountryToCDCountry(country: Country) {
        let cdCountry = NSManagedObject(entity: countryEntity!, insertInto: managerContext)
        cdCountry.setValue(country.code, forKey: "code")
        cdCountry.setValue(country.name, forKey: "name")
    }
    
    func retriveCountries() -> Array<Country>? {
        let fecheRequest = NSFetchRequest<NSManagedObject>(entityName: "CountryEntity")
        var countryArr : Array<NSManagedObject>? = nil
        do{
            try countryArr = (managerContext?.fetch(fecheRequest))!
        }catch{
            print("error feche data")
        }
        var arr : Array<Country> = Array<Country>()
        for nsObject in countryArr! {
            arr.append(Country(code: nsObject.value(forKey: "code") as! String, name: nsObject.value(forKey: "name") as! String))
        }
        return arr;
    }
    
    var isEmpty : Bool {
        do{
            let request = NSFetchRequest<NSManagedObject>(entityName: "CountryEntity")
            let count  = try managerContext?.count(for: request)
            return count == 0 ? true : false
        }catch{
            return true
        }
    }
}
