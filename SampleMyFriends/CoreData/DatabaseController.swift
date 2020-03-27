//
//  DatabaseController.swift
//  SampleMyFriends
//
//  Created by apple on 31/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation
import CoreData

class DatabaseController {

    private init() {}
    //MARK: getContext
    //Returns the current Persistent Container for CoreData
    class func getContext () -> NSManagedObjectContext {
        return DatabaseController.persistentContainer.viewContext
    }

    //MARK: persistentContainer
    static var persistentContainer: NSPersistentContainer = {
        //The container that holds both data model entities
        let container = NSPersistentContainer(name: "SampleMyFriends")

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }


        })
        return container
    }()

    // MARK: - Core Data Saving support
    class func saveContext() {
        let context = self.getContext()
        if context.hasChanges {
            do {
                try context.save()
                print("Data Saved to Context")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    //MARK:- getAllFriends
    class func getAllFriends() -> Array<MyFriends> {
        let all = NSFetchRequest<MyFriends>(entityName: "MyFriends")
        var allFriends = [MyFriends]()
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        all.sortDescriptors = [sortDescriptor]

        do {
            let fetched = try DatabaseController.getContext().fetch(all)
            allFriends = fetched
        } catch {
            let nserror = error as NSError
            //TODO: Handle Error
            print(nserror.description)
        }

        return allFriends
    }
    
    //MARK:- Delete ALL Friends From CoreData
    class func deleteAllFriends() {
        do {
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "MyFriends")
            let deleteALL = NSBatchDeleteRequest(fetchRequest: deleteFetch)

            try DatabaseController.getContext().execute(deleteALL)
            DatabaseController.saveContext()
        } catch {
            print ("There is an error in deleting records")
        }
    }

}

