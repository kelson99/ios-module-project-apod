//
//  LSIPhotosOfTheDaysResults.h
//  AstronomyPictureOfTheDay
//
//  Created by Kelson Hartle on 8/3/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSIPhotoOfTheDay;

NS_ASSUME_NONNULL_BEGIN

@interface LSIPhotosOfTheDaysResults : NSObject
@property (nonatomic, readonly, copy) NSArray<LSIPhotoOfTheDay *> *photosOfTheDay;
@property (nonatomic, readonly)NSMutableArray *photosTemporary;


- (instancetype)initWithPhotos:(NSArray<LSIPhotoOfTheDay *> *)photos;

- (instancetype)initWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
