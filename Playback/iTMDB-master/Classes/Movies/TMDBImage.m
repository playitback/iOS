//
//  TMDBImage.m
//  iTMDb
//
//  Created by Alessio Moiso on 14/01/13.
//  Copyright (c) 2013 MrAsterisco. All rights reserved.
//

#import "TMDBImage.h"

@interface TMDBImage ()

@property BOOL isCancelled;

@end

@implementation TMDBImage

+ (TMDBImage*)imageWithDictionary:(NSDictionary*)image context:(TMDB*)aContext delegate:(id<TMDBImageDelegate>)del andContextInfo:(id)contextInf {
    return [[TMDBImage alloc] initWithAddress:[image valueForKey:@"file_path"] context:aContext delegate:del andContextInfo:contextInf];
}

- (id)initWithAddress:(NSURL*)address context:(TMDB*)aContext delegate:(id<TMDBImageDelegate>)del andContextInfo:(id)contextInf {
    if (self = [super init]) {
        _address = address;
        _context = aContext;
        _delegate = del;
        _contextInfo = contextInf;
        
        NSURL *url = [NSURL URLWithString:[API_URL_BASE stringByAppendingFormat:@"%.1d/configuration?api_key=%@",
                                           API_VERSION, aContext.apiKey]];
        _configurationRequest = [TMDBRequest requestWithURL:url delegate:self];
        _isCancelled = NO;
    }
    return self;
}

- (void)dealloc {
    _address = nil;
    _configurationRequest = nil;
    _context = nil;
    _delegate = nil;
    _contextInfo = nil;
}

- (void)cancel {
    self.isCancelled = YES;
}

#pragma mark -
#pragma mark TMDBRequestDelegate

- (void)request:(TMDBRequest *)request didFinishLoading:(NSError *)error {
    UIImage *image = nil;
    
    if (!self.isCancelled) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
        
        if (request != nil) {
            self.context.configuration = [[request parsedData] valueForKey:@"images"];
        }
        
        NSURL *finalURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", [self.context.configuration valueForKey:@"base_url"], @"original", self.address]];
		NSData* data = [[NSData alloc] initWithContentsOfURL:finalURL];
		image = [UIImage imageWithData:data];
    }
    _configurationRequest = nil;
    
    if (_delegate) {
        [self.delegate tmdbImageInContext:self.context didFinishLoading:image];
    }
}

@end
