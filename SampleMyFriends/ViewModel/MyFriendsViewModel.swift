//
//  MyFriendsViewModel.swift
//  SampleMyFriends
//
//  Created by Others on 01/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation
import CoreData

class MyFriendsViewModel {
    
    //headerTitle
    var headerTitle = "My Friends"
    
    //alertMessage
    var alertMessage = "No data found"
    
    //Original Array from Core Data
    var myFriendArray = [MyFriends]()
    //Search and Table data array from Core Data
    var myFriendListArray = [MyFriends]()
    //New Values to Core Data
    var newFriends:[MyFriendsModel.friendsLists]? {
        didSet {
            // Remove all Previous Records
            DatabaseController.deleteAllFriends()
            // Add the new spots to Core Data Context
            self.addNewFriendsToCoreData(self.newFriends!)
            // Save them to Core Data
            DatabaseController.saveContext()
            //myFriend
            self.myFriendArray = DatabaseController.getAllFriends()
            //myFriendListArray
            self.myFriendListArray = DatabaseController.getAllFriends()
        }
    }
    
    //MARK:- addNewFriendsToCoreData
    func addNewFriendsToCoreData(_ friends: [MyFriendsModel.friendsLists]) {
        for friend in friends {
            let entity = NSEntityDescription.entity(forEntityName: "MyFriends", in: DatabaseController.getContext())
            let newFriend = NSManagedObject(entity: entity!, insertInto: DatabaseController.getContext())
            // Set the data to the entity
            newFriend.setValue(friend.id, forKey: "id")
            newFriend.setValue(friend.title, forKey: "title")
            newFriend.setValue(friend.distance, forKey: "distance")
            newFriend.setValue(friend.imageHref, forKey: "imageHref")
        }
    }
    
    //MARK:- readJsonFile
    func readJsonFile() {
        if let path = Bundle.main.path(forResource: "Sample", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                do {
                    let decoder = JSONDecoder()
                    let gitData = try decoder.decode(MyFriendsModel.self, from: data)
                    self.newFriends = gitData.friendsList
                } catch {
                    print(error)
                }
            } catch {
                // handle error
            }
        }
    }
}
