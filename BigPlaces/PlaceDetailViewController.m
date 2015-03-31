//
//  PlaceDetailViewController.m
//  BigPlaces
//
//  Created by Devang Pandya on 01/04/15.
//  Copyright (c) 2015 Devang Pandya. All rights reserved.
//

#import "PlaceDetailViewController.h"
#import "Place.h"
#import "Networking.h"
#import "MapViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "UIAlertView+Utils.h"
@interface PlaceDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblRating;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UIImageView *imgPlace;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityImage;
@property (weak, nonatomic) IBOutlet UIButton *btnAddToFavorite;

- (IBAction)btnAddToFavoriteClicked:(id)sender;
@end

@implementation PlaceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.place.placeRating>0.0)
        self.lblRating.text = [NSString stringWithFormat:@"%.1f",self.place.placeRating];
    else
        self.lblRating.text = @"No Ratings Available";
    self.lblAddress.text = self.place.placeAddress;
    self.title = self.place.placeName;
    if (!self.place.placePhotoRef) {
        return;
    }
    UIImage *image = [self loadImageFromCache:self.place.placePhotoRef];
    if (image) {
        self.imgPlace.image = image;
    }
    else{
        [self.activityImage startAnimating];
        [Networking getPlaceImage:self.place.placePhotoRef success:^(id response) {
            [self cacheImage:response forURL:self.place.placePhotoRef];
            self.imgPlace.image = [UIImage imageWithData:response];
            
            [self.activityImage stopAnimating];
            
        } failure:^(NSError *error) {
            [self.activityImage stopAnimating];
        }];
    }
    // Do any additional setup after loading the view.
}

-(void)cacheImage:(NSData*)imageData forURL:(NSString*)imgURL{
    NSString *docDir=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString  *pngFilePath = [NSString stringWithFormat:@"%@/%@",docDir,imgURL];
    [imageData writeToFile:pngFilePath atomically:YES];
}
-(UIImage*)loadImageFromCache:(NSString*)imgURL{
    NSString *docDir=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",docDir,imgURL];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if (fileExists) {
        return [UIImage imageWithContentsOfFile:filePath];
    }
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showPlaceOnMap"]) {
        MapViewController *placesListVC = (MapViewController *)[segue destinationViewController];
        placesListVC.place = self.place;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnAddToFavoriteClicked:(id)sender {
    if ([self exist]) {
        [UIAlertView showAlertWithTitle:@"Error" msg:@"Place already added to favorites"];
        return;
    }
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObject *favPlace = [NSEntityDescription insertNewObjectForEntityForName:@"Place" inManagedObjectContext:appDelegate.managedObjectContext];
    [favPlace setValue:self.place.placeName forKey:@"placename"];
    [favPlace setValue:self.place.placeImage forKey:@"placeimage"];
    NSError *dbSaveError = nil;

    if([[appDelegate managedObjectContext] save:&dbSaveError])
        NSLog(@"Entry saved sucessfully");
    else
        NSLog(@"%@", [dbSaveError localizedDescription]);

}
-(BOOL)exist
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Place" inManagedObjectContext:managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    [request setFetchLimit:1];
    [request setPredicate:[NSPredicate predicateWithFormat:@"placename == %@", self.place.placeName]];
        NSError *error = nil;
    NSUInteger count = [managedObjectContext countForFetchRequest:request error:&error];
    if (count)
        return YES;
    else
        return NO;
}
@end
