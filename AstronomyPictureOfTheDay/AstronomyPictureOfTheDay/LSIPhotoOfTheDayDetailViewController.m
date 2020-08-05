//
//  PhotoOfTheDayDetailViewController.m
//  AstronomyPictureOfTheDay
//
//  Created by Kelson Hartle on 8/3/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import "LSIPhotoOfTheDayDetailViewController.h"
#import "LSIPhotoOfTheDay.h"

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

    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
