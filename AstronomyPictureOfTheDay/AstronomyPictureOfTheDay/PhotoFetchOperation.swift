//
//  PhotoFetchOperation.swift
//  AstronomyPictureOfTheDay
//
//  Created by Kelson Hartle on 8/4/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

import Foundation

class FetchPhotoOperation: ConcurrentOperation {
    
    // MARK: Properties
    
    let photoReference: LSIPhotoOfTheDay
    
    private let session: URLSession

    private(set) var imageData: Data?
    
    private var dataTask: URLSessionDataTask?
    
    init(photoReference: LSIPhotoOfTheDay, session: URLSession = URLSession.shared) {
        self.photoReference = photoReference
        self.session = session
        super.init()
    }
 
    override func start() {
        state = .isExecuting
        if let url = photoReference.imageURL {
            let task = session.dataTask(with: url) { (data, response, error) in
                defer { self.state = .isFinished }
                if self.isCancelled { return }
                if let error = error {
                    NSLog("Error fetching data for \(self.photoReference): \(error)")
                    return
                }
                
                self.imageData = data
            }
            task.resume()
            dataTask = task
        }
        
        
    }
    
    override func cancel() {
        dataTask?.cancel()
        super.cancel()
    }
    
    
}
