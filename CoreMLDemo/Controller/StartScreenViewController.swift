//
//  StartScreen.swift
//  CoreMLDemo
//
//  Created by Максим Алексеев on 24/12/2018.
//  Copyright © 2018 Максим Алексеев. All rights reserved.
//

import UIKit

enum CellClassificationType {
    case TextClassification
    case ImageClassification
    case TouchlessUIClassification
    case SpeechClassification
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
        switch items[indexPath.row].classificationType {
        case .ImageClassification:
            guard let navigationController = storyboard?.instantiateViewController(identifier: "NavigationImageClassifer") else { return }
               present(navigationController, animated: true, completion: nil)
            
        case .TextClassification:
            guard let navigationController = storyboard?.instantiateViewController(identifier: "NavigationTextClassifer") else { return }
            present(navigationController, animated: true, completion: nil)
            
        case .SpeechClassification:
            guard let navigationController = storyboard?.instantiateViewController(identifier: "speechNC") else { return }
            present(navigationController, animated: true, completion: nil)
            
        case .TouchlessUIClassification:
            guard let navigationController = storyboard?.instantiateViewController(identifier: "GestureUINC") else { return }
            present(navigationController, animated: true, completion: nil)
        }
    }
    
    //MARK: - Initializators
    required init?(coder aDecoder: NSCoder) {
        items = [StartScreenItem]()
        
        let row0item = StartScreenItem(text: "Text classifer",
                                       emoji: "✍️",
                                       classificationType: .TextClassification)
        items.append(row0item)
        
        let row1item = StartScreenItem(text: "Image classifer",
                                       emoji: "📷",
                                       classificationType: .ImageClassification)
        items.append(row1item)
        
        
        let row2item = StartScreenItem(text: "Touchless UI",
                                       emoji: "👋🏻",
                                       classificationType: .TouchlessUIClassification)
        items.append(row2item)
        
        let row3Item = StartScreenItem(text: "Speech to text",
                                       emoji: "🎤",
                                       classificationType: .SpeechClassification)
        items.append(row3Item)
                
        super.init(coder: aDecoder)
    }
}
