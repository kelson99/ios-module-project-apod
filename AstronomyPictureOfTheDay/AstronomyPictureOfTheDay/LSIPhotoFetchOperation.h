//
//  LSIPhotoFetchOperation.h
//  AstronomyPictureOfTheDay
//
//  Created by Kelson Hartle on 8/4/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSIPhotoOfTheDay;

NS_ASSUME_NONNULL_BEGIN

@interface LSIPhotoFetchOperation : NSOperation

-(void)finish;

@property (nonatomic, copy, readonly, nullable) NSData* imageData;

- (nonnull instancetype)initWithPhotoReference:(LSIPhotoOfTheDay *_Nonnull)photoReference;


@end

NS_ASSUME_NONNULL_END
