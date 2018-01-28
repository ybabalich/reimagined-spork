//
//  CoinsLoaderService.swift
//  Crypto
//
//  Created by Yaroslav Babalich on 1/20/18.
//  Copyright © 2018 PxToday. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol CoinsLoader {
    
}

typealias CoinsLoaderResponse = () -> ()

class CoinsLoaderService: NSObject {
  
    enum ApiParamsUrl: String {
        case coinsList = "/api/data/coinlist/"
    }
    
    // MARK: - Private methods
    func load(url: URL, completion: CoinsLoaderResponse) {
        let request = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            let models = CoinsListModel(server: data)
            print(models!.elements[0]!.name)
            
        }
        request.resume()
    }
}

extension CoinsLoaderService: CoinsLoader {
    
}


