//
//  NetworkAccessProtocol.swift
//  NewsApp
//
//  Created by Radya Albasha on 8/1/19.
//  Copyright © 2019 Ember. All rights reserved.
//

import Foundation
import RxSwift

protocol NetworkAccessProtocol {
    func getNews(requestURL:String) ->Observable<(HTTPURLResponse,Any)>
}
