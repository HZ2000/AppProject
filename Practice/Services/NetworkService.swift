//
//  NetworkService.swift
//  Practice
//
//  Created by Cypress on 2/22/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class NetworkService {
    
    static let shared = NetworkService()
    
    func getDataFromURL<Model: Decodable>(url: String , from model: [Model].Type , completionHandler: @escaping (Result<[Model],Error>) -> Void ) {
        AF.request(url)
            .validate()
            .responseDecodable(of: model.self) { (response) in
                guard let data = response.value else {return}
                completionHandler(.success(data))
            }
    }
}

