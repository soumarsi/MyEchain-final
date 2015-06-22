//
//  QTStatic_cardpetViewController.m
//  MyEchain
//
//  Created by maxcon8 on 17/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "QTStatic_cardpetViewController.h"
#import "QTCardHomeViewController.h"

#import "UIImageView+WebCache.h"

@interface QTStatic_cardpetViewController ()

@end

@implementation QTStatic_cardpetViewController
@synthesize card_dict;
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
    
    NSLog(@"QTStatic_cardpetViewController");
	// Do any additional setup after loading the view.
    
    mainview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height )];
    mainview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"1-splashbg-1"]];
    [self.view addSubview:mainview];
    
    headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
    headview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar.png"]];
    [mainview addSubview:headview];
    
    UIImageView *headimg=[[UIImageView alloc]initWithFrame:CGRectMake(120, 25, 183/2, 30)];
    headimg.image=[UIImage imageNamed:@"topbar-logo"];
    [headview addSubview:headimg];
    
    
    
    UIButton *back=[[UIButton alloc]initWithFrame:CGRectMake(10,35, 100/2, 33/2)];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [back setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [[back titleLabel] setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
    back.userInteractionEnabled=YES;
    [headview addSubview:back];
    
    
    UIView *tview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    tview.backgroundColor=[UIColor clearColor];
    tview.userInteractionEnabled=YES;
    [headview addSubview:tview];
    
    UITapGestureRecognizer *btap= [[UITapGestureRecognizer alloc] initWithTarget:self
                                   
                                                                          action:@selector(back)];
    
    btap.numberOfTapsRequired=1;
    
    [tview addGestureRecognizer:btap];
    
    
   
    
    mainscroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, headview.frame.origin.y+headview.frame.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-65)];
    mainscroll.backgroundColor=[UIColor clearColor];
    mainscroll.scrollEnabled=YES;
    mainscroll.userInteractionEnabled=YES;
    mainscroll.showsHorizontalScrollIndicator=NO;
    mainscroll.showsVerticalScrollIndicator=YES;
    [mainview addSubview:mainscroll];
    
    mainscroll.contentSize=CGSizeMake(0,600);
    
    
    cardimg=[[UIImageView alloc]initWithFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width/2-35,17, 57, 57)];
    [cardimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://esolz.co.in/lab1/Web/myEchain/logoimage/thumb/staticimage2.png"]] placeholderImage:[UIImage imageNamed:@"logo-1.png"] options:0 == 0?SDWebImageRefreshCached : 0];
    //cardimg.image=[UIImage imageNamed:[card_dict objectForKey:@"photo"]];
    [mainscroll addSubview:cardimg];
    
    
    UILabel *headng=[[UILabel alloc]initWithFrame:CGRectMake(15, 90,255, 70)];
    headng.text=@"Present Digital Card For Prescription Discounts";
    headng.numberOfLines=2;
    headng.textColor=[UIColor whiteColor];
    headng.font=[UIFont fontWithName:@"HelveticaNeue-BoldItalic" size:19];
    headng.textAlignment=NSTextAlignmentLeft;
    [mainscroll addSubview:headng];
    
    UILabel *mem=[[UILabel alloc]initWithFrame:CGRectMake(15, headng.frame.origin.y+headng.frame.size.height+10, 120, 22)];
    mem.text=[NSString stringWithFormat:@"Member:"];
    mem.textColor=[UIColor whiteColor];
    mem.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:21];
    mem.textAlignment=NSTextAlignmentLeft;
    [mainscroll addSubview:mem];
    
    //--Rahul--//
    
    UILabel *mem2=[[UILabel alloc]initWithFrame:CGRectMake(128, headng.frame.origin.y+headng.frame.size.height+10, 120, 22)];
    mem2.text=[NSString stringWithFormat:@"MEC0%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"id"]];
    mem2.textColor=[UIColor whiteColor];
    mem2.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:21];
    mem2.textAlignment=NSTextAlignmentLeft;
    [mainscroll addSubview:mem2];
    
    
    UILabel *group=[[UILabel alloc]initWithFrame:CGRectMake(15,mem.frame.origin.y+mem.frame.size.height+5,120, 22)];
    group.text=[NSString stringWithFormat:@"Group:"];
    group.textColor=[UIColor whiteColor];
    group.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:21];
    group.textAlignment=NSTextAlignmentLeft;
    [mainscroll addSubview:group];
    
    UILabel *group2=[[UILabel alloc]initWithFrame:CGRectMake(128,mem.frame.origin.y+mem.frame.size.height+5,120, 22)];
    group2.text=[NSString stringWithFormat:@"MECRx1"];
    group2.textColor=[UIColor whiteColor];
    group2.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:21];
    group2.textAlignment=NSTextAlignmentLeft;
    [mainscroll addSubview:group2];
    
    UILabel *bin=[[UILabel alloc]initWithFrame:CGRectMake(15, group.frame.origin.y+group.frame.size.height+5, 120, 22)];
    bin.text=[NSString stringWithFormat:@"BIN:"];
    bin.textColor=[UIColor whiteColor];
    bin.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:21];
    bin.textAlignment=NSTextAlignmentLeft;
    [mainscroll addSubview:bin];
    
    UILabel *bin2=[[UILabel alloc]initWithFrame:CGRectMake(128, group.frame.origin.y+group.frame.size.height+5, 120, 22)];
    bin2.text=[NSString stringWithFormat:@"900020"];
    bin2.textColor=[UIColor whiteColor];
    bin2.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:21];
    bin2.textAlignment=NSTextAlignmentLeft;
    [mainscroll addSubview:bin2];
    
    UILabel *pcn=[[UILabel alloc]initWithFrame:CGRectMake(15, bin.frame.origin.y+bin.frame.size.height+5,120, 22)];
    pcn.text=[NSString stringWithFormat:@"PCN:"];
    pcn.textColor=[UIColor whiteColor];
    pcn.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:21];
    pcn.textAlignment=NSTextAlignmentLeft;
    [mainscroll addSubview:pcn];
    
    UILabel *pcn2=[[UILabel alloc]initWithFrame:CGRectMake(128, bin.frame.origin.y+bin.frame.size.height+5,120, 22)];
    pcn2.text=[NSString stringWithFormat:@"CLAIMNE"];
    pcn2.textColor=[UIColor whiteColor];
    pcn2.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:21];
    pcn2.textAlignment=NSTextAlignmentLeft;
    [mainscroll addSubview:pcn2];
    
    UILabel *desc=[[UILabel alloc]initWithFrame:CGRectMake(15, pcn.frame.origin.y+pcn.frame.size.height+14, [[UIScreen mainScreen]bounds].size.width,20)];
    desc.text=[NSString stringWithUTF8String:"10-80% OFF ALL FDA Approved Prescriptions"];
    desc.textColor=[UIColor whiteColor];
    desc.numberOfLines=2;
    desc.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:13];
    desc.textAlignment=NSTextAlignmentLeft;
    [mainscroll addSubview:desc];
    
    
    UILabel *faq=[[UILabel alloc]initWithFrame:CGRectMake(15, desc.frame.origin.y+desc.frame.size.height+6,40, 20)];
    faq.text=[NSString stringWithFormat:@"FAQ"];
    faq.textColor=[UIColor whiteColor];
    faq.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:14];
    faq.textAlignment=NSTextAlignmentLeft;
    [mainscroll addSubview:faq];
    
    //    UILabel *faq1=[[UILabel alloc]initWithFrame:CGRectMake(0, faq.frame.origin.y+faq.frame.size.height, 10, 20)];
    //    faq1.text=[NSString stringWithFormat:@"."];
    //    faq1.textColor=[UIColor whiteColor];
    //    faq1.font=[UIFont systemFontOfSize:18];
    //    faq1.textAlignment=NSTextAlignmentLeft;
    //    [mainscroll addSubview:faq1];
    
    
    UIImageView *bullet1=[[UIImageView alloc]initWithFrame:CGRectMake(20, faq.frame.origin.y+faq.frame.size.height+6, 20, 20)];
    bullet1.image=[UIImage imageNamed:@"arrowimagestatic"];
    bullet1.userInteractionEnabled=YES;
    [mainscroll addSubview:bullet1];
    
    
    UILabel *faq1n=[[UILabel alloc]initWithFrame:CGRectMake(50, faq.frame.origin.y+faq.frame.size.height+5,250, 20)];
    faq1n.text=[NSString stringWithUTF8String:"This discount card is 100% FREE"];
    faq1n.textColor=[UIColor whiteColor];
    faq1n.font=[UIFont fontWithName:@"Helvetica" size:14];
    faq1n.textAlignment=NSTextAlignmentLeft;
    [mainscroll addSubview:faq1n];
    
    //    UILabel *faq2=[[UILabel alloc]initWithFrame:CGRectMake(0, faq1.frame.origin.y+faq1.frame.size.height, 10, 20)];
    //    faq2.text=[NSString stringWithFormat:@"."];
    //    faq2.textColor=[UIColor whiteColor];
    //    faq2.font=[UIFont systemFontOfSize:18];
    //    faq2.textAlignment=NSTextAlignmentLeft;
    //    [mainscroll addSubview:faq2];
    
    
    UIImageView *bullet2=[[UIImageView alloc]initWithFrame:CGRectMake(20, bullet1.frame.origin.y+bullet1.frame.size.height+10, 20, 20)];
    bullet2.image=[UIImage imageNamed:@"arrowimagestatic"];
    bullet2.userInteractionEnabled=YES;
    [mainscroll addSubview:bullet2];
    
    NSLog(@"height.... :%f",bullet1.frame.origin.y+bullet1.frame.size.height);
    
    UILabel *faq2n=[[UILabel alloc]initWithFrame:CGRectMake(50,  faq1n.frame.origin.y+faq1n.frame.size.height+12, 250, 20)];
    faq2n.text=[NSString stringWithFormat:@"Use for your entire family; PETS too"];
    faq2n.textColor=[UIColor whiteColor];
    faq2n.font=[UIFont fontWithName:@"Helvetica" size:14];
    faq2n.textAlignment=NSTextAlignmentLeft;
    [mainscroll addSubview:faq2n];
    
    //    UILabel *faq3=[[UILabel alloc]initWithFrame:CGRectMake(0, bullet2.frame.origin.y+bullet2.frame.size.height, 10, 20)];
    //    faq3.text=[NSString stringWithFormat:@"."];
    //    faq3.textColor=[UIColor whiteColor];
    //    faq3.font=[UIFont systemFontOfSize:18];
    //    faq3.textAlignment=NSTextAlignmentLeft;
    //    [mainscroll addSubview:faq3];
    
    
    UIImageView *bullet3=[[UIImageView alloc]initWithFrame:CGRectMake(20, bullet2.frame.origin.y+bullet2.frame.size.height+9, 20, 20)];
    bullet3.image=[UIImage imageNamed:@"arrowimagestatic"];
    bullet3.userInteractionEnabled=YES;
    [mainscroll addSubview:bullet3];
    
    
    
    UILabel *faq3n=[[UILabel alloc]initWithFrame:CGRectMake(50, bullet2.frame.origin.y+bullet2.frame.size.height+7, 250, 40)];
    faq3n.text=[NSString stringWithFormat:@"Accepted at over 61,000 pharmacies nationwide"];
    faq3n.textColor=[UIColor whiteColor];
    faq3n.numberOfLines=2;
    faq3n.font=[UIFont fontWithName:@"Helvetica" size:14];
    faq3n.textAlignment=NSTextAlignmentLeft;
    [mainscroll addSubview:faq3n];
    
    //    UILabel *faq4=[[UILabel alloc]initWithFrame:CGRectMake(0, bullet3.frame.origin.y+bullet3.frame.size.height+15, 10, 20)];
    //    faq4.text=[NSString stringWithFormat:@"."];
    //    faq4.textColor=[UIColor whiteColor];
    //    faq4.font=[UIFont systemFontOfSize:18];
    //    faq4.textAlignment=NSTextAlignmentLeft;
    //    [mainscroll addSubview:faq4];
    
    UIImageView *bullet4=[[UIImageView alloc]initWithFrame:CGRectMake(20, bullet3.frame.origin.y+bullet3.frame.size.height+15, 20, 20)];
    bullet4.image=[UIImage imageNamed:@"arrowimagestatic"];
    bullet4.userInteractionEnabled=YES;
    [mainscroll addSubview:bullet4];
    
    
    
    UILabel *faq4n=[[UILabel alloc]initWithFrame:CGRectMake(50, bullet3.frame.origin.y+bullet3.frame.size.height+15, [[UIScreen mainScreen]bounds].size.width-40, 55)];
    faq4n.text=[NSString stringWithFormat:@"Present this to pharmacy - ask them to give you the cheaper of your insurance or your MyEchain discount card"];
    faq4n.textColor=[UIColor whiteColor];
    faq4n.numberOfLines=3;
    faq4n.font=[UIFont fontWithName:@"Helvetica" size:14];
    faq4n.textAlignment=NSTextAlignmentLeft;
    [mainscroll addSubview:faq4n];
    
    UILabel *help_no=[[UILabel alloc]initWithFrame:CGRectMake(10, faq4n.frame.origin.y+faq4n.frame.size.height+10, 280, 20)];
    help_no.text=[NSString stringWithFormat:@"Pharmacy Help Line: # 888-299-5383"];
    help_no.textColor=[UIColor blackColor];
    help_no.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:15];
    help_no.textAlignment=NSTextAlignmentCenter;
    [mainscroll addSubview:help_no];
    
    UILabel *lastlb=[[UILabel alloc]initWithFrame:CGRectMake(10, help_no.frame.origin.y+help_no.frame.size.height+10, 280, 20)];
    lastlb.text=[NSString stringWithFormat:@"This is NOT Insurance"];
    lastlb.textColor=[UIColor whiteColor];
    lastlb.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:15];
    lastlb.textAlignment=NSTextAlignmentCenter;
    [mainscroll addSubview:lastlb];
    
    
}
-(void)back
{
    
//    QTCardHomeViewController *home=[[QTCardHomeViewController alloc]init];
//    [self.navigationController pushViewController:home animated:NO];
    
   
    [self dismissModalViewControllerAnimated:YES];
    
    
   // [self.navigationController popViewControllerAnimated:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
