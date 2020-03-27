//
//  MyFriendsModel.swift
//  SampleMyFriends
//
//  Created by apple on 31/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation

struct MyFriendsModel: Codable {
    var title: String?
    var friendsList:[friendsLists]?
    
    //CodingKeys
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case friendsList = "friendsList"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        friendsList = try values.decode([friendsLists].self, forKey: .friendsList)
    }
    
    struct friendsLists:Codable {
        var id: String?
        var title: String?
        var distance: String?
        var imageHref: String?
    }
}
