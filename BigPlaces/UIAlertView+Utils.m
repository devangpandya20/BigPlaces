//
//  UIAlertView+Utils.m
//  BigPlaces
//
//  Created by Devang Pandya on 31/03/15.
//  Copyright (c) 2015 Devang Pandya. All rights reserved.
//

#import "UIAlertView+Utils.h"

@implementation UIAlertView (Utils)
+ (void)showAlertWithTitle:(NSString*)strTitle msg:(NSString*)strMessage{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [alert show];
}
@end
