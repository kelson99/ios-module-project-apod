//
//  LSIPhotoOfTheDayController.m
//  AstronomyPictureOfTheDay
//
//  Created by Kelson Hartle on 8/3/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import "LSIPhotoOfTheDayController.h"
#import "LSIPhotoOfTheDay.h"

static NSString *baseURLString = @"https://api.nasa.gov/planetary/apod?api_key=ChsOvogxmESVFiD3lNG0MHy45AaSZQq2A1G7hcea";


@implementation LSIPhotoOfTheDayController

//API_KEY ChsOvogxmESVFiD3lNG0MHy45AaSZQq2A1G7hcea

- (void)fetchPhotoOfTheDayInformationWithDate:(NSString *)date completionBlock:(LSIInformationPhotoOfTheDayFetcher)completionBlock {
    NSLog(@"FETCH 😐");
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:baseURLString];
    
    NSURL *url = urlComponents.URL;
    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"URL: %@",url);
        
        if (error) {
            completionBlock(nil, error);
            return;
        }
        
        if (!data) {
            NSLog(@"No data was returned from server.");
            return;
        }

        NSError *jsonError = nil;
        
        if (jsonError) {
            completionBlock(nil,jsonError);
            return;
        }
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        LSIPhotoOfTheDay *photoOfTheDay = [[LSIPhotoOfTheDay alloc]initWithDictionary:jsonDictionary];
        NSLog(@"Photo of the day: %@", photoOfTheDay.title);
        
        
    }];
    
    [task resume];
    
    
}


- (void)fetchPhotoOfTheDayWithURL:(NSURL *)url completionBlock:(LSIPhotoOfTheDayFetcher)completionBlock {
    
    
    
}








@end
