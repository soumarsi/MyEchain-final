//
//  QTcust_detailsViewController.m
//  MyEchain
//
//  Created by maxcon8 on 09/01/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "QTcust_detailsViewController.h"
#import "QTCarddetailViewController.h"


@interface QTcust_detailsViewController ()

@end

@implementation QTcust_detailsViewController
@synthesize card_id,card_details;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"QTcust_detailsViewController");
    // Do any additional setup after loading the view.
    
    mainview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height )];
    mainview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"1-splashbg-1"]];
    [self.view addSubview:mainview];
    
//    edit_nonbrand=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height )];
//    edit_nonbrand.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"1-splashbg-1"]];
//    [self.view addSubview:edit_nonbrand];
    
    edit_nonbrand=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 80, 320,400)];
    
    edit_nonbrand.backgroundColor=[UIColor clearColor];
    edit_nonbrand.delegate=self;
    //det_scroll.showsHorizontalScrollIndicator=NO;
    edit_nonbrand.showsVerticalScrollIndicator=NO;
    [mainview addSubview:edit_nonbrand];
    
    headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
    headview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar.png"]];
    [mainview addSubview:headview];
    
    UIImageView *headimg=[[UIImageView alloc]initWithFrame:CGRectMake(120, 28, 183/2, 30)];
    headimg.image=[UIImage imageNamed:@"topbar-logo"];
    [headview addSubview:headimg];
    
    UIButton *back=[[UIButton alloc]initWithFrame:CGRectMake(10,35, 100/2, 33/2)];
    [back addTarget:self action:@selector(back_nobrand) forControlEvents:UIControlEventTouchUpInside];
    [back setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [[back titleLabel] setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
    back.userInteractionEnabled=YES;
    [headview addSubview:back];
    
    
    UIView *tview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    tview.backgroundColor=[UIColor clearColor];
    tview.userInteractionEnabled=YES;
    [headview addSubview:tview];
    
    UITapGestureRecognizer *btap= [[UITapGestureRecognizer alloc] initWithTarget:self
                                   
                                                                          action:@selector(back_nobrand)];
    
    btap.numberOfTapsRequired=1;
    
    [tview addGestureRecognizer:btap];
    
    
    UILabel *donelb=[[UILabel alloc]initWithFrame:CGRectMake(200, 25, 150, 35)];
    donelb.textAlignment=NSTextAlignmentCenter;
    donelb.backgroundColor=[UIColor clearColor];
    donelb.text=@"DONE";
    //donelb.textColor=[UIColor colorWithRed:(15/255.0f) green:(123/255.0f) blue:(255/255.0f) alpha:1];
    donelb.textColor=[UIColor blackColor];
    [headview addSubview:donelb];
    
    
    UITapGestureRecognizer *done_tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(done_btnfn)];
    [donelb addGestureRecognizer:done_tap];
    donelb.userInteractionEnabled=YES;

    
    
    
    //array initalization for fetching all data
    
    data_arr=[[NSMutableArray alloc]init];
    
     NSString *userid=[[NSUserDefaults standardUserDefaults]objectForKey:@"id"];
    
    //url fetching according to current location
    
    NSString *url2 = [NSString stringWithFormat:@"http://www.esolz.co.in/lab1/Web/myEchain/Iosapp/cust_form_details.php?user_id=%@&company_id=%@",userid,card_id];
    
    NSLog(@"url2===%@",url2);
    
    //fetching data returning from url to the array
    
      NSError *error;
    
    NSURL *requestURL1 = [NSURL URLWithString:url2];
    
    NSData *signeddataURL1 =  [NSData dataWithContentsOfURL:requestURL1 options:NSDataReadingUncached error:&error];
    
  
    
    
  result = [NSJSONSerialization
                                    
                                    JSONObjectWithData:signeddataURL1
                                    
                                    
                                    
                                    options:kNilOptions
                                    
                                    error:&error];
    
    
    for(NSMutableDictionary *dict_news1 in [result objectForKey:@"list"])
        
    {
       // if ([[dict_news1 objectForKey:@"required"] isEqualToString:@"1"]) {
            
                 [data_arr addObject:dict_news1];
       // }
        
        
        
    }

    NSLog(@"data_arr===%@",data_arr);
    edit_nonbrand.contentSize=CGSizeMake(0, 600);
    
NSLog(@"nowwww====%@",[result objectForKey:[NSString stringWithFormat:@"%@",[[data_arr objectAtIndex:0]objectForKey:@"name"]]]);
    
    //name===========
    
    
    if ([[[data_arr objectAtIndex:0] objectForKey:@"required"] isEqualToString:@"1"]) {
         height=40;
        nxtht=10;
        
    }
    else
    {
    
        height=0;
        nxtht=0;
    
    }
    
    UIView *pad_vw=[[UIView alloc]initWithFrame:CGRectMake(10,0 , 300, height)];
    pad_vw.backgroundColor=[UIColor whiteColor];
    pad_vw.alpha=0.5;
    [edit_nonbrand addSubview:pad_vw];
    
    //name textfield
    nametxt=[[UITextField alloc]initWithFrame:CGRectMake(10,0 , 250, height)];
    nametxt.backgroundColor=[UIColor clearColor];
    nametxt.delegate=self;
    nametxt.font= [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:14];
    nametxt.text=[NSString stringWithFormat:@"%@",[result objectForKey:[NSString stringWithFormat:@"%@",[[data_arr objectAtIndex:0]objectForKey:@"name"]]]];
    UIColor *color1 = [UIColor grayColor];
    nametxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[[data_arr objectAtIndex:0] objectForKey:@"name"]] attributes:@{NSForegroundColorAttributeName: color1}];
    nametxt.textAlignment=NSTextAlignmentLeft;
    nametxt.delegate=self;
    [pad_vw addSubview:nametxt];
    
    //===================
    nxtht2=nxtht;
    if ([[[data_arr objectAtIndex:1] objectForKey:@"required"] isEqualToString:@"1"]) {
        height=40;
        nxtht=10;
    }
    else
    {
        
        height=0;
        nxtht=0;
        
    }
    
    
    UIView *pad_vw1=[[UIView alloc]initWithFrame:CGRectMake(10,pad_vw.frame.origin.y+pad_vw.frame.size.height+nxtht2 , 300, height)];
    pad_vw1.backgroundColor=[UIColor whiteColor];
    pad_vw1.alpha=0.5;
    [edit_nonbrand addSubview:pad_vw1];
    
    //name textfield
    emailtxt=[[UITextField alloc]initWithFrame:CGRectMake(10,0 , 250, height)];
    emailtxt.backgroundColor=[UIColor clearColor];
    emailtxt.delegate=self;
    emailtxt.font= [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:14];
    emailtxt.text=[NSString stringWithFormat:@"%@",[result objectForKey:[NSString stringWithFormat:@"%@",[[data_arr objectAtIndex:1]objectForKey:@"name"]]]];
    color1 = [UIColor grayColor];
    emailtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[[data_arr objectAtIndex:1] objectForKey:@"name"]] attributes:@{NSForegroundColorAttributeName: color1}];
    emailtxt.textAlignment=NSTextAlignmentLeft;
    emailtxt.delegate=self;
    [pad_vw1 addSubview:emailtxt];
