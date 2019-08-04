//
//  FilterViewModel.swift
//  NewsApp
//
//  Created by Radya Albasha on 8/3/19.
//  Copyright © 2019 Ember. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
class FilterViewModel{
    private var dataSubject = PublishSubject<[Source]>()
    public var dataObservable : Observable<[Source]>?
    let disposeBag = DisposeBag()
    var networkAccessDelegate : NetworkAccessProtocol?
    var networkResponse : Observable<(HTTPURLResponse,Any)>?
    var sourcesArr = Array<Source>()
    init() {
        networkAccessDelegate = NetworkAccessClass()
        dataObservable = dataSubject.asObservable()
        recieveNetworkResponse(requestURL: Constants.SOURCES_URL)
    }
    
    func recieveNetworkResponse(requestURL : String) {
        
        sourcesArr.removeAll()
        networkResponse = networkAccessDelegate?.getNews(requestURL: requestURL)
        networkResponse?.subscribe(onNext: { [weak self] (response, json) in
            if json is [String : Any]{
                do{
                    let data = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
                    //print(json)
                    let sources = try JSONDecoder().decode(Sources.self, from: data)
                    self?.sourcesArr = sources.sources
                    self?.dataSubject.onNext(sources.sources)
                }catch let myJSONError{
                    print(myJSONError)
                }
            }
            
        }).disposed(by: disposeBag)
    }
}
