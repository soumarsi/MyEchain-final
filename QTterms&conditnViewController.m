//
//  QTterms&conditnViewController.m
//  MyEchain
//
//  Created by maxcon8 on 10/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "QTterms&conditnViewController.h"

@interface QTterms_conditnViewController ()

@end

@implementation QTterms_conditnViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"QTterms&conditnViewController");
	// Do any additional setup after loading the view.
    
//    mainview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height )];
//    mainview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"1-splashbg-1"]];
//    [self.view addSubview:mainview];
    
    mainview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height )];
    mainview.backgroundColor=[UIColor clearColor];
    [self.view addSubview:mainview];
    
    UIView *upperview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 128/2)];
    upperview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar"]];
    [mainview addSubview:upperview];
    
    
    UIImageView *headimg=[[UIImageView alloc]initWithFrame:CGRectMake(120, 25, 183/2, 30)];
    headimg.image=[UIImage imageNamed:@"topbar-logo"];
    [upperview addSubview:headimg];

    UIImageView *back=[[UIImageView alloc]initWithFrame:CGRectMake(15, 35, 23/2, 41/2)];
    back.image=[UIImage imageNamed:@"left-arrow"];
    [upperview addSubview:back];
    
    
    UIView *backview=[[UIView alloc]initWithFrame:CGRectMake(0, 15, 60, 45)];
    backview.backgroundColor=[UIColor clearColor];
    [upperview addSubview:backview];
    
    ////////////////////////////////
    UITapGestureRecognizer *back_tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    [backview addGestureRecognizer:back_tap];
    backview.userInteractionEnabled=YES;
    
    ///////////////////////////////

    
    UILabel *headlb=[[UILabel alloc]initWithFrame:CGRectMake(0, 90, 320, 25)];
    headlb.text=@"Terms and Conditions";
    headlb.font=[UIFont systemFontOfSize:20];
    headlb.textAlignment=NSTextAlignmentCenter;
    [mainview addSubview:headlb];
    
    
    
    
    
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
