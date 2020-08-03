//
//  LSIPhotoOfTheDay.h
//  AstronomyPictureOfTheDay
//
//  Created by Kelson Hartle on 8/3/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIPhotoOfTheDay : NSObject


@property NSString *title;
@property NSURL *imageURL;
@property NSString *explanation;
@property NSString *date;

-(instancetype)initWithTitle:(NSString *)title
                    imageURL:(NSURL *)url
                 explanation:(NSString *)explanation
                        date:(NSString *)date;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end

NS_ASSUME_NONNULL_END
