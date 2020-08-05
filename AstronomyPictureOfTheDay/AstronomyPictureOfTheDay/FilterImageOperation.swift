//
//  FilterImageOperation.swift
//  AstronomyPictureOfTheDay
//
//  Created by Kelson Hartle on 8/4/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

import Foundation
import UIKit

class FilterImageOperation: Operation {
    init(fetchOperation: FetchPhotoOperation) {
        self.fetchOperation = fetchOperation
    }
    
    override func main() {
        if let data = fetchOperation.imageData,
            let image = UIImage(data: data) {
            self.image = image.filtered()
            NSLog("Finished filtering image")
        }
    }
    
    let fetchOperation: FetchPhotoOperation
    private(set) var image: UIImage?
}


