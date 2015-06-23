//
//  QTpiechartViewController.m
//  MyEchain
//
//  Created by maxcon8 on 21/01/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "QTpiechartViewController.h"
#define PIE_HEIGHT 200
@interface QTpiechartViewController ()

@end

@implementation QTpiechartViewController
@synthesize company_id,pieChartView,pieContainer,colorArray,selLabel,valueArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"QTpiechartViewController");
    
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
    
    
    
    UIButton *back=[[UIButton alloc]initWithFrame:CGRectMake(10,32, 100/2, 33/2)];
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

    
    
}
-(void)viewDidAppear:(BOOL)animated
{

    [super viewDidAppear:animated];
    
    
    NSError *error;
    
    urlString1 = [NSString stringWithFormat:@"http://www.esolz.co.in/lab1/Web/myEchain/Iosapp/deal_details.php?company_id=%@&user_id=%@",company_id,[[NSUserDefaults standardUserDefaults]objectForKey:@"id"]];
    
    NSData *dataURL1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString1]];
    NSLog(@"hhhhh===%@",urlString1);
    
    
    redm_dict = [NSJSONSerialization JSONObjectWithData:dataURL1 options:kNilOptions error:&error];
    
    NSLog(@"dataurl is %@",redm_dict);
    
    
    if ([[redm_dict objectForKey:@"redeem_value"]intValue] == 0 && [[redm_dict objectForKey:@"buy_count"]intValue] == 0)
    {
        
    }
    else
    {
    opesnumber=[[redm_dict objectForKey:@"redeem_value"]intValue]-[[redm_dict objectForKey:@"buy_count"]intValue];
    
    resnumber=[[redm_dict objectForKey:@"buy_count"]intValue];
    percnt=(([[redm_dict objectForKey:@"buy_count"]intValue])*100)/[[redm_dict objectForKey:@"redeem_value"]intValue];
    
   }
    NSLog(@"percentttt==%d",percnt);
    
    //    opesnumber=1;
    //    resnumber=9;
    
    

    NSLog(@"selfvalue... %lu",(unsigned long)self.valueArray.count);
    
    
