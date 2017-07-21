//
//  List.swift
//  Awesome-List
//
//  Created by PandaMaru on 7/21/2560 BE.
//  Copyright © 2560 amuse. All rights reserved.
//

import SwiftyJSON
import IGListKit

class List: NSObject {
    enum ListType: String {
        case track = "track", video = "video", ads = "ads"
    }
    
    var id: Int
    var name: String
    var type: ListType
    var cover: String
    
    init(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        type = ListType(rawValue: json["type"].stringValue)!
        cover = json["cover"].stringValue
    }
}

extension List: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if let object = object as? List {
            return id == object.id
        }
        
        return false
    }
}