///////////////////////////////////////////////
    nxtht2=nxtht;
    if ([[[data_arr objectAtIndex:2] objectForKey:@"required"] isEqualToString:@"1"]) {
        height=40;
        nxtht=10;
    }
    else
    {
        
        height=0;
        nxtht=0;
        
    }
    
    
    UIView *pad_vw2=[[UIView alloc]initWithFrame:CGRectMake(10,pad_vw1.frame.origin.y+pad_vw1.frame.size.height+nxtht2 , 300, height)];
    pad_vw2.backgroundColor=[UIColor whiteColor];
    pad_vw2.alpha=0.5;
    [edit_nonbrand addSubview:pad_vw2];
    
    //name textfield
    sextxt=[[UITextField alloc]initWithFrame:CGRectMake(10,0 , 250, height)];
    sextxt.backgroundColor=[UIColor clearColor];
    sextxt.delegate=self;
    sextxt.font= [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:14];
    sextxt.text=[NSString stringWithFormat:@"%@",[result objectForKey:[NSString stringWithFormat:@"%@",[[data_arr objectAtIndex:2]objectForKey:@"name"]]]];
    color1 = [UIColor grayColor];
    sextxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[[data_arr objectAtIndex:2] objectForKey:@"name"]] attributes:@{NSForegroundColorAttributeName: color1}];
    sextxt.textAlignment=NSTextAlignmentLeft;
    sextxt.delegate=self;
    [pad_vw2 addSubview:sextxt];
    
  //////////////////////////////////////
    nxtht2=nxtht;
    
    if ([[[data_arr objectAtIndex:3] objectForKey:@"required"] isEqualToString:@"1"]) {
        height=40;
        nxtht=10;
    }
    else
    {
        nxtht=0;
        height=0;
        
    }
    
    
    UIView *pad_vw3=[[UIView alloc]initWithFrame:CGRectMake(10,pad_vw2.frame.origin.y+pad_vw2.frame.size.height+nxtht2 , 300, height)];
    pad_vw3.backgroundColor=[UIColor whiteColor];
    pad_vw3.alpha=0.5;
    [edit_nonbrand addSubview:pad_vw3];
    
    //name textfield
    addrtxt=[[UITextField alloc]initWithFrame:CGRectMake(10,0 , 250, height)];
    addrtxt.backgroundColor=[UIColor clearColor];
    addrtxt.delegate=self;
    addrtxt.font= [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:14];
    addrtxt.text=[NSString stringWithFormat:@"%@",[result objectForKey:[NSString stringWithFormat:@"%@",[[data_arr objectAtIndex:3]objectForKey:@"name"]]]];
    color1 = [UIColor grayColor];
    addrtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[[data_arr objectAtIndex:3] objectForKey:@"name"]] attributes:@{NSForegroundColorAttributeName: color1}];
    addrtxt.textAlignment=NSTextAlignmentLeft;
    addrtxt.delegate=self;
    [pad_vw3 addSubview:addrtxt];
    
   ///////////////////////////////////////
    nxtht2=nxtht;
    if ([[[data_arr objectAtIndex:4] objectForKey:@"required"] isEqualToString:@"1"]) {
        height=40;
        nxtht=10;
    }
    else
    {
        
        height=0;
        nxtht=0;
        
    }
    
    
    UIView *pad_vw4=[[UIView alloc]initWithFrame:CGRectMake(10,pad_vw3.frame.origin.y+pad_vw3.frame.size.height+nxtht2 , 300, height)];
    pad_vw4.backgroundColor=[UIColor whiteColor];
    pad_vw4.alpha=0.5;
    [edit_nonbrand addSubview:pad_vw4];
    
    //name textfield
    addr2txt=[[UITextField alloc]initWithFrame:CGRectMake(10,0 , 250, height)];
    addr2txt.backgroundColor=[UIColor clearColor];
    addr2txt.delegate=self;
    addr2txt.font= [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:14];
    addr2txt.text=[NSString stringWithFormat:@"%@",[result objectForKey:[NSString stringWithFormat:@"%@",[[data_arr objectAtIndex:4]objectForKey:@"name"]]]];
    color1 = [UIColor grayColor];
    addr2txt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[[data_arr objectAtIndex:4] objectForKey:@"name"]] attributes:@{NSForegroundColorAttributeName: color1}];
    addr2txt.textAlignment=NSTextAlignmentLeft;
    addr2txt.delegate=self;
    [pad_vw4 addSubview:addr2txt];
    
