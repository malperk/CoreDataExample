//
//  CoreDataHelper.swift
//  CoreDataExample
//
//  Created by Alper KARATAŞ on 23/02/2017.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import UIKit
import CoreData

// MARK: - Core Data stack

var persistentContainer: NSPersistentContainer = {
    /*
     The persistent container for the application. This implementation
     creates and returns a container, having loaded the store for the
     application to it. This property is optional since there are legitimate
     error conditions that could cause the creation of the store to fail.
     */
    let container = NSPersistentContainer(name: "CoreDataExample")
    container.loadPersistentStores(completionHandler: { _, error in
        if let error = error as NSError? {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

            /*
             Typical reasons for an error here include:
             * The parent directory does not exist, cannot be created, or disallows writing.
             * The persistent store is not accessible, due to permissions or data protection when the device is locked.
             * The device is out of space.
             * The store could not be migrated to the current model version.
             Check the error message to determine what the actual problem was.
             */
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    })
    return container
}()

// MARK: - Core Data Saving support
func toSaveContext() throws {
    let context = persistentContainer.viewContext
    if context.hasChanges {
        do {
            try context.save()
        } catch {
            throw CoreDataError.saveError(errorDesc: error.localizedDescription)
        }
    }
}

//func save(value: String, forKey: String, inEntity: String) throws {
//    do {
//        let object = try getBlankEntityWith(name: inEntity)
//        object.setValue(value, forKey: forKey)
//        try toSaveContext()
//    } catch let error {
//        throw error
//    }
//}

func getBlankEntityWith(name: String) throws -> NSManagedObject {
    let container = persistentContainer
    if let entity = NSEntityDescription.entity(forEntityName: name, in: container.viewContext) {
        return NSManagedObject.init(entity: entity, insertInto: container.viewContext)
    } else {
        throw CoreDataError.entityNotfound(name: name)
    }
}

func getAll(inEntity: String) throws -> [Any] {
    do {
        return try persistentContainer.viewContext.fetch(NSClassFromString(inEntity)!.fetchRequest())
    } catch let error {
        throw CoreDataError.fetchError(errorDesc: error.localizedDescription)
    }
}

func deleteAllIn(entity: String) throws {
    do {
        let entityClass = NSClassFromString(entity)
        let request = entityClass!.fetchRequest()
        let data = try persistentContainer.viewContext.fetch(request)
        for item in data {
            persistentContainer.viewContext.delete(item as! NSManagedObject)
        }
        try toSaveContext()
    } catch {
        throw error
    }
    
}
