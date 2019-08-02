//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Radya Albasha on 8/1/19.
//  Copyright © 2019 Ember. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
class NewsViewModel{
    private var dataSubject = PublishSubject<[Article]>()
    public var dataObservable : Observable<[Article]>?
    let disposeBag = DisposeBag()
    var networkAccessDelegate : NetworkAccessProtocol?
    var networkResponse : Observable<(HTTPURLResponse,Any)>?
    
    init() {
        networkAccessDelegate = NetworkAccessClass()
        dataObservable = dataSubject.asObservable()
        recieveNetworkResponse()
    }
    
    func recieveNetworkResponse() {
        
        networkResponse = networkAccessDelegate?.getNews(requestURL: Constants.HEADLINES_URL)
        networkResponse?.subscribe(onNext: { [weak self] (response, json) in
            if json is [String : Any]{
                do{
                    let data = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
                    //print(json)
                    let news = try JSONDecoder().decode(News.self, from: data)
                    self?.dataSubject.onNext(news.articles)
                    //print(news.articles)
                }catch let myJSONError{
                    print(myJSONError)
                }
            }
            
        }).disposed(by: disposeBag)
        /*
        networkResponse?.subscribe(onNext: { [weak self] in
            if let dict = $0.1 as?[String:Any]{
                if let dictValue = dict["articles"] as? [String:Any]{
                    self?.dataSubject.onNext(dictValue)
                }
            }}).disposed(by: disposeBag)*/
    }
}