///////////////////////////////////
    nxtht2=nxtht;
    if ([[[data_arr objectAtIndex:5] objectForKey:@"required"] isEqualToString:@"1"]) {
        height=40;
        nxtht=10;
    }
    else
    {
        
        height=0;
        nxtht=0;
        
    }

    
    UIView *pad_vw5=[[UIView alloc]initWithFrame:CGRectMake(10,pad_vw4.frame.origin.y+pad_vw4.frame.size.height+nxtht2 , 300, height)];
    pad_vw5.backgroundColor=[UIColor whiteColor];
    pad_vw5.alpha=0.5;
    [edit_nonbrand addSubview:pad_vw5];
    
    //name textfield
    citytxt=[[UITextField alloc]initWithFrame:CGRectMake(10,0 , 250, height)];
    citytxt.backgroundColor=[UIColor clearColor];
    citytxt.delegate=self;
    citytxt.font= [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:14];
    citytxt.text=[NSString stringWithFormat:@"%@",[result objectForKey:[NSString stringWithFormat:@"%@",[[data_arr objectAtIndex:5]objectForKey:@"name"]]]];
    color1 = [UIColor grayColor];
    citytxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[[data_arr objectAtIndex:5] objectForKey:@"name"]] attributes:@{NSForegroundColorAttributeName: color1}];
    citytxt.textAlignment=NSTextAlignmentLeft;
    citytxt.delegate=self;
    [pad_vw5 addSubview:citytxt];
    
