//
//  StartScreen.swift
//  CoreMLDemo
//
//  Created by Максим Алексеев on 24/12/2018.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import UIKit

class StartScreenViewController: UITableViewController {
    var items: [StartScreenItem]
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExampelItem", for: indexPath)
        let item = items[indexPath.row]
        configureText(for: cell, with: item)
        return cell
    }
    
    
    
    func configureText(for cell: UITableViewCell, with item: StartScreenItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectRow = items[indexPath.row]
        print(selectRow)
        if selectRow.text == "Text classifer✍️" {
            performSegue(withIdentifier: "showDocumentClassification", sender: self)
        } else if selectRow.text == "Image classifer📷" {
            performSegue(withIdentifier: "showImageClassification", sender: self)
        }
    }
    
    
    //MARK: - Initializators
    required init?(coder aDecoder: NSCoder) {
        items = [StartScreenItem]()
        
        let row0item = StartScreenItem()
        row0item.text = "Text classifer✍️"
        items.append(row0item)
        
        let row1item = StartScreenItem()
        row1item.text = "Image classifer📷"
        items.append(row1item)
        
        super.init(coder: aDecoder)
    }
}
