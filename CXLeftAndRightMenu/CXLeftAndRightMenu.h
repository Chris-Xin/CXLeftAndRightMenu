//
//  CXLeftAndRightMenu.h
//  CXLeftAndRightMenuDemo
//
//  Created by Chris on 14-6-8.
//  Copyright (c) 2014年 Chris.Xin. All rights reserved.
//

#import <UIKit/UIKit.h>
#define KScreenWidth            [UIScreen mainScreen].bounds.size.width
#define KScreenHeight           [UIScreen mainScreen].bounds.size.height
#define KMenuWidth              200

typedef enum{
    CXMenuNone = 0,
    CXMenuRight,
    CXMenuLeft,
}CXMenuDirection;


@interface CXLeftAndRightMenu : UIViewController
{
    UITapGestureRecognizer *_tap;
    UIPanGestureRecognizer *_pan;
    
    CXMenuDirection _direction;
}

@property(nonatomic, retain)UIViewController *rootController;
@property(nonatomic, retain)UIViewController *leftController;
@property(nonatomic, retain)UIViewController *rightController;


- (id)initWithRootController:(UIViewController *)rootController;

@end
