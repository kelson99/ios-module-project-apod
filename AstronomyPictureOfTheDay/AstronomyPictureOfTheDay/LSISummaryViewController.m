//
//  LSISummaryViewController.m
//  AstronomyPictureOfTheDay
//
//  Created by Kelson Hartle on 8/5/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import "LSISummaryViewController.h"
#import "LSIPhotoOfTheDay.h"

@interface LSISummaryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation LSISummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateViews];
}

-(void)updateViews {
    if (self.photo) {
        self.textView.text = self.photo.explanation;
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
