//
//  IEXClient.swift
//  KrasamoStockTracker
//
//  Created by Antonio Mayorga on 2/5/19.
//  Copyright © 2019 Rays Industrial Computers. All rights reserved.
//

import Foundation

class IEXClient {
    func iexUrlWithUrlRequests(_ requests: [String]) -> URL? {
        var components = URLComponents()
        components.scheme = IEXConstants.IEXURLComponents.ApiScheme
        components.host = IEXConstants.IEXURLComponents.ApiHost
        components.path = IEXConstants.IEXURLComponents.ApiPath
        
        for request in requests {
            components.path.append(request)
        }
        
        guard let url = components.url else {
            return nil
        }
        
        return url
    }
}
