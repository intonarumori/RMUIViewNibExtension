//
//  OtherViewController.m
//  XibHelpers
//
//  Created by Daniel Langh on 24/03/16.
//  Copyright © 2016 rumori. All rights reserved.
//

#import "OtherViewController.h"

#import "UIViewNibExtensionsExample-Swift.h"

@interface OtherViewController ()

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SameNameView *view = [SameNameView instantiateFromNib];
    if (view != nil) {
        view.frame = CGRectMake(100, 100, 100, 100);
        [self.view addSubview:view];
    }
}

@end
