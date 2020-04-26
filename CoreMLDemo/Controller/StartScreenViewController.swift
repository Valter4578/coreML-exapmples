//
//  StartScreen.swift
//  CoreMLDemo
//
//  Created by Максим Алексеев on 24/12/2018.
//  Copyright © 2018 Максим Алексеев. All rights reserved.
//

import UIKit

enum CellClassificationType {
    case textClassification
    case imageClassification
    case touchlessUIClassification
    case speechClassification
}

@available(iOS 13.0, *)
class StartScreenViewController: UITableViewController {
    var items = [StartScreenItem]()
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
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
        present(items[indexPath.row].classificationType.viewController, animated: true, completion: nil)
    }
    
    //MARK: - Initializators
    required init?(coder aDecoder: NSCoder) {
        items = [StartScreenItem]()
        
        let row0item = StartScreenItem(text: "Text classifer",
                                       emoji: "✍️",
                                       classificationType: .textClassification)
        items.append(row0item)
        
        let row1item = StartScreenItem(text: "Image classifer",
                                       emoji: "📷",
                                       classificationType: .imageClassification)
        items.append(row1item)
        
        
        let row2item = StartScreenItem(text: "Touchless UI",
                                       emoji: "👋🏻",
                                       classificationType: .touchlessUIClassification)
        items.append(row2item)
        
        let row3Item = StartScreenItem(text: "Speech to text",
                                       emoji: "🎤",
                                       classificationType: .speechClassification)
        items.append(row3Item)
                
        super.init(coder: aDecoder)
    }
}

@available(iOS 13.0, *)
private extension CellClassificationType {
    var viewController: UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        switch self {
        case .imageClassification:
            return storyboard.instantiateViewController(identifier: "NavigationImageClassifer")
        case .textClassification:
            return storyboard.instantiateViewController(identifier: "NavigationTextClassifer")
        case .touchlessUIClassification:
            return storyboard.instantiateViewController(identifier: "GestureUINC")
        case .speechClassification:
            return storyboard.instantiateViewController(identifier: "speechNC")
        }
    }
}
