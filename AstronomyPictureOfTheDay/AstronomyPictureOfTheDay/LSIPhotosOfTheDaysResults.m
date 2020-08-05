//
//  LSIPhotosOfTheDaysResults.m
//  AstronomyPictureOfTheDay
//
//  Created by Kelson Hartle on 8/3/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import "LSIPhotosOfTheDaysResults.h"
#import "LSIPhotoOfTheDay.h"

@implementation LSIPhotosOfTheDaysResults

//-(instancetype)init {
//    self = [super init];
//    if (self) {
//        _photosOfTheDay = [[NSMutableArray alloc]init];
//    }
//    return self;
//}

-(instancetype)initWithPhotos:(NSArray<LSIPhotoOfTheDay *> *)photos {
    self = [super init];
    if (self) {
        _photosOfTheDay = photos;
    }
    return self;
}

- (instancetype)initWithArray:(NSArray *)array {
    
    NSMutableArray *photosArray = [[NSMutableArray alloc]init];
    
    for (NSDictionary *photoDictionary in array) {
        LSIPhotoOfTheDay *photo =[[LSIPhotoOfTheDay alloc]initWithDictionary:photoDictionary];
        
        if (photo) {
            [photosArray addObject:photo];
        } else {
            NSLog(@"Unable to parse picture dictionary: %@", self.photosTemporary);
        }
    }
    
    self = [self initWithPhotos:photosArray];
    NSLog(@"🎁%lu",(unsigned long)self.photosOfTheDay.count);
    return self;
}




@end
