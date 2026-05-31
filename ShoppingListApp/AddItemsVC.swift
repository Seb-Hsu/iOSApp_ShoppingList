//
//  AddItemsVC.swift
//  ShoppingListApp
//
//  Created by Sebastian Hsu on 23/3/2026.
//

import UIKit

class AddItemsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{

    @IBOutlet weak var ItemNameTF: UITextField!

    @IBOutlet weak var priceTF: UITextField!

    @IBOutlet weak var categoryPV: UIPickerView!

    let categories = ["Grocery", "Stationery", "Clothing"]

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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        ItemNameTF.keyboardType = .default
//        priceTF.keyboardType = .decimalPad
    }

    @IBAction func addClicked(_ sender: UIButton) {
        guard let itemName = ItemNameTF.text, !itemName.isEmpty,
            let priceText = priceTF.text, !priceText.isEmpty,
            let price = Double(priceText)
        else {

            //Displaying using an Alert Conroller
            let alertController = UIAlertController(
                title: "Hello",
                message: "Can not be blank",
                preferredStyle: .alert
            )
            
            //Define an action
            let alertAction = UIAlertAction(
                title: "Ok",
                style: .default,
                handler: nil
            )
            //Add an action - Action Styles: .default, .cancel, .distructive
            alertController.addAction(alertAction)
            //Display the alert to the user
            self.present(alertController, animated: true, completion: nil)
            
            return
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

}
