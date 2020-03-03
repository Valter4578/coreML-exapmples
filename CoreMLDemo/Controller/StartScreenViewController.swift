//
//  StartScreen.swift
//  CoreMLDemo
//
//  Created by Максим Алексеев on 24/12/2018.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class StartScreenViewController: UITableViewController {
    var items: [StartScreenItem]
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        print("Here 1")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let item = items[indexPath.row]
        cell.emojiLabel.text = item.emoji
        cell.titleLabel.text = item.text
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch items[indexPath.row].text {
        case "Text classifer":
            guard let navigationController = storyboard?.instantiateViewController(identifier: "NavigationTextClassifer") else { return }
            present(navigationController, animated: true, completion: nil)
        
        case "Image classifer":
            guard let navigationController = storyboard?.instantiateViewController(identifier: "NavigationImageClassifer") else { return }
            present(navigationController, animated: true, completion: nil)
        
        case "Food classifier":
            guard let navigationController = storyboard?.instantiateViewController(identifier: "NavigationFoodClassifer") else { return }
            present(navigationController, animated: true, completion: nil)
        case "Touchless UI":
            //TODO: - Add identifier
            guard let navigationController = storyboard?.instantiateViewController(identifier: "GestureUINC") else { return }
            present(navigationController, animated: true, completion: nil)
        default:
            print("presentation error")
        }
    }
    
    
    
    //MARK: - Initializators
    required init?(coder aDecoder: NSCoder) {
        items = [StartScreenItem]()
        
        let row0item = StartScreenItem()
        row0item.text = "Text classifer"
        row0item.emoji = "✍️"
        items.append(row0item)
        
        let row1item = StartScreenItem()
        row1item.text = "Image classifer"
        row1item.emoji = "📷"
        items.append(row1item)
        
        let row2item = StartScreenItem()
        row2item.text = "Food classifier"
        row2item.emoji = "🍽"
        items.append(row2item)
        
        let row3item = StartScreenItem()
        row3item.text = "Touchless UI"
        row3item.emoji =  "👋🏻"
        items.append(row3item)
        
        print("Here")
        
        super.init(coder: aDecoder)
    }
}
