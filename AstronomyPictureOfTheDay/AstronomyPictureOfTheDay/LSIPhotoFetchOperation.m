//
//  LSIPhotoFetchOperation.m
//  AstronomyPictureOfTheDay
//
//  Created by Kelson Hartle on 8/4/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import "LSIPhotoFetchOperation.h"
#import "LSIPhotoOfTheDay.h"
@interface LSIPhotoFetchOperation ()

@property (nonatomic, readwrite) LSIPhotoOfTheDay *photoReference;
@property (nonatomic, copy, nullable) NSData *imageData;
@property (nonatomic, readwrite) NSURLSessionTask *task;

@end


@implementation LSIPhotoFetchOperation

@synthesize ready = _ready;
@synthesize executing = _executing;
@synthesize finished = _finished;

#pragma mark - Init

- (instancetype)initWithPhotoReference:(LSIPhotoOfTheDay *)photoReference {
    self = [super init];
    if (self) {
        _photoReference = photoReference;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _ready = YES;
    }
    
    return self;
}

- (void)setReady:(BOOL)ready
{
    if (_ready != ready)
    {
        [self willChangeValueForKey:NSStringFromSelector(@selector(isReady))];
        _ready = ready;
        [self didChangeValueForKey:NSStringFromSelector(@selector(isReady))];
    }
}

- (BOOL)isAsynchronous {
    return YES;
}

- (BOOL)isReady
{
    return _ready;
}

- (void)setExecuting:(BOOL)executing
{
    if (_executing != executing)
    {
        [self willChangeValueForKey:NSStringFromSelector(@selector(isExecuting))];
        _executing = executing;
        [self didChangeValueForKey:NSStringFromSelector(@selector(isExecuting))];
    }
}

- (BOOL)isExecuting
{
    return _executing;
}

- (void)setFinished:(BOOL)finished
{
    if (_finished != finished)
    {
        [self willChangeValueForKey:NSStringFromSelector(@selector(isFinished))];
        _finished = finished;
        [self didChangeValueForKey:NSStringFromSelector(@selector(isFinished))];
    }
}

- (BOOL)isFinished
{
    return _finished;
}

#pragma mark - Control

- (void)start
{
    if (!self.isExecuting)
    {
        self.ready = NO;
        self.executing = YES;
        self.finished = NO;
        
        NSLog(@"\"%@\" Operation Started.", self.name);
    }
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:self.photoReference.imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching data for \(self.photoReference): %@", error);
            return;
        }
        if (response) {
            NSLog(@"RESPONSE: %@", response);
        }
        self.imageData = data;
        
        self.finished = YES;
    }];

    [task resume];
    self.task = task;
}

- (void)finish
{
    if (self.executing)
    {
        NSLog(@"\"%@\" Operation Finished.", self.name);
        
        self.executing = NO;
        self.finished = YES;
    }
}

@end
