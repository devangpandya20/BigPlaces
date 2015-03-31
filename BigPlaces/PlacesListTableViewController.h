//
//  PlacesListTableViewController.h
//  BigPlaces
//
//  Created by Devang Pandya on 31/03/15.
//  Copyright (c) 2015 Devang Pandya. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Place;
@interface PlacesListTableViewController : UITableViewController
@property (strong,nonatomic) NSString *category;
@property (weak,nonatomic) Place *selectedPlace;
@end
