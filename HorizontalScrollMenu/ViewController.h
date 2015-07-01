//
//  ViewController.h
//  HorizontalScrollMenu
//
//  Created by AAPBD on 7/1/15.
//  Copyright (c) 2015 AAPBD. All rights reserved.
//

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define NUMBER_OF_ITEMS (IS_IPAD? 19: 12)
#define NUMBER_OF_VISIBLE_ITEMS 25
#define ITEM_SPACING 110.0f
#define INCLUDE_PLACEHOLDERS YES

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end

