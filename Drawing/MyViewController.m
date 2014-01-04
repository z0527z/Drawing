//
//  MyViewController.m
//  Drawing
//
//  Created by dingql on 13-12-28.
//  Copyright (c) 2013年 dingql. All rights reserved.
//

#import "MyViewController.h"

#define kImage_width            32.0f
#define kImage_height           36.0f

#define kMoveStep               20

#define kNormal_image           @"NormalImage"
#define kHighlighted_image      @"HighlightedImage"

@interface MyViewController ()
@property(nonatomic, strong) NSMutableArray * operateList;
@property(nonatomic, strong) UIButton * button;
@end

@implementation MyViewController

- (id) CustomButtonAtIndex: (NSInteger) index
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage * normalImage       = [[self.operateList objectAtIndex:index] objectForKey:kNormal_image];
    UIImage * highLightImage   = [[self.operateList objectAtIndex:index] objectForKey:kHighlighted_image];
    [button setBackgroundImage:normalImage forState:UIControlStateNormal];
    [button setBackgroundImage:highLightImage forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(Clicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return  button;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.operateList = [NSMutableArray array];
    
    [self.operateList addObject:@{kNormal_image : [UIImage imageNamed:@"sub_black_up"],
                                  kHighlighted_image : [UIImage imageNamed:@"sub_blue_up"]}];
    
    [self.operateList addObject:@{kNormal_image : [UIImage imageNamed:@"sub_black_down"],
                                  kHighlighted_image : [UIImage imageNamed:@"sub_blue_down"]}];
      
    [self.operateList addObject:@{kNormal_image: [UIImage imageNamed:@"sub_black_prev"],
                                  kHighlighted_image : [UIImage imageNamed:@"sub_blue_prev"]}];
       
    [self.operateList addObject:@{kNormal_image : [UIImage imageNamed:@"sub_black_next"],
                                  kHighlighted_image : [UIImage imageNamed:@"sub_blue_next"]}];
    
    [self.operateList addObject:@{kNormal_image : [UIImage imageNamed:@"sub_black_rotate_ccw"],
                                  kHighlighted_image : [UIImage imageNamed:@"sub_blue_rotate_ccw"]}];
    
    [self.operateList addObject:@{kNormal_image: [UIImage imageNamed:@"sub_black_rotate_cw"],
                                  kHighlighted_image : [UIImage imageNamed:@"sub_blue_rotate_cw"]}];
    
    [self.operateList addObject:@{kNormal_image : [UIImage imageNamed:@"sub_black_add"],
                                  kHighlighted_image : [UIImage imageNamed:@"sub_blue_add"]}];
    
    [self.operateList addObject:@{kNormal_image: [UIImage imageNamed:@"sub_black_remove"],
                                  kHighlighted_image : [UIImage imageNamed:@"sub_blue_remove"]}];

    
    UIButton * btn = [self CustomButtonAtIndex:0];
    btn.frame = CGRectMake(40, 350, kImage_width, kImage_height);
    btn.tag = 10;
    [self.view addSubview:btn];
    
    btn = [self CustomButtonAtIndex:1];
    btn.frame = CGRectMake(40, 425, kImage_width, kImage_height);
    btn.tag = 11;
    [self.view addSubview:btn];
    
    btn = [self CustomButtonAtIndex:2];
    btn.frame = CGRectMake(2, 390, kImage_height, kImage_width);
    btn.tag = 12;
    [self.view addSubview:btn];
    
    btn = [self CustomButtonAtIndex:3];
    btn.frame = CGRectMake(80, 390, kImage_height, kImage_width);
    btn.tag = 13;
    [self.view addSubview:btn];
    
    btn = [self CustomButtonAtIndex:4];
    btn.frame = CGRectMake(200, 350, kImage_width + 8, kImage_height - 2);
    btn.tag = 14;
    [self.view addSubview:btn];
    
    btn = [self CustomButtonAtIndex:5];
    btn.frame = CGRectMake(275, 350, kImage_width + 8, kImage_height - 2);
    btn.tag = 15;
    [self.view addSubview:btn];
    
    btn = [self CustomButtonAtIndex:6];
    btn.frame = CGRectMake(200, 420, kImage_width + 5, kImage_height);
    btn.tag = 16;
    [self.view addSubview:btn];
    
    btn = [self CustomButtonAtIndex:7];
    btn.frame = CGRectMake(275, 433, kImage_height, kImage_width - 20);
    btn.tag = 17;
    [self.view addSubview:btn];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(110, 125, 100, 100);
    button.tag = 100;
    [button setBackgroundImage:[UIImage imageNamed:@"btn_01"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"btn_02"] forState:UIControlStateHighlighted];
    [button setTitle:@"点我啊" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [button setTitle:@"摸我干啥" forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    self.button = button;
    [self.view addSubview:button];
    
}

- (void) Clicked: (id) sender
{
    if([sender isKindOfClass:[UIButton class]])
    {
        UIButton * btn = (UIButton *)sender;
        UIButton * button = (UIButton *)[self.view viewWithTag:100];
        NSLog(@"frame:<%f,%f,%f,%f>", button.frame.origin.x, button.frame.origin.y, button.frame.size.width, button.frame.size.height);
        __block CGRect tmp = button.frame;
        __block CGAffineTransform transform = button.transform;
        
        [self operateWithBlock:^{
            switch (btn.tag) {
                case 10:
                case 11:
                    tmp.origin.y += (btn.tag == 10 ? -1 : 1) * kMoveStep;
                    break;
                case 12:
                case 13:
                    tmp.origin.x += (btn.tag == 12 ? -1 : 1) * kMoveStep;
                    break;
                case 14:
                case 15:
                    transform = CGAffineTransformRotate(transform, (btn.tag == 14 ? -1 : 1) * M_PI_4);
                    break;
                case 16:
                case 17:
                    transform = CGAffineTransformScale(transform, btn.tag == 16 ? 1.2 : 0.8, btn.tag == 16 ? 1.2 : 0.8);
                    break;
                default:
                    break;
            }
            
            if(btn.tag < 14)
                button.frame = tmp;
            else
                button.transform = transform;
        }];
    }
    
}

- (void) operateWithBlock: (void(^)()) block
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    block();
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
