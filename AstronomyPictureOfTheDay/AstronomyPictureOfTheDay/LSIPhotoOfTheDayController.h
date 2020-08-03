//
//  LSIPhotoOfTheDayController.h
//  AstronomyPictureOfTheDay
//
//  Created by Kelson Hartle on 8/3/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSIPhotoOfTheDay;

typedef void (^LSIInformationPhotoOfTheDayFetcher)(LSIPhotoOfTheDay * _Nullable information, NSError * _Nullable error);
typedef void (^LSIPhotoOfTheDayFetcher)(NSURL * _Nullable url, NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface LSIPhotoOfTheDayController : NSObject

- (void)fetchPhotoOfTheDayInformationWithDate:(NSString *)date
                              completionBlock:(LSIInformationPhotoOfTheDayFetcher)completionBlock;

-(void)fetchPhotoOfTheDayWithURL:(NSURL *)url
                  completionBlock:(LSIPhotoOfTheDayFetcher)completionBlock;

@end

NS_ASSUME_NONNULL_END
