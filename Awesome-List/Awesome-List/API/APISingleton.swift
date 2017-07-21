//
//  APISingleton.swift
//  Awesome-List
//
//  Created by PandaMaru on 7/21/2560 BE.
//  Copyright © 2560 amuse. All rights reserved.
//

import RxSwift
import RxAlamofire

class APISingleton {
    static let sharedInstance = APISingleton()
    private init() {}
    
    public let baseURL = "http://www.anop72.info/api"
    
    public func getList() -> Observable<(HTTPURLResponse, Any)>  {
        return RxAlamofire.requestJSON(.get, baseURL + "/seed.json")
    }
}
