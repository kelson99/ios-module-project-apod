//
//  LSISplashScreenViewController.m
//  AstronomyPictureOfTheDay
//
//  Created by Kelson Hartle on 8/4/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import "LSISplashScreenViewController.h"
#import "LSIPhotoOfTheDayController.h"
#import "LSIPhotoOfTheDay.h"
#import "LSIPhotosOfTheDayCollectionViewController.h"
#import "AstronomyPictureOfTheDay-Swift.h"

@interface LSISplashScreenViewController ()

@property (nonatomic) LSIPhotoOfTheDayController *controller;
@property (nonatomic) NSArray<LSIPhotoOfTheDay *> *arrayPractice;

@end

@implementation LSISplashScreenViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self doNetworkingStuff];
    
}

- (void)doNetworkingStuff {
    [self.controller fetchPhotoOfTheDayInformationWithDate:@"2020-03-01" endDate:@"2020-04-01" completionBlock:^(NSArray<LSIPhotoOfTheDay *> * _Nullable information, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Photo Fetching Error: %@", error);
            return;
        }
        
        NSLog(@"Photos: %ld", information.count);
        
        self.arrayPractice = information;
        NSLog(@"PHOTOS: %lu", (unsigned long)self.arrayPractice.count);
        
    }];
}

- (LSIPhotoOfTheDayController *)controller {
    if (!_controller) {
        _controller = [[LSIPhotoOfTheDayController alloc]init];
    }
    return _controller;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"CollectionView"]) {
        LSIPhotosCollectionViewController *destinationVc = (LSIPhotosCollectionViewController *)segue.destinationViewController;
        
        destinationVc.controller = self.controller;
        //destinationVc.photosArrayOk = self.arrayPractice;
    }
    
    
}


@end