//    if (self.valueArray.count != 0)
//
//    {
    //    self.valueArray = [[NSMutableArray alloc] initWithObjects:
    //                                             [NSNumber numberWithInt:resnumber],
    //
    //                                              nil];
    
    
    
    //    self.colorArray = [NSMutableArray arrayWithObjects:
    //                       [UIColor colorWithRed:(127.0f/255.0f) green:(206.0f/255.0f) blue:(245.0f/255.0f) alpha:.8],
    //                      nil];
    
    if (opesnumber == 0)
    {
        self.valueArray = [[NSMutableArray alloc] initWithObjects:
                           [NSNumber numberWithInt:resnumber],
                           [NSNumber numberWithInt:1],
                           nil];
    }
    else
    {
        self.valueArray = [[NSMutableArray alloc] initWithObjects:
                           [NSNumber numberWithInt:resnumber],
                           [NSNumber numberWithInt:opesnumber],
                           nil];
    }
    NSLog(@"self.valuearray--- %@",self.valueArray);
        
    self.colorArray = [NSMutableArray arrayWithObjects:
                       [UIColor whiteColor],
                       [UIColor grayColor],nil];
    
    
    
    
    CGRect pieFrame = CGRectMake([[UIScreen mainScreen]bounds].size.width/2-100,80, PIE_HEIGHT, PIE_HEIGHT);
    
    UIImage *shadowImg = [UIImage imageNamed:@"shadow.png"];
    UIImageView *shadowImgView = [[UIImageView alloc]initWithImage:shadowImg];
    shadowImgView.frame = CGRectMake(0, pieFrame.origin.y + PIE_HEIGHT*0.92, shadowImg.size.width/2, shadowImg.size.height/2);
    [self.view addSubview:shadowImgView];
    
    self.pieContainer = [[UIView alloc]initWithFrame:pieFrame];
    self.pieChartView = [[PieChartView alloc]initWithFrame:self.pieContainer.bounds withValue:self.valueArray withColor:self.colorArray];
    self.pieChartView.delegate = self;
    [self.pieContainer addSubview:self.pieChartView];
    [self.pieChartView setAmountText:@""];
    [mainview addSubview:self.pieContainer];
    
    
    //    UIView *midview=[[UIView alloc]initWithFrame:CGRectMake(25+50, 103, PIE_HEIGHT-40, PIE_HEIGHT-40)];
    //    midview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"1-splashbg-1"]];
    //    midview.layer.cornerRadius=80;
    //    midview.clipsToBounds=YES;
    //    [mainview addSubview:midview];
    
    
    //add selected view
    UIImageView *selView = [[UIImageView alloc]init];
    selView.image = [UIImage imageNamed:@"select.png"];
    selView.frame = CGRectMake((self.view.frame.size.width - selView.image.size.width/2)/2, self.pieContainer.frame.origin.y + self.pieContainer.frame.size.height, selView.image.size.width/2, selView.image.size.height/2);
    [self.view addSubview:selView];
    
    self.selLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 24, selView.image.size.width/2, 21)];
    self.selLabel.backgroundColor = [UIColor clearColor];
    self.selLabel.textAlignment = NSTextAlignmentCenter;
    self.selLabel.font = [UIFont systemFontOfSize:17];
    self.selLabel.textColor = [UIColor whiteColor];
    [selView addSubview:self.selLabel];
    // [self.pieChartView setTitleText:[NSString stringWithFormat:@"%d%%",percnt]];
    // self.title = @"";
    self.view.backgroundColor = [self colorFromHexRGB:@"f3f3f3"];
    
    
    UILabel *percnt_lb=[[UILabel alloc]initWithFrame:CGRectMake(0, 280, [[UIScreen mainScreen]bounds].size.width, 30)];
    percnt_lb.text=[NSString stringWithFormat:@"%d%%",percnt];
    percnt_lb.textAlignment=NSTextAlignmentCenter;
    percnt_lb.textColor=[UIColor whiteColor];
    percnt_lb.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:20];
    [mainview addSubview:percnt_lb];
    
    
    UILabel *redeem_statlb=[[UILabel alloc]initWithFrame:CGRectMake(0, 290+35, [[UIScreen mainScreen]bounds].size.width, 30)];
    redeem_statlb.text=@"Current Redeem Status";
    redeem_statlb.textAlignment=NSTextAlignmentCenter;
    redeem_statlb.textColor=[UIColor whiteColor];
    redeem_statlb.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:20];
    [mainview addSubview:redeem_statlb];
    
    
    UILabel *pielb_buy=[[UILabel alloc]initWithFrame:CGRectMake(0, redeem_statlb.frame.origin.y+redeem_statlb.frame.size.height+5, [[UIScreen mainScreen]bounds].size.width/2-10, 25)];
    pielb_buy.text=[NSString stringWithFormat:@"%d",[[redm_dict objectForKey:@"buy_count"]intValue]];
    pielb_buy.textAlignment=NSTextAlignmentRight;
    pielb_buy.textColor=[UIColor whiteColor];
    pielb_buy.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:20];
    [mainview addSubview:pielb_buy];
    
    UILabel *pielb_val=[[UILabel alloc]initWithFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width/2, redeem_statlb.frame.origin.y+redeem_statlb.frame.size.height+5, [[UIScreen mainScreen]bounds].size.width/2, 25)];
    pielb_val.text=[NSString stringWithFormat:@"/%d",[[redm_dict objectForKey:@"redeem_value"]intValue]];
    pielb_val.textAlignment=NSTextAlignmentLeft;
    pielb_val.textColor=[UIColor whiteColor];
    pielb_val.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:20];
    [mainview addSubview:pielb_val];
    
    
    UILabel *title1=[[UILabel alloc]initWithFrame:CGRectMake(0, pielb_val.frame.origin.y+pielb_val.frame.size.height+10, [[UIScreen mainScreen]bounds].size.width, 20)];
    title1.text=@"Current Redeem Stored";
    title1.textAlignment=NSTextAlignmentCenter;
    title1.backgroundColor=[UIColor clearColor];
    title1.textColor=[UIColor whiteColor];
    title1.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:20];
    [mainview addSubview:title1];
    
    
    UILabel *title2=[[UILabel alloc]initWithFrame:CGRectMake(0, title1.frame.origin.y+title1.frame.size.height+5, [[UIScreen mainScreen]bounds].size.width, 25)];
    // title2.text=[NSString stringWithFormat:@"%d",[[redm_dict objectForKey:@"redeem_value"]intValue]-[[redm_dict objectForKey:@"buy_count"]intValue]];
    title2.text=[NSString stringWithFormat:@"%@",[redm_dict objectForKey:@"redeem_amount"]];
    title2.textAlignment=NSTextAlignmentCenter;
    title2.backgroundColor=[UIColor clearColor];
    title2.textColor=[UIColor whiteColor];
    title2.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:20];
    [mainview addSubview:title2];
    
    
    UILabel *title3=[[UILabel alloc]initWithFrame:CGRectMake(0, title2.frame.origin.y+title2.frame.size.height+10, [[UIScreen mainScreen]bounds].size.width, 20)];
    title3.text=@"You have to buy more";
    title3.textAlignment=NSTextAlignmentCenter;
    title3.backgroundColor=[UIColor clearColor];
    title3.textColor=[UIColor whiteColor];
    title3.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:20];
    [mainview addSubview:title3];
    
    UILabel *title4=[[UILabel alloc]initWithFrame:CGRectMake(0, title3.frame.origin.y+title3.frame.size.height+5, [[UIScreen mainScreen]bounds].size.width, 25)];
    title4.text=[NSString stringWithFormat:@"%d",[[redm_dict objectForKey:@"redeem_value"]intValue]-[[redm_dict objectForKey:@"buy_count"]intValue]];
    title4.textAlignment=NSTextAlignmentCenter;
    title4.backgroundColor=[UIColor clearColor];
    title4.textColor=[UIColor whiteColor];
    title4.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:20];
    [mainview addSubview:title4];
    
    
    //    UIView *opencircle = [[UIView alloc] initWithFrame:CGRectMake(20,40,10,10)];
    //    opencircle.layer.cornerRadius = 10;
    //    opencircle.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(218.0f/255.0f) blue:(115.0f/255.0f) alpha:.8];
    //    [mainview addSubview:opencircle];
    //
    //    UILabel *openlbl1=[[UILabel alloc]initWithFrame:CGRectMake(35, 30, 40, 30)];
    //    openlbl1.text=@"Open";
    //    openlbl1.textColor=[UIColor lightGrayColor];
    //    openlbl1.font=[UIFont systemFontOfSize:14];
    //    openlbl1.textAlignment=NSTextAlignmentCenter;
    //    [mainview addSubview:openlbl1];
    //
    //    UIView *resolvcircle = [[UIView alloc] initWithFrame:CGRectMake(20,70,10,10)];
    //    resolvcircle.layer.cornerRadius = 10;
    //    resolvcircle.backgroundColor = [UIColor colorWithRed:(127.0f/255.0f) green:(206.0f/255.0f) blue:(245.0f/255.0f) alpha:.8];
    //    [mainview addSubview:resolvcircle];
    //
    //    UILabel *resolvlbl=[[UILabel alloc]initWithFrame:CGRectMake(35, 60, 40, 30)];
    //    resolvlbl.text=@"Done";
    //    resolvlbl.textColor=[UIColor lightGrayColor];
    //    resolvlbl.font=[UIFont systemFontOfSize:14];
    //    resolvlbl.textAlignment=NSTextAlignmentCenter;
    //    [mainview addSubview:resolvlbl];
    
    
    [self.pieChartView reloadChart];
    //}


}
- (UIColor *) colorFromHexRGB:(NSString *) inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}


- (void)selectedFinish:(PieChartView *)pieChartView index:(NSInteger)index percent:(float)per
{
    self.selLabel.text = [NSString stringWithFormat:@"%2.2f%@",per*100,@"%"];
}
-(void)back
{
   // [self.navigationController popViewControllerAnimated:NO];
    
   [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
