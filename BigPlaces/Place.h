//
//  Place.h
//  BigPlaces
//
//  Created by Devang Pandya on 01/04/15.
//  Copyright (c) 2015 Devang Pandya. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;
@interface Place : NSObject
@property (strong,nonatomic) NSString *placeID;
@property (strong,nonatomic) NSString *placeName;
@property (strong,nonatomic) NSString *placeImage;
@property (strong,nonatomic) NSString *placePhotoRef;
@property (strong,nonatomic) NSString *placeAddress;
@property (nonatomic) float placeRating;
@property (nonatomic) CLLocationCoordinate2D placeLocation;

- (instancetype)initWithDictionary:(NSDictionary*)placeDict;
@end
