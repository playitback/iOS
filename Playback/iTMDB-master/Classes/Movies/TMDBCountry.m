//
//  TMDBCountry.m
//  iTMDb
//
//  Created by Alessio Moiso on 16/01/13.
//  Copyright (c) 2013 MrAsterisco. All rights reserved.
//

#import "TMDBCountry.h"

@implementation TMDBCountry

+ (TMDBCountry*)countryWithISOCode:(NSString*)code andName:(NSString*)name {
    return [[TMDBCountry alloc] initWithISOCode:code andName:name];
}

- (id)initWithISOCode:(NSString*)code andName:(NSString*)name {
    if (self = [super init]) {
        _isoCode = code;
        _name = name;
    }
    return self;
}

- (void)dealloc {
    _isoCode = nil;
    _name = nil;
}

- (NSString *)description
{
	return self.name;
}

@end
