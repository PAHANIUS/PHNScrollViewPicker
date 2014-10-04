//
//  PHNScrollViewPicker.h
//  InteriorT
//
//  Created by Pavel Volobuev on 03.10.14.
//  Copyright (c) 2014 IAS. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  SelectionViewType
 */
typedef NS_ENUM(NSInteger, SelectionViewType) {
    /**
     *  Top and bottom line
     */
    SelectionViewTypeLines = 1,
    /**
     *  Just clear space
     */
    SelectionViewTypeNone = 0
};

@class PHNScrollViewPicker;

@protocol PHNScrollViewPickerDelegate

@required
/**
 *  Returns the selected item after the end scrolling
 *
 *  @param phnScrollViewPicker phnScrollViewPicker
 *  @param selectedItem        selectedItem number if selected item
 */
- (void)phnScrollViewPicker:(PHNScrollViewPicker *)phnScrollViewPicker itemDidSelected:(int)selectedItem;

@end

/**
 *  Use initContentWithArray to Init the picker
 */
@interface PHNScrollViewPicker : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, retain) IBOutlet id <PHNScrollViewPickerDelegate> phnDelegate;
@property (nonatomic, retain) UIView *selectionView;
@property (nonatomic, retain) UIColor *titleColor;

/**
 *  SelectionViewTypeLines properties
 */
@property (nonatomic, retain) UIColor *linesColor;

/**
 *  Init method for PHNScrollViewPicker
 *
 *  @param contentArray array of NSString titles
 */
- (void)initContentWithArray:(NSArray *)contentArray selectionViewType:(SelectionViewType)selectionViewType;

@end
