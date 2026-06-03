//
//  AddItemsVC.swift
//  ShoppingListApp
//
//  Created by Sebastian Hsu on 23/3/2026.
//
import SQLite3
import UIKit

class AddItemsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{

    @IBOutlet weak var ItemNameTF: UITextField!

    @IBOutlet weak var priceTF: UITextField!

    @IBOutlet weak var categoryPV: UIPickerView!

    @IBOutlet weak var messageLabel: UILabel!

    @IBOutlet weak var qtyTF: UITextField!

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var db: OpaquePointer? = nil
    var categories: [String] = [
        "Fruit and Veg🥦", "Electronics💻", "Clothing👕", "Other",
    ]

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int {
        return categories.count
    }

    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        return categories[row] as String
    }

    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int
    ) {
        print(categories[row])
    }

    func insertQuery(name: String, price: Double, category: String, qty: Int) {
        let insertSQL =
            "INSERT INTO ShoppingList(itemName, itemPrice, Category, Quantity) VALUES (?, ?, ?, ?)"
        var queryStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, insertSQL, -1, &queryStatement, nil)
            == SQLITE_OK
        {
            sqlite3_bind_text(
                queryStatement,
                1,
                (name as NSString).utf8String,
                -1,
                nil
            )
            sqlite3_bind_double(queryStatement, 2, price)
            sqlite3_bind_text(
                queryStatement,
                3,
                (category as NSString).utf8String,
                -1,
                nil
            )
            sqlite3_bind_int(queryStatement, 4, Int32(qty))

            if sqlite3_step(queryStatement) == SQLITE_DONE {
                messageLabel.text = "Item Added!"
            } else {
                messageLabel.text = "Cannot add item!"
            }
        } else {
            print("Insert statement could not be prepared")
            messageLabel.text = "Failed to add item."
        }

        sqlite3_finalize(queryStatement)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //        ItemNameTF.keyboardType = .default
        //        priceTF.keyboardType = .decimalPad

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = Colour.sharedInstance.selectedColour
    }

    @IBAction func addClicked(_ sender: UIButton) {
        guard let itemName = ItemNameTF.text, !itemName.isEmpty else {
            messageLabel.text = "Please enter item name"
            return
        }
        guard let itemPrice = priceTF.text, !itemPrice.isEmpty else {
            messageLabel.text = "Please enter price"
            return
        }
        guard let itemPrice = Double(priceTF.text!), itemPrice > 0 else {
            messageLabel.text = "Please enter valid price"
            return
        }
        guard let itemQty = Int(qtyTF.text!), itemQty > 0 else {
            messageLabel.text = "Please enter quantity"
            return
        }

        let itemCategory = categories[categoryPV.selectedRow(inComponent: 0)]
        if sqlite3_open(appDelegate.getDBPath(), &db) == SQLITE_OK {
            insertQuery(
                name: itemName,
                price: itemPrice,
                category: itemCategory,
                qty: itemQty
            )
            let i = Item(
                name: itemName,
                price: itemPrice,
                category: itemCategory,
                qty: itemQty
            )
            appDelegate.itemArray.append(i)
            sqlite3_close(db)
            messageLabel.text = "Item added successfully"
            ItemNameTF.text = ""
            priceTF.text = ""
            qtyTF.text = ""
        } else {
            print("Unable to open database")
        }

        //            //Displaying using an Alert Conroller
        //            let alertController = UIAlertController(
        //                title: "",
        //                message: "Can not be blank",
        //                preferredStyle: .alert
        //            )
        //
        //            //Define an action
        //            let alertAction = UIAlertAction(
        //                title: "Ok",
        //                style: .default,
        //                handler: nil
        //            )
        //            //Add an action - Action Styles: .default, .cancel, .distructive
        //            alertController.addAction(alertAction)
        //            //Display the alert to the user
        //            self.present(alertController, animated: true, completion: nil)
        //
        //            return
    }
}

/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
}
*/