////////////////////////////////////////////////////////
    
    nxtht2=nxtht;
    if ([[[data_arr objectAtIndex:6] objectForKey:@"required"] isEqualToString:@"1"]) {
        height=40;
        nxtht=10;
    }
    else
    {
        
        height=0;
        nxtht=0;
        
    }
    
    
    UIView *pad_vw6=[[UIView alloc]initWithFrame:CGRectMake(10,pad_vw5.frame.origin.y+pad_vw5.frame.size.height+nxtht2 , 300, height)];
    pad_vw6.backgroundColor=[UIColor whiteColor];
    pad_vw6.alpha=0.5;
    [edit_nonbrand addSubview:pad_vw6];
    
    //name textfield
    statetxt=[[UITextField alloc]initWithFrame:CGRectMake(10,0 , 250, height)];
    statetxt.backgroundColor=[UIColor clearColor];
    statetxt.delegate=self;
    statetxt.font= [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:14];
    statetxt.text=[NSString stringWithFormat:@"%@",[result objectForKey:[NSString stringWithFormat:@"%@",[[data_arr objectAtIndex:6]objectForKey:@"name"]]]];
    color1 = [UIColor grayColor];
    statetxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[[data_arr objectAtIndex:6] objectForKey:@"name"]] attributes:@{NSForegroundColorAttributeName: color1}];
    statetxt.textAlignment=NSTextAlignmentLeft;
    statetxt.delegate=self;
    [pad_vw6 addSubview:statetxt];
    
    
    /////////////////////////////////////////
    nxtht2=nxtht;
    if ([[[data_arr objectAtIndex:7] objectForKey:@"required"] isEqualToString:@"1"]) {
        height=40;
        nxtht=10;
    }
    else
    {
        
        height=0;
        nxtht=0;
        
    }
    
    
    UIView *pad_vw7=[[UIView alloc]initWithFrame:CGRectMake(10,pad_vw6.frame.origin.y+pad_vw6.frame.size.height+nxtht2 , 300, height)];
    pad_vw7.backgroundColor=[UIColor clearColor];
    pad_vw7.alpha=0.5;
    [edit_nonbrand addSubview:pad_vw7];
    
    //name textfield
    ziptxt=[[UITextField alloc]initWithFrame:CGRectMake(10,0 , 250, height)];
    ziptxt.backgroundColor=[UIColor clearColor];
    ziptxt.delegate=self;
    ziptxt.font= [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:14];
    ziptxt.text=[NSString stringWithFormat:@"%@",[result objectForKey:[NSString stringWithFormat:@"%@",[[data_arr objectAtIndex:7]objectForKey:@"name"]]]];
    color1 = [UIColor grayColor];
    ziptxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[[data_arr objectAtIndex:7] objectForKey:@"name"]] attributes:@{NSForegroundColorAttributeName: color1}];
    ziptxt.textAlignment=NSTextAlignmentLeft;
    ziptxt.delegate=self;
    [pad_vw7 addSubview:ziptxt];
  ///////////////////////////////////////////////////////
    nxtht2=nxtht;
    if ([[[data_arr objectAtIndex:8] objectForKey:@"required"] isEqualToString:@"1"]) {
        height=40;
        nxtht=10;
    }
    else
    {
        
        height=0;
        nxtht=0;
        
    }
    
    
    UIView *pad_vw8=[[UIView alloc]initWithFrame:CGRectMake(10,pad_vw7.frame.origin.y+pad_vw7.frame.size.height+nxtht2 , 300, height)];
    pad_vw8.backgroundColor=[UIColor whiteColor];
    pad_vw8.alpha=0.5;
    [edit_nonbrand addSubview:pad_vw8];
    
    //name textfield
    phntxt=[[UITextField alloc]initWithFrame:CGRectMake(10,0 , 250, height)];
    phntxt.backgroundColor=[UIColor clearColor];
    phntxt.delegate=self;
    phntxt.font= [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:14];
    phntxt.text=[NSString stringWithFormat:@"%@",[result objectForKey:[NSString stringWithFormat:@"%@",[[data_arr objectAtIndex:8]objectForKey:@"name"]]]];
    color1 = [UIColor grayColor];
    phntxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[[data_arr objectAtIndex:8] objectForKey:@"name"]] attributes:@{NSForegroundColorAttributeName: color1}];
    phntxt.textAlignment=NSTextAlignmentLeft;
    phntxt.delegate=self;
    [pad_vw8 addSubview:phntxt];
 
