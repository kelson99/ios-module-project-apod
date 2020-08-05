//
//  LSIPhotoOfTheDayController.m
//  AstronomyPictureOfTheDay
//
//  Created by Kelson Hartle on 8/3/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import "LSIPhotoOfTheDayController.h"
#import "LSIPhotoOfTheDay.h"
#import "LSIPhotosOfTheDaysResults.h"


@interface LSIPhotoOfTheDayController ()

@property (nonatomic) LSIPhotosOfTheDaysResults *photoResults;
//@property (nonatomic) NSArray<LSIPhotoOfTheDay *> *arrayOfPhotoResultsFromControllerToDisplay;

@end

@implementation LSIPhotoOfTheDayController

//https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&start_date=2020-01-01&end_date=2020-03-01

//https://api.nasa.gov/planetary/apod?api_key=ChsOvogxmESVFiD3lNG0MHy45AaSZQq2A1G7hcea&start_date=2020-01-01&end_date=2020-02-01

- (void)fetchPhotoOfTheDayInformationWithDate:(NSString *)startDate endDate:(NSString *)endDate
completionBlock:(LSIInformationPhotoOfTheDayFetcher)completionBlock {
    NSLog(@"FETCH 😐");
    
    NSURL *url = [[self class] urlForPhotoInfo:startDate endDate:endDate];
    
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
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        LSIPhotosOfTheDaysResults *photoResults = [[LSIPhotosOfTheDaysResults alloc]initWithArray:jsonArray];
        completionBlock(photoResults.photosOfTheDay,nil);
        
        self.arrayOfPhotoResultsFromControllerToDisplay = photoResults.photosOfTheDay;
        
        NSLog(@"%lu ⏱",(unsigned long)self.arrayOfPhotoResultsFromControllerToDisplay.count);
    }];
    
    [task resume];
    
    
}

- (void)fetchPhotoOfTheDayWithURL:(NSURL *)url completionBlock:(LSIPhotoOfTheDayFetcher)completionBlock {

}

+(NSURL *)baseURL {
    return [NSURL URLWithString:@"https://api.nasa.gov/planetary/apod"];
}
+(NSString *)apiKey {
    
    return @"ChsOvogxmESVFiD3lNG0MHy45AaSZQq2A1G7hcea";
}

+(NSURL *)urlForPhotoInfo:(NSString *)startDate endDate:(NSString *)endDate {
    
    NSURL *url = [self baseURL];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[[NSURLQueryItem queryItemWithName:@"api_key" value:[self apiKey]],
    [NSURLQueryItem queryItemWithName:@"start_date" value:startDate],
    [NSURLQueryItem queryItemWithName:@"end_date" value:endDate]
    ];
    return urlComponents.URL;
    
}

@end
