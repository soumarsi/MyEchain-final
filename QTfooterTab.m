//
//  QTfooterTab.m
//  MyEchain
//
//  Created by maxcon8 on 22/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "QTfooterTab.h"
#import "RootViewController.h"
#import "QTUpgradeViewController.h"

@implementation QTfooterTab
@synthesize home,card,scanner,profile,upgrade;
@synthesize homesel_bg,card_bg,scan_bg,profile_bg,upgrade_bg;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        // Initialization code
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bottom-bar.png"]]];
        
        homesel_bg=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 64, 98/2)];
        homesel_bg.backgroundColor=[UIColor clearColor];
        [self addSubview:homesel_bg];
       

        
        home=[[UIButton alloc]initWithFrame:CGRectMake(16,11, 59/2, 51/2)];
        [home addTarget:self action:@selector(homefn) forControlEvents:UIControlEventTouchUpInside];
        [home setBackgroundImage:[UIImage imageNamed:@"home_foot.png"] forState:UIControlStateNormal];
        // [home setBackgroundImage:[UIImage imageNamed:@"home_final.png"] forState:UIControlStateNormal];
        [home setBackgroundImage:[UIImage imageNamed:@"homesel_foot.png"] forState:UIControlStateSelected];
        [home setBackgroundImage:[UIImage imageNamed:@"homesel_foot.png"] forState:UIControlStateHighlighted];
        [self addSubview:home];
        
        
        UITapGestureRecognizer *tap1= [[UITapGestureRecognizer alloc] initWithTarget:self
                                       
                                                                              action:@selector(homefn)];
        
        tap1.numberOfTapsRequired=1;
        homesel_bg.userInteractionEnabled=YES;
        [homesel_bg addGestureRecognizer:tap1];

        
        
        card_bg=[[UIView alloc]initWithFrame:CGRectMake(64, 0, 64, 98/2)];
        card_bg.backgroundColor=[UIColor clearColor];
        [self addSubview:card_bg];
        //[card_bg setHidden:YES];
        
        
        card=[[UIButton alloc]initWithFrame:CGRectMake(64+16,15, 62/2, 39/2)];
        [card addTarget:self action:@selector(cardentry) forControlEvents:UIControlEventTouchUpInside];
        [card setBackgroundImage:[UIImage imageNamed:@"card_foot.png"] forState:UIControlStateNormal];
        // [home setBackgroundImage:[UIImage imageNamed:@"home_final.png"] forState:UIControlStateNormal];
        [card setBackgroundImage:[UIImage imageNamed:@"cardsel_foot.png"] forState:UIControlStateSelected];
        [card setBackgroundImage:[UIImage imageNamed:@"cardsel_foot.png"] forState:UIControlStateHighlighted];
        [self addSubview:card];
        
        UITapGestureRecognizer *tap2= [[UITapGestureRecognizer alloc] initWithTarget:self
                                       
                                                                              action:@selector(cardentry)];
        
        tap2.numberOfTapsRequired=1;
        card_bg.userInteractionEnabled=YES;
        [card_bg addGestureRecognizer:tap2];
        
        
        
        scan_bg=[[UIView alloc]initWithFrame:CGRectMake(128, 0, 64, 98/2)];
        scan_bg.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"select-bottombg"]];
        scan_bg.backgroundColor=[UIColor clearColor];
        [self addSubview:scan_bg];
        //[scan_bg setHidden:YES];
        
        scanner=[[UIButton alloc]initWithFrame:CGRectMake(135+13,15, 50/2, 38/2)];
        [scanner addTarget:self action:@selector(scanQRCode) forControlEvents:UIControlEventTouchUpInside];
        [scanner setBackgroundImage:[UIImage imageNamed:@"scan_foot.png"] forState:UIControlStateNormal];
        // [home setBackgroundImage:[UIImage imageNamed:@"home_final.png"] forState:UIControlStateNormal];
        [scanner setBackgroundImage:[UIImage imageNamed:@"scansel_foot.png"] forState:UIControlStateSelected];
        [scanner setBackgroundImage:[UIImage imageNamed:@"scansel_foot.png"] forState:UIControlStateHighlighted];
        [self addSubview:scanner];
        
        UITapGestureRecognizer *tap3= [[UITapGestureRecognizer alloc] initWithTarget:self
                                       
                                                                              action:@selector(scanQRCode)];
        
        tap3.numberOfTapsRequired=1;
        scan_bg.userInteractionEnabled=YES;
        [scan_bg addGestureRecognizer:tap3];

        
        profile_bg=[[UIView alloc]initWithFrame:CGRectMake(192, 0, 64, 98/2)];
        profile_bg.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"select-bottombg"]];
        profile_bg.backgroundColor=[UIColor clearColor];
        [self addSubview:profile_bg];
        //[profile_bg setHidden:YES];

        
        profile=[[UIButton alloc]initWithFrame:CGRectMake(197+16,13, 48/2, 48/2)];
        [profile addTarget:self action:@selector(profilefn) forControlEvents:UIControlEventTouchUpInside];
        [profile setBackgroundImage:[UIImage imageNamed:@"profile_foot.png"] forState:UIControlStateNormal];
        // [home setBackgroundImage:[UIImage imageNamed:@"home_final.png"] forState:UIControlStateNormal];
        [profile setBackgroundImage:[UIImage imageNamed:@"profilesel_foot.png"] forState:UIControlStateSelected];
        [profile setBackgroundImage:[UIImage imageNamed:@"profilesel_foot.png"] forState:UIControlStateHighlighted];
        [self addSubview:profile];
        
        
        UITapGestureRecognizer *tap4= [[UITapGestureRecognizer alloc] initWithTarget:self
                                       
                                                                              action:@selector(profilefn)];
        
        tap4.numberOfTapsRequired=1;
        profile_bg.userInteractionEnabled=YES;
        [profile_bg addGestureRecognizer:tap4];
        
        upgrade_bg=[[UIView alloc]initWithFrame:CGRectMake(256, 0, 64, 98/2)];
        upgrade_bg.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"select-bottombg"]];
        [self addSubview:upgrade_bg];
        [upgrade_bg setHidden:YES];

        
        upgrade=[[UIButton alloc]initWithFrame:CGRectMake(260+16,15, 40/2, 38/2)];
       [upgrade addTarget:self action:@selector(upgradefn) forControlEvents:UIControlEventTouchUpInside];
        [upgrade setBackgroundImage:[UIImage imageNamed:@"upgrade_foot.png"] forState:UIControlStateNormal];
        [upgrade setBackgroundImage:[UIImage imageNamed:@"upgradesel_sel.png"] forState:UIControlStateSelected];
        [upgrade setBackgroundImage:[UIImage imageNamed:@"upgradesel_sel.png"] forState:UIControlStateHighlighted];
        [self addSubview:upgrade];
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(256, 0, 64, 98/2)];
        [button addTarget:self action:@selector(upgradefn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        
        
    }
    return self;
}
-(void)homefn
{
    NSLog(@"home touch====%d",[[NSUserDefaults standardUserDefaults]boolForKey:@"inhome"]);
   
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"inhome"])
    {
        
//        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"inhome"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSLog(@"home");
    }
    
    else
        
    {
        
    
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"inhome"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
     homesel_bg.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"select-bottombg"]];
    
    [home setSelected:YES];
    [homesel_bg setHidden:NO];
    
    
    [card setSelected:NO];
    [card_bg setHidden:YES];
    
    [profile setSelected:NO];
    [profile_bg setHidden:YES];

    
    [scanner setSelected:NO];
    [scan_bg setHidden:YES];

    [upgrade setSelected:NO];
    [upgrade_bg setHidden:YES];

 //QTCardHomeViewController *cardpg=[[QTCardHomeViewController alloc]init];

        
        
        RootViewController *cardpg=[[RootViewController alloc]init];
        QTAppDelegate *mainDelegate = (QTAppDelegate *)[[UIApplication sharedApplication] delegate];
        [mainDelegate.navigationController pushViewController:cardpg animated:NO];
   
    }
    
    
    
}
-(void)cardentry
{
    
    NSLog(@"cardentry");
    
    
    [home setSelected:NO];
    [homesel_bg setHidden:YES];
    
    
    
    card_bg.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"select-bottombg"]];
    [card setSelected:YES];
    [card_bg setHidden:NO];
    
    [profile setSelected:NO];
    [profile_bg setHidden:YES];

    
    [scanner setSelected:NO];
    [scan_bg setHidden:YES];
    
    [upgrade setSelected:NO];
    [upgrade_bg setHidden:YES];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"cardentry" forKey:@"footertab"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pagenav" object:Nil];
    
    QTaddCardViewController *cardpg=[[QTaddCardViewController alloc]init];
    QTAppDelegate *mainDelegate = (QTAppDelegate *)[[UIApplication sharedApplication] delegate];
    [mainDelegate.navigationController pushViewController:cardpg animated:NO];


}
-(void)scanQRCode
{
     [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"cardadd"];
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"scantap"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    
    scan_bg.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"select-bottombg"]];
     [scan_bg setHidden:NO];
      [scanner setSelected:YES];
    
    [home setSelected:NO];
    [homesel_bg setHidden:YES];
    
    [card setSelected:NO];
    [card_bg setHidden:YES];
    
    
    [profile setSelected:NO];
    [profile_bg setHidden:YES];
    
  
    
    
    [upgrade setSelected:NO];
    [upgrade_bg setHidden:YES];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"scanQRCode" forKey:@"footertab"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pagenav" object:Nil];
    
    QTScanCodeViewController *cardpg=[[QTScanCodeViewController alloc]init];
    QTAppDelegate *mainDelegate = (QTAppDelegate *)[[UIApplication sharedApplication] delegate];
    //[mainDelegate.navigationController pushViewController:cardpg animated:NO];
    [mainDelegate.navigationController presentViewController:cardpg animated:YES completion:nil];
    
}

