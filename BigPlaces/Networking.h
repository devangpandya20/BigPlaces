//
//  Networking.h
//  BigPlaces
//
//  Created by Devang Pandya on 30/03/15.
//  Copyright (c) 2015 Devang Pandya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Networking : NSObject
+ (void)getListofPlacesByCategory:(NSString*)categoryName success:(void(^)(id response))successResponse failure:(void(^)(NSError *error))failureResponce;
+ (void)getPlaceImage:(NSString*)photoReference success:(void(^)(id response))successResponse failure:(void(^)(NSError *error))failureResponce;
@end
