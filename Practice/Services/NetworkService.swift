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

class NetworkService {
    
    static let shared = NetworkService()
    
    func getDataFromURL<Model: Decodable>(url: String , from model: Model.Type , completionHandler: @escaping (Result<Model,Error>) -> Void ) {
             guard let url = URL(string: url) else {return}
             
             let session = URLSession.shared
             let decoder = JSONDecoder()
             
             let task = session.dataTask(with: url) { (data, response, error) in
                guard let dataResponse = data,
                    error == nil else {
                        completionHandler(.failure(error!))
                        return
                }
                
                do {
                    let data = try decoder.decode(model.self, from: dataResponse)
                    completionHandler(.success(data))
                } catch {
                    completionHandler(.failure(error))
                }
        }
        task.resume()
    }
}
