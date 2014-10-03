//
//  PHNScrollViewPicker.m
//  InteriorT
//
//  Created by Pavel Volobuev on 03.10.14.
//  Copyright (c) 2014 IAS. All rights reserved.
//

#import "PHNScrollViewPicker.h"

#define kCellHeight 44

@interface PHNScrollViewPicker ()

@property (nonatomic, retain) NSArray *contentArray;
@property (nonatomic, assign) int selectedItemPosition;
@property (nonatomic, assign) BOOL isForseScroll;

// SelectionViewTypeLines
@property (nonatomic, retain) UIView *topSeparatorView;
@property (nonatomic, retain) UIView *bottomSeparatorView;

@end

@implementation PHNScrollViewPicker

#pragma mark - Init Methods

- (void)initContentWithArray:(NSArray *)contentArray selectionViewType:(SelectionViewType)selectionViewType {
    _contentArray = contentArray;
    
    // Defaults
    self.delegate = self;
    _isForseScroll = NO;
    int maxY = 0;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    
    _selectedItemPosition = self.frame.size.height / kCellHeight / 2;
    for (NSString *object in _contentArray) {
        UILabel *itemTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, maxY, self.frame.size.width - 15, kCellHeight)];
        itemTitle.tag = 909;
        itemTitle.font = [UIFont systemFontOfSize:18];
        itemTitle.textColor = [UIColor blackColor];
        itemTitle.backgroundColor = [UIColor clearColor];
        itemTitle.text = object;
        [self addSubview:itemTitle];
        
        maxY = CGRectGetMaxY(itemTitle.frame);
    }
    self.contentSize = CGSizeMake(self.contentSize.width, maxY);
    self.backgroundColor = [UIColor clearColor];
    self.contentInset = UIEdgeInsetsMake(kCellHeight * _selectedItemPosition, 0, kCellHeight * _selectedItemPosition, 0);
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [self addGestureRecognizer:singleTap];
    
    // SelectionView
    
    [self selectionViewByType:selectionViewType];
    
    [self scrollViewDidScroll:self];
}

- (void)selectionViewByType:(SelectionViewType)selectionViewType {
    switch (selectionViewType) {
        case SelectionViewTypeLines: {
            _selectionView = [[UIView alloc] initWithFrame:CGRectMake(0, kCellHeight * _selectedItemPosition, self.frame.size.width, kCellHeight)];
            _selectionView.backgroundColor = [UIColor clearColor];
            _selectionView.userInteractionEnabled = NO;
            [self addSubview:_selectionView];
            
            float separatorHeight = 0.5f;
            _topSeparatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, separatorHeight)];
            [_topSeparatorView setBackgroundColor:[UIColor grayColor]];
            [_selectionView addSubview:_topSeparatorView];
            
            _bottomSeparatorView = [[UIView alloc] initWithFrame:CGRectMake(0, _selectionView.frame.size.height - separatorHeight, self.frame.size.width, separatorHeight)];
            [_bottomSeparatorView setBackgroundColor:[UIColor grayColor]];
            [_selectionView addSubview:_bottomSeparatorView];
        }
            break;
        case SelectionViewTypeNone: {
            _selectionView = nil;
        }
            break;
            
        default:
            break;
    }
}

- (void)setTitleColor:(UIColor *)titleColor {
    for (UILabel *label in self.subviews) {
        if (label.tag == 909) label.textColor = titleColor;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!_selectionView) return;
    _selectionView.frame = CGRectMake(_selectionView.frame.origin.x, kCellHeight * _selectedItemPosition + scrollView.contentOffset.y,
                                      _selectionView.frame.size.width, _selectionView.frame.size.height);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    BOOL goneMaxIndexes = NO;
    int kMaxIndex = -_selectedItemPosition + _contentArray.count - 1.0;
    CGFloat targetY = scrollView.contentOffset.y + velocity.y * 60;
    CGFloat targetIndex = round(targetY / (kCellHeight + 0));
    if (targetIndex < -_selectedItemPosition) {
        targetIndex = -_selectedItemPosition;
        goneMaxIndexes = YES;
    }
    if (targetIndex > kMaxIndex) {
        targetIndex = kMaxIndex;
        goneMaxIndexes = YES;
    }
    if (goneMaxIndexes) {
        _isForseScroll = YES;
        CGPoint newOffset = CGPointMake(targetContentOffset->x, targetContentOffset->y);
        newOffset.y = targetIndex * (kCellHeight + 0);
        dispatch_async(dispatch_get_main_queue(), ^{
            [scrollView setContentOffset:newOffset animated:YES];
        });
    }
    targetContentOffset->y = targetIndex * (kCellHeight + 0);
}

- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture {
    CGPoint touchPoint = [gesture locationInView:self];

    CGFloat selectedIndex = floor(touchPoint.y / kCellHeight);
    CGFloat targetIndex = selectedIndex - _selectedItemPosition;
    
    int kMaxIndex = -_selectedItemPosition + _contentArray.count - 1.0;
    if (targetIndex < -_selectedItemPosition) {
        targetIndex = -_selectedItemPosition;
    }
    if (targetIndex > kMaxIndex) {
        targetIndex = kMaxIndex;
    }
    
    CGPoint newOffset = CGPointMake(self.contentOffset.x, self.contentOffset.y);
    newOffset.y = targetIndex * kCellHeight;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setContentOffset:newOffset animated:YES];
    });
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_isForseScroll) {
        _isForseScroll = NO;
        return;
    }
    
    int sectionPointY = kCellHeight * _selectedItemPosition + scrollView.contentOffset.y;
    CGFloat selectedIndex = round(sectionPointY / kCellHeight);
    [self.phnDelegate phnScrollViewPicker:self itemDidSelected:selectedIndex];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    int sectionPointY = kCellHeight * _selectedItemPosition + scrollView.contentOffset.y;
    CGFloat selectedIndex = round(sectionPointY / kCellHeight);
    [self.phnDelegate phnScrollViewPicker:self itemDidSelected:selectedIndex];
}

#pragma mark - SelectionViewTypeLines settings

- (void)setLinesColor:(UIColor *)linesColor {
    _topSeparatorView.backgroundColor = linesColor;
    _bottomSeparatorView.backgroundColor = linesColor;
}

@end
