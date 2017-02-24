//
//  CoreDataExampleTests.swift
//  CoreDataExampleTests
//
//  Created by Alper KARATAŞ on 23/02/2017.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import XCTest
import CoreData

@testable import CoreDataExample

class CoreDataExampleTests: XCTestCase {
    func testMain() {
        getContainer()
        getObject()
        getWrongObject()
        deleteAll()
        saveItem()
        fetc()
        deleteItem()
    }
    func getContainer() {
        let container = persistentContainer
        XCTAssertNotNil(container)
    }
    func getObject() {
        let object = try! getBlankEntityWith(name: "Item")
        XCTAssertNotNil(object)
    }
    func getWrongObject() {
        do {
            let object = try getBlankEntityWith(name: "WrongObject")
            XCTAssertNil(object)
        } catch let error {
            XCTAssertNotNil(error)
            XCTAssertEqual(error as? CoreDataError, CoreDataError.entityNotfound(name: "WrongObject"))
        }
    }
    func deleteAll() {
        do {
            try deleteAllIn(entity: "Item")
            let newData = try getAll(inEntity: "Item")
            XCTAssertEqual(newData.count, 0)
        } catch {
            XCTAssert(false)
        }

    }
    func saveItem() {
        do {
            let object = try getBlankEntityWith(name: "Item")
            object.setValue("TestSave", forKey: "name")
            try toSaveContext()
        } catch let error {
            XCTAssertNotNil(error)
        }
    }

    func fetc() {
        do {
            let request: NSFetchRequest<Item> = Item.fetchRequest()
            request.predicate = NSPredicate.init(format: "name == %@", "TestSave")
            let data = try persistentContainer.viewContext.fetch(request)
            XCTAssertNotNil(data)
            XCTAssertEqual(data.count, 1)
        } catch {
            XCTAssert(false)
        }
    }

    func deleteItem() {
        do {
            let request: NSFetchRequest<Item> = Item.fetchRequest()
            request.predicate = NSPredicate.init(format: "name == %@", "TestSave")
            let data = try persistentContainer.viewContext.fetch(request)
            persistentContainer.viewContext.delete(data[0])
            try toSaveContext()
            let newData = try persistentContainer.viewContext.fetch(request)
            XCTAssertNotNil(newData)
            XCTAssertEqual(newData.count, 0)
        } catch {
            XCTAssert(false)
        }
    }
}
