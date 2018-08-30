//
//  ContactDataSource.swift
//  ExpandableCells
//
//  Created by Aleksander Kania on 30.04.2017.
//  Copyright © 2017 Aleksander Kania. All rights reserved.
//

import UIKit

final class DataSource: NSObject, UITableViewDataSource {
    private let cellIdentifier = "languageCell"
    
    fileprivate var items: [ProgrammingLanguage] = [
        ProgrammingLanguage(name: "Swift", description: "For students, learning Swift has been a great introduction to modern programming concepts and best practices. And because it is now open, their Swift skills will be able to be applied to an even broader range of platforms, from mobile devices to the desktop to the cloud.", icon: #imageLiteral(resourceName: "swift")),
        ProgrammingLanguage(name: "Python", description: "Python is powerful... and fast; plays well with others; runs everywhere; is friendly & easy to learn; is Open.", icon: #imageLiteral(resourceName: "python")),
        ProgrammingLanguage(name: "Angular JS", description: "From prototype through global deployment, Angular delivers the productivity and scalable infrastructure that supports Google's largest applications.", icon: #imageLiteral(resourceName: "angular")),
    ]
    
    fileprivate var indexPaths: Set<IndexPath> = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! LanguageCell
        
        let programmingLanguageName = self[indexPath].name
        let description = self[indexPath].description
        let icon = self[indexPath].icon
        
        cell.update(
            name: programmingLanguageName,
            description: description,
            logo: icon
        )

        cell.state = cellIsExpanded(at: indexPath) ? .expanded : .collapsed
    
        return cell
    }
}

extension DataSource {
    func cellIsExpanded(at indexPath: IndexPath) -> Bool {
        return indexPaths.contains(indexPath)
    }
    
    func addExpandedIndexPath(_ indexPath: IndexPath) {
        indexPaths.insert(indexPath)
    }
    
    func removeExpandedIndexPath(_ indexPath: IndexPath) {
        indexPaths.remove(indexPath)
    }
}

extension DataSource {
    subscript(indexPath: IndexPath) -> ProgrammingLanguage {
        return items[indexPath.row]
    }
}
