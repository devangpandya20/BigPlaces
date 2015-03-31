//
//  SecondViewController.h
//  BigPlaces
//
//  Created by Devang Pandya on 30/03/15.
//  Copyright (c) 2015 Devang Pandya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>



@interface SecondViewController : UIViewController<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@end

