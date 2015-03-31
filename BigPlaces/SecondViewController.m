//
//  SecondViewController.m
//  BigPlaces
//
//  Created by Devang Pandya on 30/03/15.
//  Copyright (c) 2015 Devang Pandya. All rights reserved.
//

#import "SecondViewController.h"
#import "Place.h"
#import "AppDelegate.h"
@interface SecondViewController ()
@property (nonatomic,strong)NSArray *arrFavPlaces;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

    // Do any additional setup after loading the view, typically from a nib.
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Place"];
    NSSortDescriptor *productSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"placename" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[productSortDescriptor]];

    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:appDelegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    NSError *error = nil;
    
    if (![[self fetchedResultsController] performFetch:&error]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    id sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlaceCell" forIndexPath:indexPath];
    NSManagedObject *placeObj = [self.fetchedResultsController objectAtIndexPath:indexPath];
    UILabel *lblTitle = (UILabel*)[cell viewWithTag:2];
    lblTitle.text  = [placeObj valueForKey:@"placename"];
    
    UIImageView *imgView = (UIImageView*)[cell viewWithTag:1];
    imgView.image = nil;
    
    dispatch_queue_t  kBgQueue = dispatch_queue_create("com.imgdownloadqueue", NULL);
    dispatch_async(kBgQueue, ^{
        
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[placeObj valueForKey:@"placeimage"]]];
        if (imgData) {
            UIImage *image = [UIImage imageWithData:imgData];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [imgView setImage:[UIImage imageWithData:imgData]];
                });
            }
        }
    });
    
    return cell;
}



@end
