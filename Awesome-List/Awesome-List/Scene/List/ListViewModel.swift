//
//  ListViewModel.swift
//  Awesome-List
//
//  Created by PandaMaru on 7/21/2560 BE.
//  Copyright © 2560 amuse. All rights reserved.
//

import RxSwift
import SwiftyJSON

class ListViewModel {
    
    public func getList() -> Observable<[List]> {
        return APISingleton.sharedInstance.getList()
            .map { response, data in
                let json = JSON(data)
                return json.arrayValue.map { element in
                    return List(json: element)
                }
            }
    }
    
}
