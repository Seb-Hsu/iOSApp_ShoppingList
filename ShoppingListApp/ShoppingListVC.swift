//
//  ShoppingListVC.swift
//  ShoppingListApp
//
//  Created by Sebastian Hsu on 23/3/2026.
//
//

import UIKit

class ShoppingListVC: UIViewController, UITableViewDelegate,
    UITableViewDataSource
{

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var itemArray: [Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        itemArray = appDelegate.itemArray.sorted(by: { $0.name < $1.name })  //sort asscending
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return itemArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell",
            for: indexPath as IndexPath
        )

        var config = UIListContentConfiguration.cell()

        let item: Item = itemArray[indexPath.row]

        config.text = item.name
        config.secondaryText = item.toString()
        config.image = UIImage(named: item.imageName)
        config.imageProperties.maximumSize = CGSize(width: 36, height: 36)
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
            appDelegate.itemArray.remove(at: indexPath.row)
            itemArray = appDelegate.itemArray.sorted(by: { $0.name < $1.name })
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            //create a new instance of appropriate class, insert it into the array, and ass a new row to the table view
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
