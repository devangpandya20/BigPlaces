//
//  PlaceDetailViewController.h
//  BigPlaces
//
//  Created by Devang Pandya on 01/04/15.
//  Copyright (c) 2015 Devang Pandya. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Place;
@interface PlaceDetailViewController : UIViewController
@property (weak,nonatomic) Place *place;
@end