-(void)profilefn
{
    [home setSelected:NO];
    [homesel_bg setHidden:YES];
    
    [card setSelected:NO];
    [card_bg setHidden:YES];
    
    
    [scanner setSelected:NO];
    [scan_bg setHidden:YES];
    
    profile_bg.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"select-bottombg"]];
    [profile setSelected:YES];
    [profile_bg setHidden:NO];
    
    [upgrade setSelected:NO];
    [upgrade_bg setHidden:YES];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"profilefn" forKey:@"footertab"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pagenav" object:Nil];
    
    QTprofileViewController *profilepg=[[QTprofileViewController alloc]init];
    QTAppDelegate *mainDelegate = (QTAppDelegate *)[[UIApplication sharedApplication] delegate];
    [mainDelegate.navigationController pushViewController:profilepg animated:NO];



}
-(void)upgradefn
{
    [home setSelected:NO];
    [homesel_bg setHidden:YES];
    
    [card setSelected:NO];
    [card_bg setHidden:YES];
    
    
    [scanner setSelected:NO];
    [scan_bg setHidden:YES];
    
    
    [profile setSelected:NO];
    [profile_bg setHidden:YES];
    
    [upgrade setSelected:YES];
    [upgrade_bg setHidden:NO];
    upgrade_bg.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"select-bottombg"]];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"upgradefn" forKey:@"footertab"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pagenav" object:Nil];
    
    QTUpgradeViewController *upgradepg=[[QTUpgradeViewController alloc]init];
    QTAppDelegate *mainDelegate = (QTAppDelegate *)[[UIApplication sharedApplication] delegate];
    [mainDelegate.navigationController pushViewController:upgradepg animated:NO];


}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
