//
//  CXLeftAndRightMenu.m
//  CXLeftAndRightMenuDemo
//
//  Created by Chris on 14-6-8.
//  Copyright (c) 2014年 Chris.Xin. All rights reserved.
//

#import "CXLeftAndRightMenu.h"

@interface CXLeftAndRightMenu ()

@end

@implementation CXLeftAndRightMenu

- (id)initWithRootController:(UIViewController *)rootController
{
    self = [super init];
    if (self != nil) {
        self.rootController = rootController;
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (_tap == nil) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self.view addGestureRecognizer:tap];
        [tap setEnabled:NO];
        _tap = tap;
    }
}

#pragma mark - Setter
- (void)setRootController:(UIViewController *)rootController
{
    if (rootController == nil) {
        return;
    }
    
    if(_rootController != nil){
       [_rootController.view removeFromSuperview];
    }
    
    rootController.view.frame = rootController.view.bounds;
    [self.view addSubview:rootController.view];
    
    _rootController = rootController;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [_rootController.view addGestureRecognizer:pan];
    
    _pan = pan;
    
}

- (void)setLeftController:(UIViewController *)leftController
{
    if (leftController == nil) {
        return;
    }
    
    if(_leftController != nil){
        [_leftController.view removeFromSuperview];
    }
    
    leftController.view.frame = leftController.view.bounds;
    CGRect fram = leftController.view.frame;
    fram.origin.x = 0 - KMenuWidth;
    fram.size.width = KMenuWidth;
    leftController.view.frame = fram;
    [self.view addSubview:leftController.view];
    
    _leftController = leftController;
    
    
}

- (void)setRightController:(UIViewController *)rightController
{
    if (rightController == nil) {
        return;
    }
    
    if(_rightController != nil){
        [_rightController.view removeFromSuperview];
    }
    
    rightController.view.frame = rightController.view.bounds;
    CGRect fram = rightController.view.frame;
    fram.origin.x = KScreenWidth;
    fram.size.width = KMenuWidth;
    rightController.view.frame = fram;
    [self.view addSubview:rightController.view];
    
    _rightController = rightController;
}

#pragma mark - Gesture Action
-(void)tapAction:(UIGestureRecognizer*)gestureRecognizer
{
    NSLog(@"tapAction");
    CGPoint point = [gestureRecognizer locationInView:self.view];
    NSLog(@"point.x = %f", point.x);
    
    if (_direction == CXMenuLeft) {
        if (point.x<KMenuWidth) {
            return;
        }
    }else if(_direction == CXMenuRight){
        if (point.x>KMenuWidth) {
            return;
        }
    }
    
    [self showRootView];
    [gestureRecognizer setEnabled:NO];
}

-(void)panAction:(UIGestureRecognizer*)gestureRecognizer
{
    static CGPoint lastPoint;
    static CGPoint firstPoint;
    
    NSLog(@"panAction");
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"UIGestureRecognizerStateBegan");
        _direction = CXMenuNone;
        lastPoint = [gestureRecognizer locationInView:_rootController.view];
        firstPoint = lastPoint;
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        NSLog(@"UIGestureRecognizerStateChanged");
        
        CGPoint point = [gestureRecognizer locationInView:_rootController.view];
        if(lastPoint.x <= point.x){
            _direction = CXMenuLeft;
        }else if(lastPoint.x >= point.x){
            _direction = CXMenuRight;
        }else{
            _direction = CXMenuNone;
        }
        
        lastPoint = point;
        //[self showMovingView:firstPoint.x - point.x];
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"UIGestureRecognizerStateEnded");
        if(_direction != CXMenuNone){
            
            if(_direction == CXMenuLeft){
                NSLog(@"direction = CXMenuLeft");
                [self showLeftView];
            }
            else if(_direction == CXMenuRight){
                NSLog(@"direction = CXMenuRight");
                [self showRightView];
            }
        }
        else{
            NSLog(@"direction = CXMenuNone");
        }

    }
}


#pragma mark - Show View

- (void)showMovingView:(CGFloat)x
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    CGRect leftFram = _leftController.view.frame;
    leftFram.origin.x = leftFram.origin.x + x;
    _leftController.view.frame = leftFram;
    
    CGRect rootFram = _rootController.view.frame;
    rootFram.origin.x = 0-KMenuWidth;
    _rootController.view.frame = rootFram;
    
    CGRect rightFram = _rightController.view.frame;
    rightFram.origin.x = KScreenWidth-KMenuWidth;
    _rightController.view.frame = rightFram;
    
    
    [UIView commitAnimations];
}

- (void)showLeftView
{
    [_tap setEnabled:YES];
    
    [self showShadow:YES];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    CGRect leftFram = _leftController.view.frame;
    leftFram.origin.x = 0;
    _leftController.view.frame = leftFram;
    
    CGRect rootFram = _rootController.view.frame;
    rootFram.origin.x = KMenuWidth;
    _rootController.view.frame = rootFram;
    
    CGRect rightFram = _rightController.view.frame;
    rightFram.origin.x = KMenuWidth+KScreenWidth;
    _rightController.view.frame = rightFram;
    
    [UIView commitAnimations];
}

- (void)showRightView
{
    [_tap setEnabled:YES];
    
    [self showShadow:YES];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    CGRect leftFram = _leftController.view.frame;
    leftFram.origin.x = 0-KMenuWidth-KScreenWidth;
    _leftController.view.frame = leftFram;
    
    CGRect rootFram = _rootController.view.frame;
    rootFram.origin.x = 0-KMenuWidth;
    _rootController.view.frame = rootFram;
    
    CGRect rightFram = _rightController.view.frame;
    rightFram.origin.x = KScreenWidth-KMenuWidth;
    _rightController.view.frame = rightFram;
    
    [UIView commitAnimations];
}


- (void)showRootView
{
    [self showShadow:NO];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    CGRect leftFram = _leftController.view.frame;
    leftFram.origin.x = 0-KMenuWidth;
    _leftController.view.frame = leftFram;
    
    CGRect rootFram = _rootController.view.frame;
    rootFram.origin.x = 0;
    _rootController.view.frame = rootFram;
    
    CGRect rightFram = _rightController.view.frame;
    rightFram.origin.x = KScreenWidth;
    _rightController.view.frame = rightFram;
    
    [UIView commitAnimations];
}

- (void)showShadow:(BOOL)shadow {
    if (!_rootController) return;
    
    _rootController.view.layer.shadowOpacity = shadow ? 0.2f : 0.0f;
    if (shadow) {
        _rootController.view.layer.cornerRadius = 4.0f;
        _rootController.view.layer.shadowOffset = CGSizeZero;
        _rootController.view.layer.shadowRadius = 4.0f;
        _rootController.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.view.bounds].CGPath;
    }
    
}


@end
