//
//  PlacesListTableViewController.m
//  BigPlaces
//
//  Created by Devang Pandya on 31/03/15.
//  Copyright (c) 2015 Devang Pandya. All rights reserved.
//

#import "PlacesListTableViewController.h"
#import "Networking.h"
#import "UIAlertView+Utils.h"
#import "Place.h"
#import "PlaceDetailViewController.h"
@interface PlacesListTableViewController ()
@property (nonatomic,strong) NSArray *arrPlaces;
@end

@implementation PlacesListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [Networking getListofPlacesByCategory:self.category success:^(id response) {
         self.arrPlaces = response;
         [self.tableView reloadData];
     } failure:^(NSError *error) {
         
     }];
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
    return self.arrPlaces.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlaceCell" forIndexPath:indexPath];
    Place *placeObj = self.arrPlaces[indexPath.row];
    UILabel *lblTitle = (UILabel*)[cell viewWithTag:2];
    lblTitle.text  = placeObj.placeName;
    
    UIImageView *imgView = (UIImageView*)[cell viewWithTag:1];
    imgView.image = nil;

    dispatch_queue_t  kBgQueue = dispatch_queue_create("com.imgdownloadqueue", NULL);
    dispatch_async(kBgQueue, ^{
        
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:placeObj.placeImage]];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedPlace = self.arrPlaces[indexPath.row];
    [self performSegueWithIdentifier:@"showPlaceDetail" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showPlaceDetail"]) {
        PlaceDetailViewController *placesListVC = (PlaceDetailViewController *)[segue destinationViewController];
        placesListVC.place = self.selectedPlace;
    }
}





@end
