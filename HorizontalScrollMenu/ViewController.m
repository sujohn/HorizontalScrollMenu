//
//  ViewController.m
//  HorizontalScrollMenu
//
//  Created by AAPBD on 7/1/15.
//  Copyright (c) 2015 AAPBD. All rights reserved.
//

#import "ViewController.h"
#import "iCarousel.h"

@interface ViewController ()<UIScrollViewDelegate,iCarouselDataSource, iCarouselDelegate>{
    UIScrollView *homeTopScrollView;
    
}
@property (retain, nonatomic) IBOutlet iCarousel *carousel;
@property (nonatomic, assign) BOOL wrap;
@property (nonatomic, retain) NSMutableArray *items;
@end

@implementation ViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUp];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.carousel.decelerationRate = 0.5;
    self.carousel.type = iCarouselTypeLinear;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUp {
    self.wrap = YES;
    self.items = [NSMutableArray array];
    for (int i = 0; i < NUMBER_OF_ITEMS; i++) {
        [self.items addObject:[NSNumber numberWithInt:i]];
    }
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return [self.items count];
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel {
    return NUMBER_OF_VISIBLE_ITEMS;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    view = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 101,100)];
    [view setBackgroundColor:[UIColor clearColor]];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(35,10,101,46);
    [btn setImage:[UIImage imageNamed:@"person-placeholder.jpg"] forState:UIControlStateNormal];
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:btn];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(45,btn.frame.origin.y+btn.frame.size.height,101,46)];
    label.numberOfLines = 0;
    label.adjustsFontSizeToFitWidth = YES;
    label.text=[NSString stringWithFormat:@"My name is ....%lu",(unsigned long)index];
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    
    return view;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel {
    return INCLUDE_PLACEHOLDERS? 2: 0;
}

- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    if (view == nil) {
        view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"page.png"]];
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:50.0f];
        [view addSubview:label];
    }
    else {
        label = [[view subviews] lastObject];
    }
    label.text = (index == 0)? @"[": @"]";
    
    return view;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel {
    return ITEM_SPACING;
}

- (CGFloat)carousel:(iCarousel *)carousel itemAlphaForOffset:(CGFloat)offset {
    return 1.0f - fminf(fmaxf(offset, 0.0f), 1.0f);
}

- (CATransform3D)carousel:(iCarousel *)_carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform {
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * self.carousel.itemWidth);
}

- (BOOL)carouselShouldWrap:(iCarousel *)carousel {
    return NO;
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel{
    NSLog(@"----carouselDidEndScrollingAnimation-------%li",(long)self.carousel.currentItemIndex);
}

@end
