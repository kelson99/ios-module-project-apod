//
//  LSIPhotosCollectionViewController.swift
//  AstronomyPictureOfTheDay
//
//  Created by Kelson Hartle on 8/4/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

import UIKit

class LSIPhotosCollectionViewController: UICollectionViewController {
    
    @objc var controller: LSIPhotoOfTheDayController?
    private let cache = Cache<String, UIImage>()
    private let photoFetchQueue = OperationQueue()
    private let imageFilteringQueue = OperationQueue()
    private var operations = [String : Operation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
            guard let destinationVC = segue.destination as? LSIPhotoOfTheDayDetailViewController else { return }
            guard let photo = self.controller?.arrayOfPhotoResultsFromControllerToDisplay[indexPath.item] else { return }
            
            destinationVC.photo = photo
            
        }
    }


    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        print("COUNT: \(controller?.arrayOfPhotoResultsFromControllerToDisplay.count)")
        return controller?.arrayOfPhotoResultsFromControllerToDisplay.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? LSIPhotoCollectionViewCell ?? LSIPhotoCollectionViewCell()
            
        loadImage(forCell: cell, forItemAt: indexPath)
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
//        var totalUsableWidth = collectionView.frame.width
//        let inset = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: indexPath.section)
//        totalUsableWidth -= inset.left + inset.right
//
//        let minWidth: CGFloat = 150.0
//        let numberOfItemsInOneRow = Int(totalUsableWidth / minWidth)
//        totalUsableWidth -= CGFloat(numberOfItemsInOneRow - 1) * flowLayout.minimumInteritemSpacing
//        let width = totalUsableWidth / CGFloat(numberOfItemsInOneRow)
//        return CGSize(width: width, height: width)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 10.0, bottom: 0, right: 10.0)
//    }

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    private func loadImage(forCell cell: LSIPhotoCollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let photoReference = self.controller?.arrayOfPhotoResultsFromControllerToDisplay[indexPath.item] else { return }
         
        let fetchImageOperation = FetchPhotoOperation(photoReference: photoReference)
        let filterOP = FilterImageOperation(fetchOperation: fetchImageOperation)
        
        let cacheOp = BlockOperation {
            if let image = filterOP.image {
                self.cache.cache(value: image, for: photoReference.date)
            }
        }
        
        filterOP.completionBlock = {
            NSLog("Filter operation finished")
        }
        
        let completionOp = BlockOperation {
            NSLog("Completed")
            
            
            defer { self.operations.removeValue(forKey: photoReference.date) }
            
            if let currentIndexPath = self.collectionView?.indexPath(for: cell),
                currentIndexPath != indexPath {
                return // Cell has been reused
            }
            
            if let image = filterOP.image {
                cell.imageView.image = image
            }
        }
        
        filterOP.addDependency(fetchImageOperation)
        cacheOp.addDependency(filterOP)
        completionOp.addDependency(filterOP)
        
        photoFetchQueue.addOperation(fetchImageOperation)
        photoFetchQueue.addOperation(cacheOp)
        imageFilteringQueue.addOperation(filterOP)
        OperationQueue.main.addOperation(completionOp)
        
        operations[photoReference.date] = fetchImageOperation
        
    }

}
