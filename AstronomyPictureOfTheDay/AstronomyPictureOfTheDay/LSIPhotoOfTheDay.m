//
//  LSIPhotoOfTheDay.m
//  AstronomyPictureOfTheDay
//
//  Created by Kelson Hartle on 8/3/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import "LSIPhotoOfTheDay.h"

@implementation LSIPhotoOfTheDay

- (instancetype)initWithTitle:(NSString *)title imageURL:(NSURL *)url explanation:(NSString *)explanation date:(NSString *)date {
    
    self = [super init];
    
    if (self) {
        _title = [title copy];
        _imageURL = url;
        _explanation = [explanation copy];
        _date = [date copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    NSString *title = dictionary[@"title"];
    NSString *imageURLString = dictionary[@"hdurl"];
    NSURL *imageURL = [NSURL URLWithString:imageURLString];
    NSString *explanation = dictionary[@"explanation"];
    NSString *date = dictionary[@"date"];
    
    
    
    self = [self initWithTitle:title imageURL:imageURL explanation:explanation date:date];
    return self;
}





@end
