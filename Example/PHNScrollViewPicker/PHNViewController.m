//
//  PHNViewController.m
//  PHNScrollViewPicker
//
//  Created by Pavel Volobuev on 10/03/2014.
//  Copyright (c) 2014 Pavel Volobuev. All rights reserved.
//

#import "PHNViewController.h"

@interface PHNViewController ()

@end

@implementation PHNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *mutableArray1 = [[NSMutableArray alloc] initWithCapacity:14];
    for (int i = 0; i < 14; i++) {
        [mutableArray1 addObject:[NSString stringWithFormat:@"Item One %d", i]];
    }
    
    NSMutableArray *mutableArray2 = [[NSMutableArray alloc] initWithCapacity:4];
    for (int i = 0; i < 4; i++) {
        [mutableArray2 addObject:[NSString stringWithFormat:@"Item Two  %d", i]];
    }
    
    NSMutableArray *mutableArray3 = [[NSMutableArray alloc] initWithCapacity:30];
    for (int i = 0; i < 30; i++) {
        [mutableArray3 addObject:[NSString stringWithFormat:@"Item Three %d", i]];
    }
    
    [_scrollViewPicker1 initContentWithArray:mutableArray1 selectionViewType:SelectionViewTypeLines];
    _scrollViewPicker1.phnDelegate = self;
    _scrollViewPicker1.tag = 1;
    _scrollViewPicker1.backgroundColor = [UIColor whiteColor];
    
    [_scrollViewPicker2 initContentWithArray:mutableArray2 selectionViewType:SelectionViewTypeLines];
    _scrollViewPicker2.phnDelegate = self;
    _scrollViewPicker2.tag = 2;
    _scrollViewPicker2.backgroundColor = [UIColor greenColor];

    [_scrollViewPicker3 initContentWithArray:mutableArray3 selectionViewType:SelectionViewTypeLines];
/*  _scrollViewPicker3.phnDelegate set in storyboard */
    _scrollViewPicker3.tag = 3;
    _scrollViewPicker3.backgroundColor = [UIColor blueColor];
    _scrollViewPicker3.linesColor = [UIColor whiteColor];
    _scrollViewPicker3.titleColor = [UIColor orangeColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PHNScrollViewPickerDelegate

- (void)phnScrollViewPicker:(PHNScrollViewPicker *)phnScrollViewPicker itemDidSelected:(int)selectedItem {
    NSLog(@"Selected picker %d item %d", (int)phnScrollViewPicker.tag, selectedItem);
}

@end