/////////////////////////////////////////////////
    nxtht2=nxtht;
    if ([[[data_arr objectAtIndex:9] objectForKey:@"required"] isEqualToString:@"1"]) {
        height=40;
        nxtht=10;
        
        pad_vw9=[[UIView alloc]initWithFrame:CGRectMake(10,pad_vw8.frame.origin.y+pad_vw8.frame.size.height+nxtht2 , 300, height)];
        pad_vw9.backgroundColor=[UIColor whiteColor];
        pad_vw9.alpha=0.5;
        [edit_nonbrand addSubview:pad_vw9];
        
        //name textfield
        birthtxt=[[UITextField alloc]initWithFrame:CGRectMake(10,5 , 250, height-5)];
        birthtxt.backgroundColor=[UIColor clearColor];
        birthtxt.delegate=self;
        birthtxt.userInteractionEnabled=NO;
        birthtxt.font= [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:14];
        birthtxt.text=[NSString stringWithFormat:@"%@",[result objectForKey:[NSString stringWithFormat:@"%@",[[data_arr objectAtIndex:9]objectForKey:@"name"]]]];
        color1 = [UIColor grayColor];
        birthtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[[data_arr objectAtIndex:9] objectForKey:@"name"]] attributes:@{NSForegroundColorAttributeName: color1}];
        birthtxt.textAlignment=NSTextAlignmentLeft;
        birthtxt.delegate=self;
        [pad_vw9 addSubview:birthtxt];
        
        
        
        
        
        cal_view=[[UIButton alloc]initWithFrame:CGRectMake(200, 5, 30, 30)];
        cal_view.backgroundColor=[UIColor whiteColor];
        [cal_view setBackgroundImage:[UIImage imageNamed:@"cal_cust.png"] forState:UIControlStateNormal];
        cal_view.titleLabel.textColor=[UIColor blackColor];
        [cal_view setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // [cal_view  addTarget:self action:@selector(birth_dt) forControlEvents:UIControlEventTouchUpInside];
        [pad_vw9 addSubview: cal_view];
        
        
        
        pickview=[[UIView alloc]initWithFrame:CGRectMake(10, 200, 300, 350)];
        pickview.backgroundColor=[UIColor whiteColor];
        //pickview.alpha=0.5;
        [self.view addSubview:pickview];
        [pickview setHidden:YES];
        
        cal_view=[[UIButton alloc]initWithFrame:CGRectMake(200, 5, 30, 30)];
        cal_view.backgroundColor=[UIColor whiteColor];
        // [cal_view setTitle:@"Process" forState:UIControlStateNormal];
        [cal_view setBackgroundImage:[UIImage imageNamed:@"cal_cust.png"] forState:UIControlStateNormal];
        cal_view.titleLabel.textColor=[UIColor blackColor];
        [cal_view setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cal_view  addTarget:self action:@selector(birth_dt) forControlEvents:UIControlEventTouchUpInside];
        [pad_vw9 addSubview: cal_view];
        
        
        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 300, 50, 260)];
        
        datePicker.datePickerMode = UIDatePickerModeDate;
        
        datePicker.hidden = YES;
        
        datePicker.date = [NSDate date];
        
        //datePicker.backgroundColor=[UIColor colorWithRed:(190.0f/255.0f) green:(190.0f/255.0f) blue:(190.0f/255.0f) alpha:0.5f];
        
        [datePicker addTarget:self
         
                       action:@selector(LabelChange:)
         
             forControlEvents:UIControlEventValueChanged];
        
        datePicker.maximumDate = [NSDate date];
        edit_nonbrand.userInteractionEnabled=YES;
        [self.view addSubview:datePicker];
        
 
        
        
        
    }
    else
    {
        
        height=0;
        nxtht=0;
        
    }
    
    
 

    
    
   
    
    
    //create table view to show data
    
    ListTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 80,[[UIScreen mainScreen]bounds].size.width,330)];
    ListTableview.delegate = self;
    ListTableview.dataSource = self;
    ListTableview.backgroundColor=[UIColor clearColor];
    ListTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
   // [edit_nonbrand addSubview:ListTableview];
    
   // [ListTableview reloadData];
    
  
