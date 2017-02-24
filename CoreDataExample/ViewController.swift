//
//  ViewController.swift
//  CoreDataExample
//
//  Created by Alper KARATAŞ on 23/02/2017.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tvMain: UITableView!
    var items = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\"The List\""
        tvMain.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    // MARK: - AddItem
    @IBAction func addItem(_: Any) {
        let alert = UIAlertController(title: "New Item",
                                      message: "Add a new item",
                                      preferredStyle: .alert)

        let saveAction = UIAlertAction(title: "Save",
                                       style: .default,
                                       handler: { (_: UIAlertAction) -> Void in

                                           let textField = alert.textFields!.first
                                           self.saveItem(name: (textField?.text)!)
                                           self.tvMain.reloadData()
        })

        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default) { (_: UIAlertAction) -> Void in
        }

        alert.addTextField {
            (_: UITextField) -> Void in
        }

        alert.addAction(saveAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }

    // MARK: - SaveItem
    func saveItem(name: String) {
//        do {
//            saveItem(name: <#T##String#>)
//            let object = try getObject(name: "Item")
//            object.setValue(name, forKey: "name")
//            try persistentContainer.viewContext.save()
//            items.append(object)
//
//        } catch let error {
//            print("Error: \(error.localizedDescription)")
//        }
    }

    // MARK: - UITableViewDataSource
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let item = items[indexPath.row]
        cell!.textLabel!.text = item.value(forKey: "name") as? String
        return cell!
    }

}
