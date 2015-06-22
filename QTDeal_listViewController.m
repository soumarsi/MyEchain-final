//
//  QTDeal_listViewController.m
//  MyEchain
//
//  Created by maxcon8 on 23/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "QTDeal_listViewController.h"
#import "QTSplashViewController.h"
#import "UIImageView+WebCache.h"

@interface QTDeal_listViewController ()

@end

@implementation QTDeal_listViewController
@synthesize company_id;
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
    
    NSLog(@"QTDeal_listViewController");
    
    // Do any additional setup after loading the view.
    
    expandedCells=[[NSMutableArray alloc]init];
    
    mainview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height )];
    mainview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"1-splashbg-1"]];
    [self.view addSubview:mainview];
    
    headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
    headview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar"]];
    [mainview addSubview:headview];
    
    UIImageView *headimg=[[UIImageView alloc]initWithFrame:CGRectMake(120, 25, 183/2, 30)];
    headimg.image=[UIImage imageNamed:@"topbar-logo"];
    [headview addSubview:headimg];
    
    
    
    
    
    
    imgspin = [[UIImageView alloc] initWithFrame:CGRectMake(110, 180, 100, 100)];
    [imgspin setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.56]];
    // imgspin.backgroundColor=[UIColor blackColor];
    [imgspin setUserInteractionEnabled:NO];
    imgspin.clipsToBounds=YES;
    imgspin.layer.cornerRadius=20;
    [[imgspin layer] setZPosition:2];
    // [mainview addSubview:imgspin];
    
    
    //start loader animation
    
    spinnern = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinnern.hidesWhenStopped = YES;
    spinnern.backgroundColor=[UIColor clearColor];
    
    spinnern.frame=CGRectMake(25,25,50,50);
    [imgspin addSubview: spinnern];
    //  [spinnern startAnimating];
    
    
    
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
    
    
    NSOperationQueue *queue2 = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self
                                                                            selector:@selector(dataImport)
                                                                              object:nil];
    [queue2 addOperation:operation];
    
    blackview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    blackview.backgroundColor=[UIColor blackColor];
    blackview.alpha=0.5;
    [self.view addSubview:blackview];
    [blackview setHidden:YES];
    
    lockview = [[UIView alloc] initWithFrame:CGRectMake(10, 200, 300,150)];
    lockview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"1-splashbg-1"]];
    [self.view addSubview:lockview];
    [lockview setHidden:YES];
    
    locktxt=[[UITextField alloc]initWithFrame:CGRectMake(10,20 , 280, 40)];
    locktxt.backgroundColor=[UIColor whiteColor];
    locktxt.delegate=self;
    //passwrdtxt.text=@"123456";
    locktxt.font= [UIFont systemFontOfSize:16];
    locktxt.placeholder=@"Lock key";
    UIColor *passcolor = [UIColor grayColor];
    locktxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Lock key" attributes:@{NSForegroundColorAttributeName: passcolor}];
    locktxt.secureTextEntry=YES;
    locktxt.delegate=self;
    locktxt.textAlignment=NSTextAlignmentCenter;
    [lockview addSubview:locktxt];
    
    savebtn=[[UIButton alloc]initWithFrame:CGRectMake(10, locktxt.frame.origin.y+locktxt.frame.size.height+10, 280, 30)];
    savebtn.backgroundColor=[UIColor whiteColor];
    [savebtn setTitle:@"Process" forState:UIControlStateNormal];
    //     [registerbtn setBackgroundImage:[UIImage imageNamed:@"register-nownew.png"] forState:UIControlStateNormal];
    savebtn.titleLabel.textColor=[UIColor blackColor];
    [savebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [savebtn  addTarget:self action:@selector(savelock) forControlEvents:UIControlEventTouchUpInside];
    [lockview addSubview: savebtn];
    
    cancelbtn=[[UIButton alloc]initWithFrame:CGRectMake(10, savebtn.frame.origin.y+savebtn.frame.size.height+10, 280, 30)];
    cancelbtn.backgroundColor=[UIColor whiteColor];
    [cancelbtn setTitle:@"Cancel" forState:UIControlStateNormal];
    //     [registerbtn setBackgroundImage:[UIImage imageNamed:@"register-nownew.png"] forState:UIControlStateNormal];
    cancelbtn.titleLabel.textColor=[UIColor blackColor];
    [cancelbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelbtn  addTarget:self action:@selector(cancellock) forControlEvents:UIControlEventTouchUpInside];
    [lockview addSubview:cancelbtn];
    
    
    
    
    
}
-(void)dataImport
{
    
    //    dispatch_queue_t queue = dispatch_queue_create("com.example.MyQueue", NULL);
    //
    //    dispatch_async(queue, ^{
    //
    //        // Do some computation here.
    //
    //
    //
    //        // Update UI after computation.
    //
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        //    dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        //    dispatch_async(q, ^{
        //
        
        dealarr=[[NSMutableArray alloc]init];
        NSString *urlString1;
        
        NSError *error=nil;
        
        
        //  urlString1 =[NSString stringWithFormat:@"%@company_deals.php?company_id=%@&start=0&limit=10",APPS_DOMAIN_URL,company_id];  //
        
        // urlString1 =[NSString stringWithFormat:@"%@deals_of_company.php?company_id=%@",APPS_DOMAIN_URL,company_id];
        
        urlString1 =[NSString stringWithFormat:@"http://esolz.co.in/lab1/Web/myEchain/get_deals.php?company_id=%@",company_id];
        
        NSLog(@"url==%@",urlString1);
        
        NSURL *requestURL1 = [NSURL URLWithString:urlString1];
        
        NSData *signeddataURL1 =  [NSData dataWithContentsOfURL:requestURL1 options:NSDataReadingUncached error:&error];
        
        
        
        
        dealarr = [NSJSONSerialization
                   
                   JSONObjectWithData:signeddataURL1
                   
                   
                   
                   options:kNilOptions
                   
                   error:&error];
        
        NSLog(@"dealarr====%@",dealarr);
        
        
        //        deal_dict=[NSJSONSerialization
        //
        //                                          JSONObjectWithData:signeddataURL1
        //
        //
        //
        //                                          options:kNilOptions
        //
        //                   error:&error];
        //
        //
        //    NSLog(@"return dict===%@",deal_dict);
        //
        //
        //                    if ([deal_dict objectForKey:@"id"]==[NSNull null]) {
        //
        //                        NSLog(@"id null");
        //
        //                        UILabel *nodata=[[UILabel alloc]initWithFrame:CGRectMake(10, 150, 300, 20)];
        //                        nodata.backgroundColor=[UIColor clearColor];
        //                        nodata.text=@"No Result found";
        //                        nodata.textAlignment=NSTextAlignmentCenter;
        //                        nodata.font=[UIFont systemFontOfSize:20];
        //                        [mainview addSubview:nodata];
        //
        //                        [imgspin setHidden:YES];
        //                        [spinnern stopAnimating];
        //
        //
        //                    }
        //
        //        else
        //        {
        //
        //
        //            NSLog(@"id null");
        //
        //            UILabel *dealdata=[[UILabel alloc]initWithFrame:CGRectMake(10, 150, 300, 50)];
        //            dealdata.backgroundColor=[UIColor clearColor];
        //            dealdata.text=[NSString stringWithFormat:@"%@",[deal_dict objectForKey:@"deal_description"]];
        //            dealdata.textAlignment=NSTextAlignmentCenter;
        //            dealdata.font=[UIFont systemFontOfSize:20];
        //            dealdata.numberOfLines=2;
        //            [mainview addSubview:dealdata];
        //
        //            [imgspin setHidden:YES];
        //            [spinnern stopAnimating];
        //
        //
        //
        //        }
        
        
        
        if ([dealarr count]==0) {
            
            UILabel *nodata=[[UILabel alloc]initWithFrame:CGRectMake(10, 150, 300, 20)];
            nodata.backgroundColor=[UIColor clearColor];
            nodata.text=@"No Deals Available";
            nodata.textColor=[UIColor whiteColor];
            nodata.textAlignment=NSTextAlignmentCenter;
            nodata.font=[UIFont boldSystemFontOfSize:20];
            [mainview addSubview:nodata];
        }
        else
        {
            testtable=[[UITableView alloc]initWithFrame:CGRectMake(0, headview.frame.origin.y+headview.frame.size.height+2, [[UIScreen mainScreen]bounds].size.width,[[UIScreen mainScreen]bounds].size.height-110) style:UITableViewStylePlain];
            testtable.backgroundColor=[UIColor clearColor];
            [testtable.layer setBorderColor:[[UIColor blackColor] CGColor]];
            testtable.separatorStyle = UITableViewCellSeparatorStyleNone;
            testtable.showsVerticalScrollIndicator = NO;
            testtable.tag = 1;
            testtable.delegate=self;
            testtable.dataSource=self;
            
            [mainview addSubview:testtable];
        }
        
        [imgspin setHidden:YES];
        [spinnern stopAnimating];
        
        
    });
    //});
    
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dealarr count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.backgroundColor =[UIColor clearColor];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    
    UIImageView *cellback=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 107/2)];
    cellback.image=[UIImage imageNamed:@"row_deal"];
    cellback.userInteractionEnabled=YES;
    [cell addSubview:cellback];
    
    

    
    UIImageView *cmpny_img=[[UIImageView alloc]initWithFrame:CGRectMake(5, 7, 40, 40)];
    [cmpny_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.esolz.co.in/lab1/Web/myEchain/deals_image/thumb/%@",[[dealarr objectAtIndex:indexPath.row]objectForKey:@"deal_image"]]] placeholderImage:[UIImage imageNamed:@"logo-1.png"] options:0 == 0?SDWebImageRefreshCached : 0];
    //cmpny_img.image=[UIImage imageNamed:@"logo-1.png"];
    cmpny_img.userInteractionEnabled=YES;
//    cmpny_img.clipsToBounds=YES;
//    cmpny_img.layer.cornerRadius=8;
    [cellback addSubview:cmpny_img];
    
    
    //    mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(55, 0, 200, 50)];
    //    mainScroll.scrollEnabled = YES;
    //    mainScroll.userInteractionEnabled = YES;
    //    mainScroll.backgroundColor=[UIColor clearColor];
    //    mainScroll.delegate=self;
    //    mainScroll.showsHorizontalScrollIndicator = YES;
    //   // mainScroll.contentSize = CGSizeMake(550,0);
    //    [cellback addSubview:mainScroll];
    
    UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(55, 5, 200, 30)];
    name.backgroundColor=[UIColor clearColor];
    name.userInteractionEnabled=YES;
    name.text=[[[dealarr objectAtIndex:indexPath.row]objectForKey:@"deal_title"]capitalizedString];
    name.font=[UIFont systemFontOfSize:15];
    [cellback addSubview:name];
    
    UILabel *sub_title=[[UILabel alloc]initWithFrame:CGRectMake(55, name.frame.origin.y+name.frame.size.height, 200, 15)];
    sub_title.backgroundColor=[UIColor clearColor];
    sub_title.numberOfLines=2;
    sub_title.userInteractionEnabled=YES;
    sub_title.text=[[dealarr objectAtIndex:indexPath.row]objectForKey:@"deal_desc"];
    sub_title.font=[UIFont systemFontOfSize:12];
    [cellback addSubview:sub_title];
    
    /////// RAHUL //////
    
    cellbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0,cellback.frame.size.width, cellback.frame.size.height)];
    cellbutton.backgroundColor=[UIColor clearColor];
    [cellback addSubview:cellbutton];
    cellbutton.tag=indexPath.row;
    [cellbutton addTarget:self action:@selector(expand:) forControlEvents:UIControlEventTouchUpInside];
    cellback.userInteractionEnabled=YES;
    
    BOOL test_presence = [self->expandedCells containsObject:indexPath];
    
    if (test_presence == YES)
    {
        detailstext=[[UITextView alloc]initWithFrame:CGRectMake(0, 53, cellback.frame.size.width, 120)];
        detailstext.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:.2];
        detailstext.delegate=self;
        detailstext.text=[[dealarr objectAtIndex:indexPath.row]objectForKey:@"deal_desc"];
        detailstext.font=[UIFont systemFontOfSize:13];
        detailstext.editable=NO;
        [cell.contentView addSubview:detailstext];
        
        [sub_title setHidden:YES];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor=[UIColor clearColor];
    cell.tag=indexPath.row;
    return cell;
    
    
    
    
}
-(void)expand:(UIButton *)sender
{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    if ([self->expandedCells containsObject:indexPath])
    {
        [self->expandedCells removeObject:indexPath];
    }
    else
    {
        [self->expandedCells addObject:indexPath];
    }
    [testtable beginUpdates];
    [testtable reloadRowsAtIndexPaths:@[indexPath]
                     withRowAnimation:UITableViewRowAnimationFade];
    
    [testtable endUpdates];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==testtable)
    {
        
        CGFloat kExpandedCellHeight = 175;
        CGFloat kNormalCellHeigh = 55;
        
        if ([self->expandedCells containsObject:indexPath])
        {
            return kExpandedCellHeight;
        }
        else
        {
            
            return kNormalCellHeigh;
        }
        
    }
    
    
    return 55;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    //    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 70, 320,520)];
    //    webView.delegate=self;
    //    NSURL *url2 = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[[dealarr objectAtIndex:indexPath.row]objectForKey:@"url"]]];
    //    // NSURL *url2 = [NSURL URLWithString:@"http://google.com"];
    //    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url2];
    //    [webView loadRequest:requestObj];
    //    [self.view addSubview:webView];
    
    //    det_view_bg=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
    //    det_view_bg.backgroundColor=[UIColor blackColor];
    //    det_view_bg.alpha=0.5;
    //    [mainview addSubview:det_view_bg];
    
    
    //
    //    det_view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
    //    det_view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"1-splashbg-1"]];
    //    [mainview addSubview:det_view];
    //
    //
    //    headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
    //    headview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar"]];
    //    [det_view addSubview:headview];
    //
    //    UIImageView *headimg=[[UIImageView alloc]initWithFrame:CGRectMake(120, 25, 183/2, 30)];
    //    headimg.image=[UIImage imageNamed:@"topbar-logo"];
    //    [headview addSubview:headimg];
    //
    //
    //
    //back_detbtn=[[UIButton alloc]initWithFrame:CGRectMake(10,35, 100/2, 33/2)];
    //    [back_detbtn addTarget:self action:@selector(back_det) forControlEvents:UIControlEventTouchUpInside];
    //    [back_detbtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //    [[back_detbtn titleLabel] setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
    //    back_detbtn.userInteractionEnabled=YES;
    //    [mainview addSubview:back_detbtn];
    //
    //
    //
    //
    //    tview_det=[[UIView alloc]initWithFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width-25,40, 90, 40)];
    //    tview_det.backgroundColor=[UIColor clearColor];
    //    tview_det.userInteractionEnabled=YES;
    //    [mainview addSubview:tview_det];
    //
    //    UITapGestureRecognizer *btap= [[UITapGestureRecognizer alloc] initWithTarget:self
    //
    //                                                                          action:@selector(back_det)];
    //
    //    btap.numberOfTapsRequired=1;
    //
    //    [tview_det addGestureRecognizer:btap];
    //
    //
    //    UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(10, 80, [[UIScreen mainScreen]bounds].size.width-40, 30)];
    //    name.backgroundColor=[UIColor clearColor];
    //    name.userInteractionEnabled=YES;
    //    name.textAlignment=NSTextAlignmentCenter;
    //    name.text=[[[dealarr objectAtIndex:indexPath.row]objectForKey:@"deal_title"]capitalizedString];
    //    name.font=[UIFont systemFontOfSize:18];
    //    [det_view addSubview:name];
    //
    //    UIImageView *cmpny_img=[[UIImageView alloc]initWithFrame:CGRectMake(([[UIScreen mainScreen]bounds].size.width-40)/2-40, name.frame.origin.y+name.frame.size.height+20, 100, 100)];
    //    [cmpny_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.esolz.co.in/lab1/Web/myEchain/deals_image/thumb/%@",[[dealarr objectAtIndex:indexPath.row]objectForKey:@"deal_image"]]] placeholderImage:[UIImage imageNamed:@"logo-1.png"] options:0 == 0?SDWebImageRefreshCached : 0];
    //    //cmpny_img.image=[UIImage imageNamed:@"logo-1.png"];
    //    cmpny_img.userInteractionEnabled=YES;
    //    cmpny_img.clipsToBounds=YES;
    //    cmpny_img.layer.cornerRadius=8;
    //    [det_view addSubview:cmpny_img];
    //
    //
    //    UILabel *sub_title=[[UILabel alloc]initWithFrame:CGRectMake(10,  cmpny_img.frame.origin.y+cmpny_img.frame.size.height+20, 280, 500)];
    //    sub_title.backgroundColor=[UIColor clearColor];
    //    sub_title.numberOfLines=20;
    //    sub_title.textAlignment=NSTextAlignmentCenter;
    //    sub_title.userInteractionEnabled=YES;
    //    sub_title.text=[[dealarr objectAtIndex:indexPath.row]objectForKey:@"deal_desc"];
    //    sub_title.font=[UIFont systemFontOfSize:13];
    //    [det_view addSubview:sub_title];
    //
    //    CGSize maximumLabelSize=CGSizeMake(280, 500) ;
    //
    //
    //    expectedLabelSize = [[[dealarr objectAtIndex:indexPath.row]objectForKey:@"deal_desc"] sizeWithFont:sub_title.font
    //
    //                                                       constrainedToSize:maximumLabelSize
    //
    //                                                           lineBreakMode:sub_title.lineBreakMode];
    //
    //    sub_title.frame=CGRectMake(10, cmpny_img.frame.origin.y+cmpny_img.frame.size.height+20, 280, expectedLabelSize.height);
    
}
-(void)back_det
{
    [det_view_bg removeFromSuperview];
    [det_view removeFromSuperview];
    [back_detbtn removeFromSuperview];
    [det_view removeFromSuperview];
    
}
-(void)back
{
    
   // [self.navigationController popViewControllerAnimated:NO];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lock_popup) name:@"lockview" object:nil];
    
    
    
}
-(void)lock_popup
{
    
    NSLog(@"asche");
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"lock_key"]!=[NSNull null])
        
    {
        
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"lock_key"]isEqualToString:@"0"]) {
            
            
            [blackview setHidden:NO];
            [lockview setHidden:NO];
            
            
        }
        else
        {
            
            
            
        }
        
    }// lock key if
    else
    {
        
        
    }//else lock key
    
    
}
-(void)cancellock
{
    [blackview setHidden:YES];
    
    [lockview setHidden:YES];
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    QTSplashViewController *logout=[[QTSplashViewController alloc]init];
    QTAppDelegate *mainDelegate = (QTAppDelegate *)[[UIApplication sharedApplication] delegate];
    [mainDelegate.navigationController pushViewController:logout animated:YES];
}
-(void)savelock
{
    if ([locktxt.text isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"lock_key"]])
    {
        [blackview setHidden:YES];
        
        [lockview setHidden:YES];
        //        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"card_count"]==0) {
        //            QTHomeViewController *home=[[QTHomeViewController alloc]init];
        //            [self.navigationController pushViewController:home animated:NO];
        //        }
        //        else
        //        {
        //
        //            QTCardHomeViewController *home=[[QTCardHomeViewController alloc]init];
        //            [self.navigationController pushViewController:home animated:NO];
        //
        //
        //
        //        }
        
    }//if lock key match
    else
    {
        
        UIAlertView *chosseSource = [[UIAlertView alloc] initWithTitle:@"Sorry!!!"
                                                               message:@"Lock key not matching"
                                                              delegate:self
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:nil, nil];
        [chosseSource show];
        
        
    }
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
