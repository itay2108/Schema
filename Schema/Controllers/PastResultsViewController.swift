//
//  PastResultsViewController.swift
//  YSQ
//
//  Created by itay gervash on 15/02/2020.
//  Copyright © 2020 Lazy Bear Apps. All rights reserved.
//

import UIKit
import RealmSwift

class PastResultsViewController: BetterUIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noResultsLabel: UILabel!
    
    var indexPathRow: Int?
    let realm = try! Realm()
    var savedResults: Results<SavedResult>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SettingsBundleHandler.shared.delegate = self
        SettingsBundleHandler.shared.setupNotificationObserver()

        fetchFromrealm()
        
    }
    
    func fetchFromrealm() {
        savedResults = realm.objects(SavedResult.self).sorted(byKeyPath: "date", ascending: false)
    }
    
    func clearCollectionViewBackgroundColorIfNoResults() {
        if let count = savedResults?.count {
            if count == 0 {
                collectionView.backgroundColor = .clear
            }
        }
    }
    
}

// MARK: - CollectionView Delegate and Datasource methods
extension PastResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SavedResultCell", for: indexPath) as! SavedResultCell
        if let result = savedResults?[indexPath.item] {
            cell.setData(with: result)
        }
        
        cell.layer.borderColor = CGColor(srgbRed: 0, green: 122/255, blue: 1, alpha: 1)
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 15
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        indexPathRow = indexPath.row
        
        performSegue(withIdentifier: "SavedResultstoResults", sender: self)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        clearCollectionViewBackgroundColorIfNoResults()
        return savedResults?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width/2.5 , height: collectionView.frame.width/2.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.frame.height/12.5
    }

//MARK: - ContextMenu for collection view cell configuration methods
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let result = savedResults![indexPath.row]
        
        let identifier = "\(indexPath.row)" as NSString
        
        let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
            
            let alert = UIAlertController(title: "Delete \(result.name)'s results?", message: "This cannot be undone", preferredStyle: .alert)
            
            let deleteButton = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                self.deleteResult(result)
                self.clearCollectionViewBackgroundColorIfNoResults()
                
            }
            
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
            }
            
            alert.addAction(deleteButton)
            alert.addAction(cancelButton)
            self.present(alert, animated: true)
            
        }
        
        let editAction = UIAction(title: "Edit Name", image: UIImage(systemName: "pencil.and.ellipsis.rectangle")) { _ in
            
            var textField = UITextField()
            
            let alert = UIAlertController(title: "Edit Name", message: "", preferredStyle: .alert)
            
            let saveBtn = UIAlertAction(title: "Save", style: .default) { (action) in
                
                do {
                    try self.realm.write {
                        if let newName = textField.text {
                           result.name = newName
                        }
                    }
                    collectionView.reloadData()
                } catch {
                    print("error saving result to realm \(error)")
                }
            }
            
            let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
            }
            
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "\(result.name)"
                textField = alertTextField
            }
            
            alert.addAction(saveBtn)
            alert.addAction(cancelBtn)
            
            self.present(alert, animated: true)
            
        }
        
        return UIContextMenuConfiguration( identifier: identifier, previewProvider: nil, actionProvider: { _ in let children: [UIMenuElement] = [editAction, deleteAction]
            return UIMenu(title: "", children: children)})

    }
    
    func collectionView(_ collectionView: UICollectionView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
      
        guard
          let identifier = configuration.identifier as? String,
          let index = Int(identifier)
          else {
            return
        }
        
        if let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) {
            if let indexPath = collectionView.indexPath(for: cell) {
        indexPathRow = indexPath.row
      
              animator.addCompletion {
                self.performSegue(
                  withIdentifier: "SavedResultstoResults", sender: cell)
              }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ResultsViewController
        if let safeIndexPathRow = indexPathRow {
            destination.pastResults = savedResults?[safeIndexPathRow].result ?? List<Int>()
        }
    }
    
//MARK: - ContextMenu action handling methods
    
    func deleteResult(_ result: SavedResult) {
        do {
            try realm.write {
                realm.delete(result)
            }
            collectionView.reloadData()
        } catch {
            print("error deleting result \(error)")
        }
    }
    
}
