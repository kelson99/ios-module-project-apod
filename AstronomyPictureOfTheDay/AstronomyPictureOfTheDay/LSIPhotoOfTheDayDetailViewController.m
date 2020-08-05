//
//  PhotoOfTheDayDetailViewController.m
//  AstronomyPictureOfTheDay
//
//  Created by Kelson Hartle on 8/3/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import "LSIPhotoOfTheDayDetailViewController.h"
#import "LSIPhotoOfTheDay.h"
#import "LSISummaryViewController.h"

@interface LSIPhotoOfTheDayDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation LSIPhotoOfTheDayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateViews];
    
}

- (void)updateViews {
    if (self.photo) {
        NSData *data = [[NSData alloc] initWithContentsOfURL:self.photo.imageURL];
        self.imageView.image = [[UIImage alloc]initWithData:data];
        self.title = self.photo.title;
    }
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowSummary"]) {
        LSISummaryViewController *destinationVC = (LSISummaryViewController *)segue.destinationViewController;
        destinationVC.photo = self.photo;
    }
}


@end
