//
//  Place.m
//  BigPlaces
//
//  Created by Devang Pandya on 01/04/15.
//  Copyright (c) 2015 Devang Pandya. All rights reserved.
//

#import "Place.h"

@implementation Place
- (instancetype)initWithDictionary:(NSDictionary*)placeDict
{
    self = [super init];
    if (self) {
        self.placeID = [placeDict objectForKey:@"place_id"];
        self.placeName = [placeDict objectForKey:@"name"];
        self.placeAddress = [placeDict objectForKey:@"vicinity"];
        
        NSDictionary *location = [[placeDict objectForKey:@"geometry"] objectForKey:@"location"];
        self.placeLocation = CLLocationCoordinate2DMake([[location objectForKey:@"lat"] doubleValue],[[location objectForKey:@"lng"] doubleValue]);
        
        self.placeRating = [[placeDict objectForKey:@"rating"] floatValue];
        self.placeImage = [placeDict objectForKey:@"icon"];
        NSArray *photos = [placeDict objectForKey:@"photos"];
        self.placePhotoRef = [[photos objectAtIndex:0] objectForKey:@"photo_reference"];
        
    }
    return self;
}
@end