//UIView *btn_back=[[UIView alloc]initWithFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width/2-50, 480, 100, 50)];
//    btn_back.backgroundColor=[UIColor whiteColor];
//    [mainview addSubview:btn_back];
//    
//    UIImageView *done_img=[[UIImageView alloc]initWithFrame:CGRectMake(5, 8, 30, 30)];
//    done_img.image=[UIImage imageNamed:@"thumbsup.png"];
//    [btn_back addSubview:done_img];
//    
//        UILabel *done_lb=[[UILabel alloc]initWithFrame:CGRectMake(40,  0,50, 50)];
//        done_lb.backgroundColor=[UIColor clearColor];
//        done_lb.lineBreakMode=NSLineBreakByWordWrapping;
//        done_lb.numberOfLines=2;
//        done_lb.textAlignment=NSTextAlignmentLeft;
//        done_lb.textColor=[UIColor blackColor];
//        done_lb.text=@"Done";
//        done_lb.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Md" size:12];
//        [btn_back addSubview:done_lb];
//    
//    
//    UITapGestureRecognizer *donetap= [[UITapGestureRecognizer alloc] initWithTarget:self
//                                        
//                                                                               action:@selector(done_btnfn)];
//    
//    donetap.numberOfTapsRequired=1;
//    btn_back.userInteractionEnabled=YES;
//    [btn_back addGestureRecognizer:donetap];
    
    
    
}
- (void)LabelChange:(id)sender{
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    df.dateStyle = NSDateFormatterNoStyle;
    
    df.dateFormat=@"MM-dd-yyyy";
    
    birthtxt.text = [NSString stringWithFormat:@"%@",[df stringFromDate:datePicker.date]];
    
    
    
   // NSString *datestring1= datelabel.text;
    
    
}
-(void)birth_dt
{
 [pickview setHidden:NO];
datePicker.hidden = NO;

}
-(void)done_btnfn
{

    
    NSLog(@"Done clicked==");
    
    
    NSString *check = emailtxt.text;
    NSRange whiteSpaceRange = [check rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
     if ([nametxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ].length < 1){
        
        UIAlertView *alert  = [[UIAlertView alloc]initWithTitle:@"" message:@"Name cannot be blank" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        
    }
    
    
    
    else if ([emailtxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ].length < 1){
        
        UIAlertView *alert  = [[UIAlertView alloc]initWithTitle:@"" message:@"Email cannot be blank" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        
    }
     else if (whiteSpaceRange.location != NSNotFound)
     {
         NSLog(@"Found whitespace");
         UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please omit whitespace in email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
         alert.tag=1;
         
         [alert show];
         
     }
     else if (![ self NSStringIsValidEmail:emailtxt.text])
     {
         
         UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please provide valid Email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
         alert.tag=1;
         
         [alert show];
         
         
     }
    
else
{

    NSLog(@"fetch url");
    
    NSString *urlString;
    
    urlString =[NSString stringWithFormat:@"%@update_cust_details.php?name=%@&email=%@&sex=%@&address=%@&address2=%@&city=%@&state=%@&zip=%@&phone=%@&birthday=%@&userid=%@&companyid=%@",APPS_DOMAIN_URL,[nametxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[emailtxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ],[sextxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ],[addrtxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[addr2txt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[citytxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[statetxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[ziptxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[phntxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[birthtxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults]objectForKey:@"id"],card_id];
    NSLog(@"register %@",urlString);
    NSError *error;
    NSLog(@"eta holo category:  %@",urlString);
    
    NSURL *requestURL1 = [NSURL URLWithString:urlString];
    
    NSData *signeddataURL1 =  [NSData dataWithContentsOfURL:requestURL1 options:NSDataReadingUncached error:&error];
    
    NSString *ret_str = [[NSString alloc] initWithData:signeddataURL1 encoding:NSUTF8StringEncoding];
    
    
    NSLog(@"dictionary====%@",ret_str);
    /////////////////////////////
    if([ret_str isEqualToString:@"success"])
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Edit completed successfully"
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
       alert.tag=10;
        [alert show];
        
       
        
        
    }
    else
    {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Not edited"
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    // alert.tag=0;
    [alert show];
    }
    
}
    
    
    
    

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag==10) {
        if (buttonIndex != [alertView cancelButtonIndex]) {
            NSLog(@"Launching the store");
            //replace appname with any specific name you want
           // [self.navigationController popViewControllerAnimated:NO];
            
            QTCarddetailViewController *card=[[QTCarddetailViewController alloc]init];
            card.card_dict=card_details;
            [self.navigationController pushViewController:card animated:NO];
            
            
            
            
        }
        
    }

    
    
}
-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return [data_arr count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.backgroundColor =[UIColor clearColor];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    
    
//    UILabel *TitleLbl=[[UILabel alloc]initWithFrame:CGRectMake(10,  cell.frame.origin.y, 100, cell.frame.size.height-5)];
//    TitleLbl.backgroundColor=[UIColor clearColor];
//    TitleLbl.lineBreakMode=NSLineBreakByWordWrapping;
//    TitleLbl.numberOfLines=2;
//    TitleLbl.textAlignment=NSTextAlignmentLeft;
//    TitleLbl.textColor=[UIColor blackColor];
//    TitleLbl.text=[NSString stringWithFormat:@"%@:",[[data_arr objectAtIndex:indexPath.row] objectForKey:@"name"]];
//    TitleLbl.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Md" size:12];
//    [cell addSubview:TitleLbl];
    
    
    
    
    UIView *pad_vw=[[UIView alloc]initWithFrame:CGRectMake(10,0 , 300, 40)];
    pad_vw.backgroundColor=[UIColor whiteColor];
    [cell addSubview:pad_vw];
    
    
    //name textfield
//    datatxt=[[UITextField alloc]initWithFrame:CGRectMake(10,0 , 250, 40)];
//    datatxt.backgroundColor=[UIColor clearColor];
//    datatxt.tag=indexPath.row;
//    datatxt.delegate=self;
//    datatxt.font= [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:14];
//    datatxt.text=[NSString stringWithFormat:@"%@",[result objectForKey:[NSString stringWithFormat:@"%@",[[data_arr objectAtIndex:indexPath.row]objectForKey:@"name"]]]];
//    UIColor *color1 = [UIColor grayColor];
//    datatxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[[data_arr objectAtIndex:indexPath.row] objectForKey:@"name"]] attributes:@{NSForegroundColorAttributeName: color1}];
//    datatxt.textAlignment=NSTextAlignmentLeft;
//    datatxt.delegate=self;
//    [pad_vw addSubview:datatxt];
//    
    
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}
//textfield delegate method
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
-(void)back_nobrand
{
    
    //   [edit_nonbrand removeFromSuperview];

    [self.navigationController popViewControllerAnimated:NO];
    
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
