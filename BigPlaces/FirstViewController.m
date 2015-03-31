//
//  FirstViewController.m
//  BigPlaces
//
//  Created by Devang Pandya on 30/03/15.
//  Copyright (c) 2015 Devang Pandya. All rights reserved.
//

#import "FirstViewController.h"
#import "Networking.h"
#import "PlacesListTableViewController.h"
@interface FirstViewController ()
@property (strong,nonatomic) NSArray *arrCategories;
@property (copy,nonatomic) NSString *selectedCategory;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrCategories = [NSArray arrayWithObjects:@"food",@"gym",@"school",@"hospital",@"spa",@"restaurant",nil];
//    [Networking getListofPlacesByCategory:@"Food"];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrCategories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.arrCategories[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedCategory = [self.arrCategories objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"goToPlacesList" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"goToPlacesList"]) {
        PlacesListTableViewController *placesListVC = (PlacesListTableViewController *)[segue destinationViewController];
        placesListVC.category = self.selectedCategory;
        
    }
}

@end
