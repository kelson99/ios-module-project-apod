//
//  PhotosOfTheDayCollectionViewController.h
//  AstronomyPictureOfTheDay
//
//  Created by Kelson Hartle on 8/3/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSIPhotoOfTheDayController;
@class LSIPhotoOfTheDay;

NS_ASSUME_NONNULL_BEGIN

@interface LSIPhotosOfTheDayCollectionViewController : UICollectionViewController
@property (nonatomic) LSIPhotoOfTheDayController *controller;
@property (nonatomic) NSArray<LSIPhotoOfTheDay *> *photosArrayOk;

@end

NS_ASSUME_NONNULL_END
