//
//  CommentedOutCode.swift
//  Schema
//
//  Created by itay gervash on 22/02/2020.
//  Copyright © 2020 Lazy Bear Apps. All rights reserved.
//

// MARK: - LongPressGestureRecognizer (replaced with contextual interactions)

       //In ViewDidLoad >>>
    //        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress(_:)))
    //        gesture.minimumPressDuration = 0.25
    //        gesture.delaysTouchesBegan = true
    //        self.collectionView.addGestureRecognizer(gesture)

//    @objc public func handleLongPress(_ gesture: UILongPressGestureRecognizer!) {
//        if gesture.state != .began {
//            return
//        }
//        let point = gesture.location(in: self.collectionView)
//        let indexPath = self.collectionView.indexPathForItem(at: point)
//
//        if let indexPath = indexPath {
//
//            let cell = self.collectionView.cellForItem(at: indexPath)
//
//            let menu = UIMenuController.shared
//            becomeFirstResponder()
//
//            let deleteItem = UIMenuItem(title: "Delete", action: #selector(handleDeleteAction))
//            menu.menuItems = [deleteItem]
//            let location = gesture.location(in: view)
//            let menuLocation = CGRect(x: location.x, y: location.y, width: 100, height: 15)
//            menu.showMenu(from: gesture.view!, rect: menuLocation)
//
//            print("working")
//        } else {
//            print("Could not find index path")
//        }
//    }
//
//    @objc func handleDeleteAction() {
//        print("delete")
//    }

//MARK: - preview for contectual interaction

//    func createResultsPreview(_ result: SavedResult) -> UIViewController {
//        let vc = ResultsViewController()
//        vc.pastResults = result.result
//
//        return vc
//    }
    
//    func collectionView(_ collectionView: UICollectionView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
//
//      guard let identifier = configuration.identifier as? String,
//            let index = Int(identifier)
//      else { return nil }
//
//        let preview = UITargetedPreview(view: self.collectionView.cellForItem(at: IndexPath(item: index, section: 0))!.contentView)
//
//        return preview
//        }
