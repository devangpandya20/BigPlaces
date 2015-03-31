//
//  Networking.m
//  BigPlaces
//
//  Created by Devang Pandya on 30/03/15.
//  Copyright (c) 2015 Devang Pandya. All rights reserved.
//

#import "Networking.h"
#import "LocationService.h"
#import "Place.h"

#define URL_Places     @"https://maps.googleapis.com/maps/api/place/nearbysearch/json"
#define URL_PlaceImage @"https://maps.googleapis.com/maps/api/place/photo"
#define MapsAPIKey @"AIzaSyDVX_3mgU-Gu-BCr7YTXhSoHjUmL4rDgA8"
@implementation Networking
+ (void)getListofPlacesByCategory:(NSString*)categoryName success:(void(^)(id response))successResponse failure:(void(^)(NSError *error))failureResponce{
    float lat =[[[LocationService sharedInstance] currentLocation] coordinate].latitude;
    float lon =[[[LocationService sharedInstance] currentLocation] coordinate].longitude;
    NSString *strRequest = [NSString stringWithFormat:@"%@?location=%f,%f&radius=500&types=%@&key=%@",URL_Places,lat,lon,categoryName,MapsAPIKey];
    NSLog(@"%@",strRequest);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:strRequest]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if ([(NSHTTPURLResponse*)response statusCode]==200) {
            NSError *jsonError = nil;
            id responseData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            if (!jsonError && responseData) {
                NSMutableArray *results = [NSMutableArray array];
                NSArray *array = [responseData objectForKey:@"results"];
                    for (NSDictionary *dict in array) {
                        Place *place = [[Place alloc] initWithDictionary:dict];
                        [results addObject:place];
                    }
                successResponse(results);
            }
        }
        else
            failureResponce(connectionError);
    }];
}
+ (void)getPlaceImage:(NSString*)photoReference success:(void(^)(id response))successResponse failure:(void(^)(NSError *error))failureResponce{
    NSString *strRequest = [NSString stringWithFormat:@"%@?maxwidth=400&photoreference=%@&key=%@",URL_PlaceImage,photoReference,MapsAPIKey];
    NSLog(@"%@",strRequest);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:strRequest]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if ([(NSHTTPURLResponse*)response statusCode]==200) {
            successResponse(data);
        }
        else
            failureResponce(connectionError);
    }];
}

@end
