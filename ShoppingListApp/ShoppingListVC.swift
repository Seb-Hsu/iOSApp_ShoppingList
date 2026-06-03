//
//  ShoppingListVC.swift
//  ShoppingListApp
//
//  Created by Sebastian Hsu on 23/3/2026.
//
//

import SQLite3
import UIKit

class ShoppingListVC: UIViewController, UITableViewDelegate,
    UITableViewDataSource
{

    @IBOutlet weak var itemTable: UITableView!

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var db: OpaquePointer? = nil

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        itemTable.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if sqlite3_open(appDelegate.getDBPath(), &db) == SQLITE_OK {
            appDelegate.itemArray = selectQuery()
            sqlite3_close(db)
        } else {
            print("Error opening DB")
        }
    }

    func selectQuery() -> [Item] {
        var items: [Item] = []
        let query = "SELECT * FROM ShoppingList"
        var statement: OpaquePointer?

        guard sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK
        else {
            print("Failed to prepare statement")
            return items
        }

        defer {
            sqlite3_finalize(statement)
        }

        while sqlite3_step(statement) == SQLITE_ROW {

            let itemName = String(cString: sqlite3_column_text(statement, 1))
            let itemPrice = Double(sqlite3_column_int(statement, 2))
            let itemCategory = String(
                cString: sqlite3_column_text(statement, 3)
            )
            let itemQty = Int(sqlite3_column_int(statement, 4))

            let i = Item(
                name: itemName,
                price: itemPrice,
                category: itemCategory,
                qty: itemQty
            )

            items.append(i)
        }

        return items
    }

    func deleteQuery(itemName: String) {
        let deleteSQL = "DELETE FROM ShoppingList WHERE item = ?"
        print(deleteSQL)
        var queryStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteSQL, -1, &queryStatement, nil)
            == SQLITE_OK
        {
            sqlite3_bind_text(
                queryStatement,
                1,
                (itemName as NSString).utf8String,
                -1,
                nil
            )
            if sqlite3_step(queryStatement) == SQLITE_DONE {
                print("Record Deleted")
            } else {
                print("Fail to Delete")
            }
            sqlite3_finalize(queryStatement)
        } else {
            print("Delete statement could not be prepared")
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return appDelegate.itemArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell",
            for: indexPath as IndexPath
        )

        var config = UIListContentConfiguration.cell()

        let item: Item = appDelegate.itemArray[indexPath.row]

        config.text = item.name
        config.secondaryText = item.toString()
        //config.image = UIImage(named: item.imageName)
        //config.imageProperties.maximumSize = CGSize(width: 36, height: 36)
        cell.contentConfiguration = config
        //cell.detailTextLabel!.text = movie.toString()
        return cell
    }

    //Delete the table view
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath)
        -> Bool
    {
        //Return false if you do not want the specified item to be editable
        return true
    }

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {

            let selectedItem: Item = appDelegate.itemArray[indexPath.row]
            let itemName = selectedItem.name

            if sqlite3_open(appDelegate.getDBPath(), &db) == SQLITE_OK {
                print("Successfully opened conection to database")
                //Delete from DB
                deleteQuery(itemName: itemName)
                appDelegate.itemArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                sqlite3_close(db)
                itemTable.reloadData()
            } else {
                print("Unable to open database")
            }

            //itemArray = appDelegate.itemArray.sorted(by: { $0.name < $1.name })

            //        } else if editingStyle == .insert {
            //            //create a new instance of appropriate class, insert it into the array, and ass a new row to the table view
            //        }

            /*
             // MARK: - Navigation
            
             // In a storyboard-based application, you will often want to do a little preparation before navigation
             override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             // Get the new view controller using segue.destination.
             // Pass the selected object to the new view controller.
             }
             */

        }
    }
}
