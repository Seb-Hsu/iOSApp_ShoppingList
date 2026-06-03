//
//  SettingsVC.swift
//  ShoppingListApp
//
//  Created by Sebastian Hsu on 23/3/2026.
//

import UIKit

class SettingsVC: UIViewController, UIColorPickerViewControllerDelegate {

    @available(iOS 14.0, *)
    @IBAction func changedClicked(_ sender: UIButton) {

        let picker = UIColorPickerViewController()
        //Setting the Initial Color of the picker
        picker.selectedColor = self.view.backgroundColor!

        //Setting Delegate
        picker.delegate = self

        //Presenting the Color Picker
        self.present(picker, animated: true, completion: nil)

    }

    //Called once you have finished picking the color.
    @available(iOS 14.0, *)
    func colorPickerViewControllerDidFinish(
        _ viewController: UIColorPickerViewController
    ) {

        self.view.backgroundColor = viewController.selectedColor
    }

    //Called on every color selection done in the picker.
    @available(iOS 14.0, *)
    func colorPickerViewControllerDidSelectColor(
        _ viewController: UIColorPickerViewController
    ) {
        self.view.backgroundColor = viewController.selectedColor
        Colour.sharedInstance.selectedColour = self.view.backgroundColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = Colour.sharedInstance.selectedColour
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
