//
//  PHNViewController.h
//  PHNScrollViewPicker
//
//  Created by Pavel Volobuev on 10/03/2014.
//  Copyright (c) 2014 Pavel Volobuev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PHNScrollViewPicker.h"

@interface PHNViewController : UIViewController <PHNScrollViewPickerDelegate> {
    IBOutlet PHNScrollViewPicker *_scrollViewPicker1;
    IBOutlet PHNScrollViewPicker *_scrollViewPicker2;
    IBOutlet PHNScrollViewPicker *_scrollViewPicker3;
}

@end
