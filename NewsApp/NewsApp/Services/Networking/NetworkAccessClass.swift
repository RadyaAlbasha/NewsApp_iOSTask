//
//  NetworkAccessClass.swift
//  NewsApp
//
//  Created by Radya Albasha on 8/1/19.
//  Copyright © 2019 Ember. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxAlamofire

class NetworkAccessClass: NetworkAccessProtocol {
    
    func getNews(requestURL:String) ->Observable<(HTTPURLResponse,Any)> {
        
        let response = RxAlamofire.requestJSON(.get,requestURL)
        return response
    }
}
