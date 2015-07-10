//
//  QTCarddetailViewController.m
//  MyEchain
//
//  Created by maxcon8 on 23/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "QTCarddetailViewController.h"
#import "QTCardHomeViewController.h"
#import "QTcust_detailsViewController.h"
#import "QTpiechartViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "SVProgressHUD.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "UIImageView+WebCache.h"
#import "qrencode.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "RootViewController.h"
#import "QTMapDetailsViewController.h"
///////////////
//#import "TestUtil.h"
#import "Model.h"
#import "OBGlobal.h"
#import "OBLinear.h"
#import "OBDataMatrix.h"
#import "OBQRCode.h"
#import "JPSThumbnailAnnotation.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

/////////////
@interface QTCarddetailViewController ()
{
    NSOperationQueue *MainQueue;
     Mymodel *obj1;
    
}

@end

@implementation QTCarddetailViewController
#define USER_DEF_LEFT_MARGIN	0.0f
#define USER_DEF_RIGHT_MARGIN	0.0f
#define USER_DEF_TOP_MARGIN		0.0f
#define USER_DEF_BOTTOM_MARGIN	0.0f
#define USER_DEF_BAR_WIDTH			2.0f
#define USER_DEF_BAR_HEIGHT			90.0f
#define USER_DEF_BARCODE_WIDTH		0.0f
#define USER_DEF_BARCODE_HEIGHT		0.0f

#define USER_DEF_ROTATION		(0)
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
    
    
    DetailsArray = [[NSMutableArray alloc]init];
    
    mainview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height )];
    mainview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"detailsbackground"]];
    [self.view addSubview:mainview];
    
    headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
    headview.backgroundColor=[UIColor colorWithRed:(201.0f / 255.0f) green:(201.0f / 255.0f) blue:(201.0f / 255.0f) alpha:1.0f];
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
    
    
    
    NSString *userid=[[NSUserDefaults standardUserDefaults]objectForKey:@"id"];
    NSError *error = nil;
    
    NSData *DetailsData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@sub_cardlist.php?user_id=%@&company_id=%@",APPS_DOMAIN_URL,userid,_card_id]]options:NSDataReadingUncached error:&error];
    
    NSLog(@"count--- :%@",[NSString stringWithFormat:@"%@sub_cardlist.php?user_id=%@&company_id=%@",APPS_DOMAIN_URL,userid,_card_id]);
    
    DetailsArray = [NSJSONSerialization JSONObjectWithData:DetailsData options:kNilOptions error:&error];
    
    [self loadoage];
    
}
- (void) ReceiveNotification:(NSNotification *) notification
{

    [self loadoage];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //--// Rahul
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(ReceiveNotification:)
     
                                                 name:@"DataEdited"
     
                                               object:nil];
    //////
    locationManager = [[CLLocationManager alloc] init];
    if(IS_OS_8_OR_LATER) {
        
        
        NSUInteger code = [CLLocationManager authorizationStatus];
        
        if (code == kCLAuthorizationStatusNotDetermined && ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
            
            // choose one request according to your business.
            
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                
                
                
                [locationManager  requestAlwaysAuthorization];
                
                
                
            } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                
                
                
                [locationManager  requestWhenInUseAuthorization];
                
                
                
            } else {
                
                
                
            }
            
        }
        
    }
    
    
    
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    locationManager.distanceFilter=kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    
}
-(void)loadoage
{
    NSLog(@"QTCarddetailViewController");
    // Do any additional setup after loading the view.
    
    DetailsArray = [[NSMutableArray alloc]init];
    
    merchantIdToCellfireId = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"505",@"298",
                              @"506",@"347",
                              @"650",@"365",
                              @"629",@"671",
                              @"508",@"400",
                              @"551",@"404",
                              @"597",@"406",
                              @"511",@"436",
                              @"444",@"445",
                              @"627",@"459",
                              @"666",@"464",
                              @"515",@"517",
                              @"553",@"518",
                              @"601",@"538",
                              @"648",@"539",
                              @"554",@"564",
                              @"505",@"1049",
                              @"549",@"1631",
                              @"508",@"1014",
                              @"509",@"1633",
                              @"647",@"1634",
                              @"668",@"1635",
                              @"695",@"1636",
                              @"667",@"1639",
                              @"512",@"1640",
                              @"513",@"1641",
                              @"516",@"1642",
                              @"507",@"1205",
                              @"596",@"843",
                              @"504",@"1097",
                              @"514",@"506",
                              @"517",@"642",
                              nil];
    
    card_edit=NO;
    
    mainview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height )];
    mainview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"detailsbackground"]];
    [self.view addSubview:mainview];
    
    headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
    headview.backgroundColor=[UIColor colorWithRed:(201.0f / 255.0f) green:(201.0f / 255.0f) blue:(201.0f / 255.0f) alpha:1.0f];
    [mainview addSubview:headview];
    
    UIImageView *headimg=[[UIImageView alloc]initWithFrame:CGRectMake(120, 25, 183/2, 30)];
    headimg.image=[UIImage imageNamed:@"topbar-logo"];
    [headview addSubview:headimg];
    
    webView = [[UIWebView alloc] init];
    webView.delegate=self;
    webView.hidden=YES;
    
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
    
    UITapGestureRecognizer *btap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    btap.numberOfTapsRequired=1;
    [tview addGestureRecognizer:btap];
    
    
    DetailsScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, 70.0f, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
    [DetailsScrollView setBackgroundColor:[UIColor clearColor]];
    [DetailsScrollView setScrollEnabled:YES];
    [DetailsScrollView setDelegate:self];
    [DetailsScrollView setPagingEnabled:YES];
    [mainview addSubview:DetailsScrollView];
    
    spin_img = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spin_img.hidesWhenStopped = YES;
    spin_img.backgroundColor=[UIColor clearColor];
    spin_img.center =CGPointMake(DetailsScrollView.frame.size.width/2, DetailsScrollView.frame.size.height/2);
    [DetailsScrollView addSubview: spin_img];
    
        NSString *userid=[[NSUserDefaults standardUserDefaults]objectForKey:@"id"];
    
    MainQueue = [[NSOperationQueue alloc]init];
    [MainQueue addOperationWithBlock:^{
        
        
        [spin_img startAnimating];
        
        
        NSError *error = nil;
        
        NSData *DetailsData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@sub_cardlist.php?user_id=%@&company_id=%@",APPS_DOMAIN_URL,userid,_card_id]]options:NSDataReadingUncached error:&error];
        
        NSLog(@"count--- :%@",[NSString stringWithFormat:@"%@sub_cardlist.php?user_id=%@&company_id=%@",APPS_DOMAIN_URL,userid,_card_id]);
        
        DetailsArray = [NSJSONSerialization JSONObjectWithData:DetailsData options:kNilOptions error:&error];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
       
        
        NSLog(@"detailsarraycount----- :%@",DetailsArray);
        
        int i;
        
        for (i = 0; i< DetailsArray.count; i++)
        {
            marchnt_id=[merchantIdToCellfireId objectForKey:_card_id];
            
            UILabel *cardownername=[[UILabel alloc]initWithFrame:CGRectMake(i*self.view.frame.size.width, 5, self.view.frame.size.width, 30)];
            cardownername.text=[[DetailsArray objectAtIndex:i]objectForKey:@"cardownername"];
            cardownername.textColor=[UIColor colorWithRed:(79.0f / 255.0f) green:(79.0f / 255.0f) blue:(79.0f / 255.0f) alpha:1.0f];
            cardownername.font=[UIFont boldSystemFontOfSize:20];
            cardownername.textAlignment=NSTextAlignmentCenter;
            [DetailsScrollView addSubview:cardownername];
            
            NSLog(@"marchents id iss====%@",marchnt_id);
            if (marchnt_id!=nil) {
                
                cellfire_img=[[UIImageView alloc]initWithFrame:CGRectMake((i * self.view.frame.size.width)+255, 50, 40, 40)];
                
                cellfire_img.image=[UIImage imageNamed:@"cellfire_img.png"];
                [DetailsScrollView addSubview:cellfire_img];
                
                
                UIView *cellfire_vw=[[UIView alloc]initWithFrame:CGRectMake((i * self.view.frame.size.width)+220,  0, 100, 100)];
                cellfire_vw.backgroundColor=[UIColor clearColor];
                cellfire_vw.tag = i;
                [DetailsScrollView addSubview:cellfire_vw];
                
                cellfire_tap=[[UITapGestureRecognizer alloc]init];
                [cellfire_tap addTarget:self action:@selector(cellfirefn:)];
                cellfire_vw.userInteractionEnabled=YES;
                [cellfire_vw addGestureRecognizer:cellfire_tap];
                
            }
            

            
            cardimg=[[UIImageView alloc]initWithFrame:CGRectMake((i * self.view.frame.size.width)+120, 50, 80, 80)];
            [cardimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[DetailsArray objectAtIndex:i] objectForKey:@"company_image"]]] placeholderImage:[UIImage imageNamed:@"logo-1.png"] options:0 == 0?SDWebImageRefreshCached : 0];
            //cardimg.contentMode = UIViewContentModeScaleAspectFit;
            [DetailsScrollView addSubview:cardimg];
            
            
            qrimg=[[UIImageView alloc]initWithFrame:CGRectMake((i * self.view.frame.size.width)+[[UIScreen mainScreen]bounds].size.width/2-70, cardimg.frame.origin.y+cardimg.frame.size.height+30, 140, 140)];
            qrimg.backgroundColor=[UIColor whiteColor];
            //   [qrimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",ret_str]] placeholderImage:[UIImage imageNamed:@"logo-1.png"] options:0 == 0?SDWebImageRefreshCached : 0];
            
            //qrimg.image=barcodeimg;
            [DetailsScrollView addSubview:qrimg];
            
            
            
            
            branded=NO;
            
            // editview.hidden=NO;
            
            //    NSString *sectionTitle = [card_dict objectAtIndex:indexPath.section];
            //    sectionContactsArray = [add_contacts_dict objectForKey:sectionTitle];
            
            QTcardarr *cardobj=[QTcardarr getInstance];
            
            
            
            
            for (int j=0; j<[cardobj.card_arr count]; j++) {
                
                if ([_card_id isEqualToString:[[cardobj.card_arr objectAtIndex:j]objectForKey:@"id"]])
                {
                    
                    branded=YES;
                    break;
                }
            }
            
            if (!branded) {
                
                
                
                UIButton *dealbt=[[UIButton alloc]initWithFrame:CGRectMake(250,30, 126/2, 51/2)];
                [dealbt addTarget:self action:@selector(dealfn:) forControlEvents:UIControlEventTouchUpInside];
                [dealbt setBackgroundImage:[UIImage imageNamed:@"deals"] forState:UIControlStateNormal];
                [[dealbt titleLabel] setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
                dealbt.tag = i;
                dealbt.userInteractionEnabled=YES;
                [headview addSubview:dealbt];
                
                
                UIImageView *info_icon=[[UIImageView alloc]initWithFrame:CGRectMake((i * self.view.frame.size.width)+32, 45, 35,35)];
                info_icon.image=[UIImage imageNamed:@"Tag_deal"];
                info_icon.userInteractionEnabled=YES;
                [DetailsScrollView addSubview:info_icon];
                
                UIView *infoview_tap=[[UIView alloc]initWithFrame:CGRectMake((i * self.view.frame.size.width)+20, 0, 70, 80)];
                infoview_tap.backgroundColor=[UIColor clearColor];
                infoview_tap.userInteractionEnabled=YES;
                [DetailsScrollView addSubview:infoview_tap];
                
                UITapGestureRecognizer *infot=[[UITapGestureRecognizer alloc]init];
                [infot addTarget:self action:@selector(cust_info:)];
                [infoview_tap addGestureRecognizer:infot];
                
                if (![[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_url"]isEqualToString:@""]) {
                    
                    if ([[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]isEqualToString:@"Code 128"]||[[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]isEqualToString:@"CODE_128"]||[[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]isEqualToString:@"Code 93"]||[[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]isEqualToString:@"CODE_93"])
                    {
                        
                        
                        NSLog(@"generate barcode:%@",[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_url"]);
                        
                        
                        //            NKDUPCEBarcode *code=[[NKDUPCEBarcode alloc]initWithContent:[card_dict objectForKey:@"barcode_url"]];
                        //
                        //            barcodeimg=[UIImage imageFromBarcode:code];edit code
                        //
                        //           qrimg.backgroundColor=[UIColor whiteColor];
                        //           qrimg.frame=CGRectMake(0, cardimg.frame.origin.y+cardimg.frame.size.height+20, 320,80);
                        //            qrimg.contentMode = UIViewContentModeScaleAspectFit;
                        //            qrimg.clipsToBounds = YES;
                        //            qrimg.image=barcodeimg;
                        
          
                        
                        NKDCode128Barcode *code1 = [[NKDCode128Barcode alloc]initWithContent:[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_url"] printsCaption:YES];
                        barcodeimg = [UIImage imageFromBarcode:code1];
                        qrimg.backgroundColor=[UIColor whiteColor];
                        // qrimg.frame=CGRectMake(70, cardimg.frame.origin.y+cardimg.frame.size.height+20, [[UIScreen mainScreen]bounds].size.width-140,barcodeimg.size.height+20);
                        qrimg.frame=CGRectMake((i * self.view.frame.size.width)+[[UIScreen mainScreen]bounds].size.width/2-barcodeimg.size.width/2, cardimg.frame.origin.y+cardimg.frame.size.height+20, barcodeimg.size.width,barcodeimg.size.height+20);
                        qrimg.contentMode = UIViewContentModeScaleAspectFit;
                        qrimg.clipsToBounds = YES;
                        qrimg.image=barcodeimg;
                        
  
                        
                        
                    }
                    else if ([[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]isEqualToString:@"EAN13"]||[[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]isEqualToString:@"EAN_13"])
                    {
                        
   
                        
                        NKDEAN13Barcode *code = [[NKDEAN13Barcode alloc]initWithContent:[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_url"] printsCaption:YES];
                        barcodeimg = [UIImage imageFromBarcode:code];
                        qrimg.backgroundColor=[UIColor whiteColor];
                        qrimg.frame=CGRectMake((i * self.view.frame.size.width)+[[UIScreen mainScreen]bounds].size.width/2-barcodeimg.size.width/2, cardimg.frame.origin.y+cardimg.frame.size.height+20, barcodeimg.size.width,barcodeimg.size.height+20);
                        qrimg.contentMode = UIViewContentModeScaleAspectFit;
                        qrimg.clipsToBounds = YES;
                        qrimg.image=barcodeimg;
                        

                        
                    }
                    else if ([[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]isEqualToString:@"UPC_E"]||[[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]isEqualToString:@"UPC_A"])
                    {
                        
                        NSLog(@"asche UPC_A");
                        

                        
                        NKDEAN13Barcode *code = [[NKDEAN13Barcode alloc]initWithContent:[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_url"] printsCaption:YES];
                        barcodeimg = [UIImage imageFromBarcode:code];
                        qrimg.backgroundColor=[UIColor whiteColor];
                        qrimg.frame=CGRectMake((i * self.view.frame.size.width)+[[UIScreen mainScreen]bounds].size.width/2-barcodeimg.size.width/2, cardimg.frame.origin.y+cardimg.frame.size.height+20, barcodeimg.size.width,barcodeimg.size.height+20);
                        qrimg.contentMode = UIViewContentModeScaleAspectFit;
                        qrimg.clipsToBounds = YES;
                        qrimg.image=barcodeimg;
                        
   
                        
                    }
                    else if ([[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]isEqualToString:@"Code 39"]||[[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]isEqualToString:@"CODE_39"])
                    {
                        
                        
                        NSLog(@"height  :%@",[card_dict objectForKey:@"barcode_url"]);
                        

                        
                        
                        NKDCode39Barcode *code = [[NKDCode39Barcode alloc]initWithContent:[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_url"] printsCaption:YES];
                        barcodeimg = [UIImage imageFromBarcode:code];
                        qrimg.backgroundColor=[UIColor whiteColor];
                        qrimg.frame=CGRectMake((i * self.view.frame.size.width)+[[UIScreen mainScreen]bounds].size.width/2-barcodeimg.size.width/2, cardimg.frame.origin.y+cardimg.frame.size.height+20, barcodeimg.size.width,barcodeimg.size.height+20);
                        qrimg.contentMode = UIViewContentModeScaleAspectFit;
                        qrimg.clipsToBounds = YES;
                        qrimg.image=barcodeimg;
                        

                        
                        NSLog(@"barcodeimage.....:%f",cardimg.frame.origin.y+cardimg.frame.size.height);
                        NSLog(@"barcodeimage.....:%f",barcodeimg.size.height);
                    }
                    
                    else if ([[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]isEqualToString:@"EAN8"]||[[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]isEqualToString:@"EAN_8"])
                    {
                        

                        
                        NKDEAN8Barcode *code = [[NKDEAN8Barcode alloc]initWithContent:[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_url"] printsCaption:YES];
                        barcodeimg = [UIImage imageFromBarcode:code];
                        qrimg.backgroundColor=[UIColor whiteColor];
                        qrimg.frame=CGRectMake((i * self.view.frame.size.width)+[[UIScreen mainScreen]bounds].size.width/2-barcodeimg.size.width/2, cardimg.frame.origin.y+cardimg.frame.size.height+20, barcodeimg.size.width,barcodeimg.size.height+20);
                        
                        //qrimg.frame=CGRectMake(0, cardimg.frame.origin.y+cardimg.frame.size.height+20, [[UIScreen mainScreen]bounds].size.width,barcodeimg.size.height+20);
                        qrimg.contentMode = UIViewContentModeScaleAspectFit;
                        qrimg.clipsToBounds = YES;
                        qrimg.image=barcodeimg;
                        

                        
                    }
                    
                    else if ([[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]isEqualToString:@"UPCEAN"])
                    {
                        
  
                        
                        
                        NKDAbstractUPCEANBarcode *code = [[NKDAbstractUPCEANBarcode alloc]initWithContent:[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_url"] printsCaption:YES];
                        barcodeimg = [UIImage imageFromBarcode:code];
                        qrimg.backgroundColor=[UIColor whiteColor];
                        qrimg.frame=CGRectMake((i * self.view.frame.size.width)+[[UIScreen mainScreen]bounds].size.width/2-barcodeimg.size.width/2, cardimg.frame.origin.y+cardimg.frame.size.height+20, barcodeimg.size.width,barcodeimg.size.height+20);
                        //qrimg.frame=CGRectMake(0, cardimg.frame.origin.y+cardimg.frame.size.height+10, [[UIScreen mainScreen]bounds].size.width,barcodeimg.size.height+30);
                        // qrimg.contentMode=UIViewContentModeScaleAspectFill;
                        qrimg.contentMode = UIViewContentModeScaleAspectFit;
                        qrimg.clipsToBounds = YES;
                        qrimg.image=barcodeimg;
                        

                        
                    }
                    else if ([[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]isEqualToString:@"BARCODE"])
                    {
                        

                        
                        NKDCodabarBarcode *code = [[NKDCodabarBarcode alloc]initWithContent:[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_url"] printsCaption:YES];
                        barcodeimg = [UIImage imageFromBarcode:code];
                        qrimg.backgroundColor=[UIColor whiteColor];
                        qrimg.frame=CGRectMake((i * self.view.frame.size.width)+[[UIScreen mainScreen]bounds].size.width/2-barcodeimg.size.width/2, cardimg.frame.origin.y+cardimg.frame.size.height+10, barcodeimg.size.width,barcodeimg.size.height+20);
                        //qrimg.frame=CGRectMake(0, cardimg.frame.origin.y+cardimg.frame.size.height+10, [[UIScreen mainScreen]bounds].size.width,barcodeimg.size.height+30);
                        // qrimg.contentMode=UIViewContentModeScaleAspectFill;
                        qrimg.contentMode = UIViewContentModeScaleAspectFit;
                        qrimg.clipsToBounds = YES;
                        qrimg.image=barcodeimg;
                        

                        
                    }
                    
                    else if ([[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]isEqualToString:@"PDF417"])
                    {
                        barcodeimg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.myechain.com/wp-content/themes/myechain-twentyeleven/includes/generate.php?type=pdf417&number=%@",[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_url"]]]]];
                        qrimg.backgroundColor=[UIColor clearColor];
                        qrimg.frame=CGRectMake((i * self.view.frame.size.width)+[[UIScreen mainScreen]bounds].size.width/2-barcodeimg.size.width/2, cardimg.frame.origin.y+cardimg.frame.size.height+10, barcodeimg.size.width,barcodeimg.size.height+20);
                        //qrimg.frame=CGRectMake(0, cardimg.frame.origin.y+cardimg.frame.size.height+10, [[UIScreen mainScreen]bounds].size.width,barcodeimg.size.height+30);
                        // qrimg.contentMode=UIViewContentModeScaleAspectFill;
                        qrimg.contentMode = UIViewContentModeScaleAspectFit;
                        qrimg.clipsToBounds = YES;
                        qrimg.image=barcodeimg;
                        
          
                        
                    }
                    
                    else{
                        
                        
                        
                        qrimg.clipsToBounds=YES;
                        qrimg.contentMode=UIViewContentModeScaleAspectFit;
                        qrimg.frame=CGRectMake((i * self.view.frame.size.width)+110, cardimg.frame.origin.y+cardimg.frame.size.height+20, 100,100);
                        
                        
                        qrimg.image = [UIImage QRCodeGenerator:[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_url"]
                                                andLightColour:[UIColor whiteColor]
                                                 andDarkColour:[UIColor blackColor]
                                                  andQuietZone:1
                                                       andSize:100];
                        
                        
                        
                    }
                }
                else
                    
                {
                    /////////////////
      
                    
                    qrimg=[[UIImageView alloc]initWithFrame:CGRectMake((i * self.view.frame.size.width)+[[UIScreen mainScreen]bounds].size.width/2-70, cardimg.frame.origin.y+cardimg.frame.size.height+30, 140, 140)];
                    qrimg.backgroundColor=[UIColor clearColor];
                    [qrimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.esolz.co.in/lab1/Web/myEchain/qrcode_image/%@",[[DetailsArray objectAtIndex:i] objectForKey:@"code_data_image"]]] placeholderImage:[UIImage imageNamed:@"logo-1.png"] options:0 == 0?SDWebImageRefreshCached : 0];
                    
                    //qrimg.image=barcodeimg;
                    [DetailsScrollView addSubview:qrimg];
                    
                    
                }
                
            }
            
          else if (branded) {
                
                NSLog(@"code type isss====%@",[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]);
                // if ([card_dict objectForKey:@"barcode_url"]!=[NSNull null]) {
                if (![[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_url"]isEqualToString:@""]) {
                    
                    if ([[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]isEqualToString:@"Code 128"]||[[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]isEqualToString:@"CODE_128"]||[[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]isEqualToString:@"Code 93"]||[[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]isEqualToString:@"CODE_93"])
                    {
                        
                        
                        NSLog(@"generate barcode:%@",[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_url"]);
                        
                        
                        //            NKDUPCEBarcode *code=[[NKDUPCEBarcode alloc]initWithContent:[card_dict objectForKey:@"barcode_url"]];
                        //
                        //            barcodeimg=[UIImage imageFromBarcode:code];edit code
                        //
                        //           qrimg.backgroundColor=[UIColor whiteColor];
                        //           qrimg.frame=CGRectMake(0, cardimg.frame.origin.y+cardimg.frame.size.height+20, 320,80);
                        //            qrimg.contentMode = UIViewContentModeScaleAspectFit;
                        //            qrimg.clipsToBounds = YES;
                        //            qrimg.image=barcodeimg;
                        
               
                        
                        NKDCode128Barcode *code1 = [[NKDCode128Barcode alloc]initWithContent:[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_url"] printsCaption:YES];
                        barcodeimg = [UIImage imageFromBarcode:code1];
                        qrimg.backgroundColor=[UIColor whiteColor];
                        // qrimg.frame=CGRectMake(70, cardimg.frame.origin.y+cardimg.frame.size.height+20, [[UIScreen mainScreen]bounds].size.width-140,barcodeimg.size.height+20);
                        qrimg.frame=CGRectMake((i * self.view.frame.size.width)+[[UIScreen mainScreen]bounds].size.width/2-barcodeimg.size.width/2, cardimg.frame.origin.y+cardimg.frame.size.height+20, barcodeimg.size.width,barcodeimg.size.height+20);
                        qrimg.contentMode = UIViewContentModeScaleAspectFit;
                        qrimg.clipsToBounds = YES;
                        qrimg.image=barcodeimg;
                        
  
                        
                        
                    }
                    else if ([[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]isEqualToString:@"EAN13"]||[[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]isEqualToString:@"EAN_13"])
                    {
                        
   
                        
                        NKDEAN13Barcode *code = [[NKDEAN13Barcode alloc]initWithContent:[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_url"] printsCaption:YES];
                        barcodeimg = [UIImage imageFromBarcode:code];
                        qrimg.backgroundColor=[UIColor whiteColor];
                        qrimg.frame=CGRectMake((i * self.view.frame.size.width)+[[UIScreen mainScreen]bounds].size.width/2-barcodeimg.size.width/2, cardimg.frame.origin.y+cardimg.frame.size.height+20, barcodeimg.size.width,barcodeimg.size.height+20);
                        qrimg.contentMode = UIViewContentModeScaleAspectFit;
                        qrimg.clipsToBounds = YES;
                        qrimg.image=barcodeimg;
                        

                        
                    }
                    else if ([[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]isEqualToString:@"UPC_E"]||[[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]isEqualToString:@"UPC_A"])
                    {
                        
                        NSLog(@"asche UPC_A");
  //@""
                        
                        NKDEAN13Barcode *code = [[NKDEAN13Barcode alloc]initWithContent:[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_url"] printsCaption:YES];
                        barcodeimg = [UIImage imageFromBarcode:code];
                       
                        qrimg.backgroundColor=[UIColor whiteColor];
                        qrimg.frame=CGRectMake((i * self.view.frame.size.width)+[[UIScreen mainScreen]bounds].size.width/2-barcodeimg.size.width/2, cardimg.frame.origin.y+cardimg.frame.size.height+20, barcodeimg.size.width,barcodeimg.size.height+20);
                        qrimg.contentMode = UIViewContentModeScaleAspectFit;
                        qrimg.clipsToBounds = YES;
                        qrimg.image=barcodeimg;
                        

                        
                     
                        
                    }
                    else if ([[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]isEqualToString:@"Code 39"]||[[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]isEqualToString:@"CODE_39"])
                    {
                        
                        
                        NSLog(@"height  :%@",[card_dict objectForKey:@"barcode_url"]);

                        
                        

                         barcodeimg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.myechain.com/wp-content/themes/myechain-twentyeleven/includes/generate.php?type=39&number=%@",[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_url"]]]]];
                        qrimg.backgroundColor=[UIColor whiteColor];
                        qrimg.frame=CGRectMake((i * self.view.frame.size.width)+[[UIScreen mainScreen]bounds].size.width/2-barcodeimg.size.width/2, cardimg.frame.origin.y+cardimg.frame.size.height+20, barcodeimg.size.width,barcodeimg.size.height+20);
                        qrimg.contentMode = UIViewContentModeScaleAspectFit;
                        qrimg.clipsToBounds = YES;
                        qrimg.image=barcodeimg;

                        UIView *view = [[UIView alloc]initWithFrame:CGRectMake((i * self.view.frame.size.width), 202, self.view.frame.size.width, 45)];
                        [view setBackgroundColor:[UIColor whiteColor]];
                        [DetailsScrollView addSubview:view];
                        
                        NSLog(@"barcodeimage.....:%f",cardimg.frame.origin.y+cardimg.frame.size.height);
                        NSLog(@"barcodeimage.....:%f",barcodeimg.size.height);
                    }
                    
                    else if ([[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]isEqualToString:@"EAN8"]||[[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]isEqualToString:@"EAN_8"])
                    {

                        
                        NKDEAN8Barcode *code = [[NKDEAN8Barcode alloc]initWithContent:[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_url"] printsCaption:YES];
                        barcodeimg = [UIImage imageFromBarcode:code];
                        qrimg.backgroundColor=[UIColor whiteColor];
                        qrimg.frame=CGRectMake((i * self.view.frame.size.width)+[[UIScreen mainScreen]bounds].size.width/2-barcodeimg.size.width/2, cardimg.frame.origin.y+cardimg.frame.size.height+20, barcodeimg.size.width,barcodeimg.size.height+20);
                        
                        //qrimg.frame=CGRectMake(0, cardimg.frame.origin.y+cardimg.frame.size.height+20, [[UIScreen mainScreen]bounds].size.width,barcodeimg.size.height+20);
                        qrimg.contentMode = UIViewContentModeScaleAspectFit;
                        qrimg.clipsToBounds = YES;
                        qrimg.image=barcodeimg;

                        
                    }
                    
                    else if ([[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]isEqualToString:@"UPCEAN"])
                    {
                        

                        
                        
                        NKDAbstractUPCEANBarcode *code = [[NKDAbstractUPCEANBarcode alloc]initWithContent:[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_url"] printsCaption:YES];
                        barcodeimg = [UIImage imageFromBarcode:code];
                        qrimg.backgroundColor=[UIColor whiteColor];
                        qrimg.frame=CGRectMake((i * self.view.frame.size.width)+[[UIScreen mainScreen]bounds].size.width/2-barcodeimg.size.width/2, cardimg.frame.origin.y+cardimg.frame.size.height+20, barcodeimg.size.width,barcodeimg.size.height+20);
                        //qrimg.frame=CGRectMake(0, cardimg.frame.origin.y+cardimg.frame.size.height+10, [[UIScreen mainScreen]bounds].size.width,barcodeimg.size.height+30);
                        // qrimg.contentMode=UIViewContentModeScaleAspectFill;
                        qrimg.contentMode = UIViewContentModeScaleAspectFit;
                        qrimg.clipsToBounds = YES;
                        qrimg.image=barcodeimg;
                        
    
                        
                    }
                    else if ([[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]isEqualToString:@"BARCODE"])
                    {
                        

                        
                        NKDCodabarBarcode *code = [[NKDCodabarBarcode alloc]initWithContent:[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_url"] printsCaption:YES];
                        barcodeimg = [UIImage imageFromBarcode:code];
                        qrimg.backgroundColor=[UIColor whiteColor];
                        qrimg.frame=CGRectMake((i * self.view.frame.size.width)+[[UIScreen mainScreen]bounds].size.width/2-barcodeimg.size.width/2, cardimg.frame.origin.y+cardimg.frame.size.height+10, barcodeimg.size.width,barcodeimg.size.height+20);
                        //qrimg.frame=CGRectMake(0, cardimg.frame.origin.y+cardimg.frame.size.height+10, [[UIScreen mainScreen]bounds].size.width,barcodeimg.size.height+30);
                        // qrimg.contentMode=UIViewContentModeScaleAspectFill;
                        qrimg.contentMode = UIViewContentModeScaleAspectFit;
                        qrimg.clipsToBounds = YES;
                        qrimg.image=barcodeimg;
                        

                        
                    }
                    
                    else if ([[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_type"]isEqualToString:@"PDF417"])
                    {
                        barcodeimg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.myechain.com/wp-content/themes/myechain-twentyeleven/includes/generate.php?type=pdf417&number=%@",[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_url"]]]]];
                        qrimg.backgroundColor=[UIColor clearColor];
                        qrimg.frame=CGRectMake((i * self.view.frame.size.width)+[[UIScreen mainScreen]bounds].size.width/2-barcodeimg.size.width/2, cardimg.frame.origin.y+cardimg.frame.size.height+10, barcodeimg.size.width,barcodeimg.size.height+20);
                        //qrimg.frame=CGRectMake(0, cardimg.frame.origin.y+cardimg.frame.size.height+10, [[UIScreen mainScreen]bounds].size.width,barcodeimg.size.height+30);
                        // qrimg.contentMode=UIViewContentModeScaleAspectFill;
                        qrimg.contentMode = UIViewContentModeScaleAspectFit;
                        qrimg.clipsToBounds = YES;
                        qrimg.image=barcodeimg;

                        
                    }
                    
                    else{
                        
                        
                        
                        qrimg.clipsToBounds=YES;
                        qrimg.contentMode=UIViewContentModeScaleAspectFit;
                        qrimg.frame=CGRectMake((i * self.view.frame.size.width)+110, cardimg.frame.origin.y+cardimg.frame.size.height+20, 100,100);
                        
                        
                        qrimg.image = [UIImage QRCodeGenerator:[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_url"]
                                                andLightColour:[UIColor whiteColor]
                                                 andDarkColour:[UIColor blackColor]
                                                  andQuietZone:1
                                                       andSize:100];
                        
                        
                        
                    }
                }
            }
            
            else
                
            {
                

                /////////////////
                qrimg=[[UIImageView alloc]initWithFrame:CGRectMake((i * self.view.frame.size.width)+[[UIScreen mainScreen]bounds].size.width/2-70, cardimg.frame.origin.y+cardimg.frame.size.height+30, 140, 140)];
                qrimg.backgroundColor=[UIColor clearColor];
                [qrimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.esolz.co.in/lab1/Web/myEchain/qrcode_image/%@",[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_url"]]] placeholderImage:[UIImage imageNamed:@"logo-1.png"] options:0 == 0?SDWebImageRefreshCached : 0];
                
                //qrimg.image=barcodeimg;
                [DetailsScrollView addSubview:qrimg];
                
                
            }
            
            qr_code=[[UILabel alloc]initWithFrame:CGRectMake((i * self.view.frame.size.width)+10, qrimg.frame.origin.y+qrimg.frame.size.height+10, [[UIScreen mainScreen]bounds].size.width-20, 30)];
       if ([[DetailsArray objectAtIndex:i] objectForKey:@"barcode_url"]!=[NSNull null]) {
                qr_code.text=[[DetailsArray objectAtIndex:i] objectForKey:@"barcode_url"];
            }
            qr_code.textColor=[UIColor colorWithRed:(189.0f / 255.0f) green:(101.0f / 255.0f) blue:(98.0f / 255.0f) alpha:1.0f];
            qr_code.numberOfLines=2;
            qr_code.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:20];
            qr_code.textAlignment=NSTextAlignmentCenter;
            [DetailsScrollView addSubview:qr_code];
            
            //
            
            securitycode=[[UILabel alloc]initWithFrame:CGRectMake((i * self.view.frame.size.width)+10, qrimg.frame.origin.y+qrimg.frame.size.height+40, [[UIScreen mainScreen]bounds].size.width-20, 20)];
            if ([[DetailsArray objectAtIndex:i] objectForKey:@"card_number"]!=[NSNull null]) {
                securitycode.text=[[DetailsArray objectAtIndex:i] objectForKey:@"card_number"];
            }
            securitycode.textColor=[UIColor lightGrayColor];
            securitycode.numberOfLines=2;
            securitycode.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:20];
            securitycode.textAlignment=NSTextAlignmentCenter;
            [DetailsScrollView addSubview:securitycode];
            
            branded=NO;
            
            // editview.hidden=NO;
            
            //    NSString *sectionTitle = [card_dict objectAtIndex:indexPath.section];
            //    sectionContactsArray = [add_contacts_dict objectForKey:sectionTitle];
            
            cardobj=[QTcardarr getInstance];
            
            
            
            for (int j=0; j<[cardobj.card_arr count]; j++) {
                
                if ([_card_id isEqualToString:[[cardobj.card_arr objectAtIndex:j]objectForKey:@"id"]])
                {
                    
                    branded=YES;
                    break;
                }
            }
            if (branded) {
                
                
                
                
                UIView *gray_editvw=[[UIView alloc]initWithFrame:CGRectMake((i * self.view.frame.size.width)+90, qrimg.frame.origin.y+qrimg.frame.size.height+60, 120, 35)];
                gray_editvw.tag = i;
                gray_editvw.backgroundColor=[UIColor clearColor];
                [DetailsScrollView addSubview:gray_editvw];
                
                UIImageView *editimg=[[UIImageView alloc]initWithFrame:CGRectMake(7, 7, 16,16)];
                editimg.image=[UIImage imageNamed:@"editdetails"];
                [gray_editvw addSubview:editimg];
                
                UITapGestureRecognizer *click1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(card_edit:)];
                [gray_editvw setUserInteractionEnabled:YES];
                [gray_editvw addGestureRecognizer:click1];
                
                
                UILabel *editlb=[[UILabel alloc]initWithFrame:CGRectMake(35, 5, 320, 20)];
                editlb.text=@"Edit code";
                editlb.textColor=[UIColor colorWithRed:(79.0f / 255.0f) green:(79.0f / 255.0f) blue:(79.0f / 255.0f) alpha:1.0f];
                editlb.font=[UIFont boldSystemFontOfSize:20];
                editlb.textAlignment=NSTextAlignmentLeft;
                [gray_editvw addSubview:editlb];
                
                
                
                UILabel *cardname=[[UILabel alloc]initWithFrame:CGRectMake((i * self.view.frame.size.width)+0, gray_editvw.frame.origin.y+gray_editvw.frame.size.height+10, 320, 20)];
                
                // UILabel *cardname=[[UILabel alloc]initWithFrame:CGRectMake(0, QRno.frame.origin.y+QRno.frame.size.height+10, 320, 20)];
                // cardname.text=[NSString stringWithFormat:@"%@",[[card_dict objectForKey:@"name"]capitalizedString]];
                cardname.textColor=[UIColor whiteColor];
                cardname.font=[UIFont systemFontOfSize:17];
                cardname.textAlignment=NSTextAlignmentCenter;
                [DetailsScrollView addSubview:cardname];
                
                
                
                
                
                
                UILabel *QRno=[[UILabel alloc]initWithFrame:CGRectMake((i * self.view.frame.size.width)+15, gray_editvw.frame.origin.y+gray_editvw.frame.size.height+7, [[UIScreen mainScreen]bounds].size.width, 25)];
                
                
                
                
                if ([[DetailsArray objectAtIndex:i] objectForKey:@"phone"]!=[NSNull null] || [NSString stringWithFormat:@"%@",[[DetailsArray objectAtIndex:i] objectForKey:@"phone"]].length != 0) {
                    
                    if (![[[DetailsArray objectAtIndex:i] objectForKey:@"phone"]isEqualToString:@"0"] && ![[[DetailsArray objectAtIndex:i] objectForKey:@"phone"]isEqualToString:@""] )
                    {
                        
                        
                        UIImageView *phn_img=[[UIImageView alloc]initWithFrame:CGRectMake((i * self.view.frame.size.width)+85,  gray_editvw.frame.origin.y+gray_editvw.frame.size.height+5, 30, 30)];
                        phn_img.image=[UIImage imageNamed:@"phoneicondetails"];
                        [DetailsScrollView addSubview:phn_img];
                        
                        QRno.text=[[DetailsArray objectAtIndex:i] objectForKey:@"phone"];
                        
                        UITapGestureRecognizer *phn_tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callno)];
                        
                        phn_tap.numberOfTapsRequired=1;
                        
                        [QRno addGestureRecognizer:phn_tap];
                        
                    }
                    
                    
                    
                    
                }
                QRno.textColor=[UIColor colorWithRed:(189.0f / 255.0f) green:(101.0f / 255.0f) blue:(98.0f / 255.0f) alpha:1.0f];
                QRno.font=[UIFont boldSystemFontOfSize:18];
                QRno.userInteractionEnabled=YES;
                QRno.textAlignment=NSTextAlignmentCenter;
                [DetailsScrollView addSubview:QRno];
                
                
                
                UILabel *QRno1=[[UILabel alloc]initWithFrame:CGRectMake((i * self.view.frame.size.width)+0, cardname.frame.origin.y+cardname.frame.size.height+10, 320, 20)];
                if ([[DetailsArray objectAtIndex:i] objectForKey:@"website"]!=[NSNull null]) {
                    QRno1.text=[[DetailsArray objectAtIndex:i] objectForKey:@"website"];
                }
                
                QRno1.textColor=[UIColor whiteColor];
                QRno1.font=[UIFont boldSystemFontOfSize:16];
                QRno1.textAlignment=NSTextAlignmentCenter;
                // [mainview addSubview:QRno1];
                
                
                
            }
            else
            {
                UILabel *cardname=[[UILabel alloc]initWithFrame:CGRectMake((i * self.view.frame.size.width)+0, 380, 320, 20)];
                // cardname.text=[NSString stringWithFormat:@"%@",[[card_dict objectForKey:@"name"]capitalizedString]];
                cardname.textColor=[UIColor whiteColor];
                cardname.font=[UIFont systemFontOfSize:17];
                cardname.textAlignment=NSTextAlignmentCenter;
                [DetailsScrollView addSubview:cardname];
                
                
                
                
                NSLog(@"phone... :%lu",(unsigned long)[NSString stringWithFormat:@"%@",[[DetailsArray objectAtIndex:i] objectForKey:@"phone"]].length);
                
                UILabel *QRno=[[UILabel alloc]initWithFrame:CGRectMake((i * self.view.frame.size.width)+15, 357, 320, 20)];
                if ([NSString stringWithFormat:@"%@",[[DetailsArray objectAtIndex:i] objectForKey:@"phone"]].length != 0) {
                    
                    NSLog(@"branded");
                        
                        UIImageView *phn_img=[[UIImageView alloc]initWithFrame:CGRectMake((i * self.view.frame.size.width)+80, 355, 30, 30)];
                        phn_img.image=[UIImage imageNamed:@"phoneicondetails"];
                        [DetailsScrollView addSubview:phn_img];
                        
                        
                        QRno.text=[[DetailsArray objectAtIndex:i] objectForKey:@"phone"];
                        
                        
                        
                        UITapGestureRecognizer *phn_tap= [[UITapGestureRecognizer alloc] initWithTarget:self
                                                          
                                                                                                 action:@selector(callno)];
                        
                        phn_tap.numberOfTapsRequired=1;
                        
                        [QRno addGestureRecognizer:phn_tap];
                        
                        
                        
                    }
                QRno.textColor=[UIColor colorWithRed:(189.0f / 255.0f) green:(101.0f / 255.0f) blue:(98.0f / 255.0f) alpha:1.0f];
                QRno.font=[UIFont boldSystemFontOfSize:18];
                QRno.textAlignment=NSTextAlignmentCenter;
                QRno.userInteractionEnabled=YES;
                [DetailsScrollView addSubview:QRno];
                
                
                
                
                
                
            }
            if ([[DetailsArray objectAtIndex:i] objectForKey:@"website"]!=[NSNull null]&& ![[[DetailsArray objectAtIndex:i] objectForKey:@"website"]isEqualToString:@""]) {
                globe=[UIButton buttonWithType:UIButtonTypeRoundedRect];
                globe.frame=CGRectMake((i * self.view.frame.size.width)+45, [[UIScreen mainScreen]bounds].size.height-90-70, 71/2, 71/2);
                [globe setBackgroundImage:[UIImage imageNamed:@"globeicondetails"] forState:UIControlStateNormal];
                [globe setBackgroundImage:[UIImage imageNamed:@"globeicondetails"] forState:UIControlStateSelected];
                [globe setBackgroundImage:[UIImage imageNamed:@"globeicondetails"] forState:UIControlStateHighlighted];
                [globe addTarget:self action:@selector(website:) forControlEvents:UIControlEventTouchUpInside];
                globe.tag = i;
                [DetailsScrollView addSubview:globe];
                
                arrow=[UIButton buttonWithType:UIButtonTypeRoundedRect];
                arrow.frame=CGRectMake(globe.frame.origin.x+globe.frame.size.width+10, [[UIScreen mainScreen]bounds].size.height-90-70, 71/2, 71/2);
                
                
            }
            else
            {
                
                arrow=[UIButton buttonWithType:UIButtonTypeRoundedRect];
                arrow.frame=CGRectMake((i * self.view.frame.size.width)+80, [[UIScreen mainScreen]bounds].size.height-90-70, 71/2, 71/2);
                
            }
            
            //    if ([card_dict objectForKey:@"lat"]!=[NSNull null] && [card_dict objectForKey:@"long"]!=[NSNull null] && ![[card_dict objectForKey:@"lat"]isEqualToString:@""] && ![[card_dict objectForKey:@"long"]isEqualToString:@""] ) {
            //
            
            //    arrow=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            //    arrow.frame=CGRectMake(globe.frame.origin.x+globe.frame.size.width+13, [[UIScreen mainScreen]bounds].size.height-90, 71/2, 71/2);
            [arrow setBackgroundImage:[UIImage imageNamed:@"arrowicondetails"] forState:UIControlStateNormal];
            [arrow setBackgroundImage:[UIImage imageNamed:@"arrowicondetails"] forState:UIControlStateSelected];
            [arrow setBackgroundImage:[UIImage imageNamed:@"arrowicondetails"] forState:UIControlStateHighlighted];
            [arrow addTarget:self action:@selector(locator:) forControlEvents:UIControlEventTouchUpInside];
            arrow.tag = i;
            [DetailsScrollView addSubview:arrow];
            
            
            twit=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            twit.frame=CGRectMake(arrow.frame.origin.x+arrow.frame.size.width+13, [[UIScreen mainScreen]bounds].size.height-90-70, 71/2, 71/2);
            
            
            //    }
            //    else
            //    {
            //         globe.frame=CGRectMake(45+20, [[UIScreen mainScreen]bounds].size.height-90, 71/2, 71/2);
            //
            //        twit=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            //        twit.frame=CGRectMake(110, [[UIScreen mainScreen]bounds].size.height-90, 71/2, 71/2);
            //
            //
            //    }
            //    twit=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            //    twit.frame=CGRectMake(arrow.frame.origin.x+arrow.frame.size.width+13, [[UIScreen mainScreen]bounds].size.height-90, 71/2, 71/2);
            [twit setBackgroundImage:[UIImage imageNamed:@"twittericondetails"] forState:UIControlStateNormal];
            [twit setBackgroundImage:[UIImage imageNamed:@"twittericondetails"] forState:UIControlStateSelected];
            [twit setBackgroundImage:[UIImage imageNamed:@"twittericondetails"] forState:UIControlStateHighlighted];
            [twit addTarget:self action:@selector(shareTwitter:) forControlEvents:UIControlEventTouchUpInside];
            //[twit addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
            twit.tag = i;
            [DetailsScrollView addSubview:twit];
            
            
            fb=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            fb.frame=CGRectMake(twit.frame.origin.x+twit.frame.size.width+13, [[UIScreen mainScreen]bounds].size.height-90-70, 71/2, 71/2);
            [fb setBackgroundImage:[UIImage imageNamed:@"fbicondetails"] forState:UIControlStateNormal];
            [fb setBackgroundImage:[UIImage imageNamed:@"fbicondetails"] forState:UIControlStateSelected];
            [fb setBackgroundImage:[UIImage imageNamed:@"fbicondetails"] forState:UIControlStateHighlighted];
            [fb addTarget:self action:@selector(shareToFacebook:) forControlEvents:UIControlEventTouchUpInside];
            fb.tag = i;
            // [fb addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
            
            [DetailsScrollView addSubview:fb];
            
            share=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            share.frame=CGRectMake(fb.frame.origin.x+fb.frame.size.width+13, [[UIScreen mainScreen]bounds].size.height-90-70, 71/2, 71/2);
            [share setBackgroundImage:[UIImage imageNamed:@"shareicondetails"] forState:UIControlStateNormal];
            [share setBackgroundImage:[UIImage imageNamed:@"shareicondetails"] forState:UIControlStateSelected];
            [share setBackgroundImage:[UIImage imageNamed:@"shareicondetails"] forState:UIControlStateHighlighted];
            [share addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
            // [share addTarget:self action:@selector(open_pages) forControlEvents:UIControlEventTouchUpInside];
            
            [DetailsScrollView addSubview:share];
 
        }

            pagecontrolforzoomimage = [[UIPageControl alloc] initWithFrame:CGRectMake(10, [[UIScreen mainScreen]bounds].size.height-40, 300, 10)];
            
            pagecontrolforzoomimage.currentPage = 0;
            
            pagecontrolforzoomimage.currentPageIndicatorTintColor = [UIColor whiteColor];
            
            pagecontrolforzoomimage.pageIndicatorTintColor = [UIColor lightGrayColor];
            
            pagecontrolforzoomimage.numberOfPages = DetailsArray.count;
            
            [mainview addSubview:pagecontrolforzoomimage];
            [DetailsScrollView setContentSize:CGSizeMake(DetailsArray.count*self.view.frame.size.width, [[UIScreen mainScreen]bounds].size.height)];
  
            
            [spin_img stopAnimating];
            
        }];
    
   }];
  
    
    
    //////////////////
    
//    NSString *urlString1;
//    
//    NSError *error=nil;
//    
//    urlString1 =[NSString stringWithFormat:@"%@barcode_image.php?user_id=%@&company_id=%@",APPS_DOMAIN_URL,userid,[card_dict objectForKey:@"id"]];
//    
//    NSLog(@"eta holo category:  %@",urlString1);
//    
//    NSURL *requestURL1 = [NSURL URLWithString:urlString1];
//    
//    NSData *signeddataURL1 =  [NSData dataWithContentsOfURL:requestURL1 options:NSDataReadingUncached error:&error];
//    
//    NSString *ret_str = [[NSString alloc] initWithData:signeddataURL1 encoding:NSUTF8StringEncoding];
//    
//    NSLog(@"ret_str====%@",ret_str);
    
    

    
    ///**************card edit view
    
    
    editview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height )];
    editview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"1-splashbg-1"]];
    [mainview addSubview:editview];
    
    editview.hidden=YES;
    
    headedit=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
    headedit.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar.png"]];
    [editview addSubview:headedit];
    
    UIImageView *editheading=[[UIImageView alloc]initWithFrame:CGRectMake(120, 25, 183/2, 30)];
    editheading.image=[UIImage imageNamed:@"topbar-logo"];
    [headedit addSubview:editheading];
    
    
    UIButton *cancel=[[UIButton alloc]initWithFrame:CGRectMake(5,30,50, 25)];
    cancel.backgroundColor= [UIColor clearColor];
    [cancel addTarget:self action:@selector(cancel_edit) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    cancel.titleLabel.font = [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:16];
    cancel.clipsToBounds=YES;
    cancel.layer.cornerRadius=5;
    [cancel setSelected:YES];
    
    [headedit addSubview:cancel];
    
    
    UIButton *done=[[UIButton alloc]initWithFrame:CGRectMake(265,30,50, 25)];
    done.backgroundColor= [UIColor clearColor];
    [done addTarget:self action:@selector(done_edit) forControlEvents:UIControlEventTouchUpInside];
    [done setTitle:@"Done" forState:UIControlStateNormal];
    [done setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    done.titleLabel.font =[UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:16];
    done.clipsToBounds=YES;
    done.layer.cornerRadius=5;
    [done setSelected:YES];
    
    [headedit addSubview:done];
    

    
    editcrdimg=[[UIImageView alloc]initWithFrame:CGRectMake(130, headview.frame.origin.y+headview.frame.size.height+10, 50, 50)];
    [editcrdimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[card_dict objectForKey:@"photo"]]] placeholderImage:[UIImage imageNamed:@"logo-1.png"] options:0 == 0?SDWebImageRefreshCached : 0];
    //cardimg.image=[UIImage imageNamed:@"logo-1.png"];
    [editview addSubview:editcrdimg];
    
    UILabel *cmplbl=[[UILabel alloc]initWithFrame:CGRectMake(0, editcrdimg.frame.origin.y+editcrdimg.frame.size.height+10, 320, 20)];
    cmplbl.text=@"Company";
    cmplbl.textColor=[UIColor whiteColor];
    cmplbl.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:16];
    cmplbl.textAlignment=NSTextAlignmentCenter;
    [editview addSubview:cmplbl];
    
    cmptxt=[[UITextField alloc]initWithFrame:CGRectMake(10,cmplbl.frame.origin.y+cmplbl.frame.size.height+5 , 300, 40)];
    cmptxt.backgroundColor=[UIColor whiteColor];
    cmptxt.delegate=self;
    //emailtxt.text=@"arunima@esolzmail.com";
    cmptxt.font= [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:14];
    // usernametxt.placeholder=@"Username";
    UIColor *color = [UIColor grayColor];
    cmptxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Company Name" attributes:@{NSForegroundColorAttributeName: color}];
    cmptxt.textAlignment=NSTextAlignmentLeft;
    cmptxt.text=[NSString stringWithFormat:@"%@",[card_dict objectForKey:@"name"]];
    cmptxt.textColor=[UIColor blackColor];
    [editview addSubview:cmptxt];
    
    
    UILabel *barcodelbl=[[UILabel alloc]initWithFrame:CGRectMake(0, cmptxt.frame.origin.y+cmptxt.frame.size.height+10, 320, 20)];
    barcodelbl.text=@"Barcode";
    barcodelbl.textColor=[UIColor whiteColor];
    barcodelbl.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:16];
    barcodelbl.textAlignment=NSTextAlignmentCenter;
    [editview addSubview:barcodelbl];
    
    codetxt=[[UITextField alloc]initWithFrame:CGRectMake(10,barcodelbl.frame.origin.y+barcodelbl.frame.size.height+5 , 300, 40)];
    codetxt.backgroundColor=[UIColor whiteColor];
    codetxt.delegate=self;
    //emailtxt.text=@"arunima@esolzmail.com";
    codetxt.font= [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:14];
    // usernametxt.placeholder=@"Username";
    UIColor *color1 = [UIColor grayColor];
    codetxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Barcode" attributes:@{NSForegroundColorAttributeName: color1}];
    codetxt.textAlignment=NSTextAlignmentLeft;
    codetxt.text=[NSString stringWithFormat:@"%@",[card_dict objectForKey:@"barcode_url"]];
    codetxt.textColor=[UIColor blackColor];
    [editview addSubview:codetxt];
    
    UILabel *locallbl=[[UILabel alloc]initWithFrame:CGRectMake(0, codetxt.frame.origin.y+codetxt.frame.size.height+10, 320, 20)];
    locallbl.text=@"Local Number";
    locallbl.textColor=[UIColor whiteColor];
    locallbl.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:16];
    locallbl.textAlignment=NSTextAlignmentCenter;
    [editview addSubview:locallbl];
    
    locnotxt=[[UITextField alloc]initWithFrame:CGRectMake(10,locallbl.frame.origin.y+locallbl.frame.size.height+5 , 300, 40)];
    locnotxt.backgroundColor=[UIColor whiteColor];
    locnotxt.delegate=self;
    //emailtxt.text=@"arunima@esolzmail.com";
    locnotxt.font= [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:14];
    // usernametxt.placeholder=@"Username";
    UIColor *color2 = [UIColor grayColor];
    locnotxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Local Number" attributes:@{NSForegroundColorAttributeName: color2}];
    locnotxt.textAlignment=NSTextAlignmentLeft;
    if ([card_dict objectForKey:@"phone"]!=nil && ![[card_dict objectForKey:@"phone"]isKindOfClass:[NSNull class]]) {
        if (![[card_dict objectForKey:@"phone"]isEqualToString:@"0"])
        {
            
            locnotxt.text=[NSString stringWithFormat:@"%@",[card_dict objectForKey:@"phone"]];
        }
    }
    
    locnotxt.textColor=[UIColor blackColor];
    [editview addSubview:locnotxt];
    
    
    UILabel *codetype=[[UILabel alloc]initWithFrame:CGRectMake(0, locnotxt.frame.origin.y+locnotxt.frame.size.height+10, 320, 20)];
    codetype.text=@"Code Type";
    codetype.textColor=[UIColor whiteColor];
    codetype.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:16];
    codetype.textAlignment=NSTextAlignmentCenter;
    [editview addSubview:codetype];
    
    UIImageView *codetype_img=[[UIImageView alloc]initWithFrame:CGRectMake(10, codetype.frame.origin.y+codetype.frame.size.height+5, 300, 40)];
    codetype_img.backgroundColor=[UIColor lightGrayColor];
    codetype_img.userInteractionEnabled=YES;
    [editview addSubview:codetype_img];
    
    typelb=[[UILabel alloc]initWithFrame:CGRectMake(15, 10, 250, 20)];
    typelb.text=@"Select code type";
    typelb.backgroundColor=[UIColor clearColor];
    typelb.textColor=[UIColor blackColor];
    typelb.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:15];
    typelb.textAlignment=NSTextAlignmentLeft;
    [codetype_img addSubview:typelb];
    
    UITapGestureRecognizer *codetap=[[UITapGestureRecognizer alloc]init];
    [codetap addTarget:self action:@selector(codetype_tbl)];
    [codetype_img addGestureRecognizer:codetap];
    
    blackview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, editview.frame.size.height)];
    blackview.backgroundColor=[UIColor blackColor];
    blackview.alpha=0.7;
    [editview addSubview:blackview];
    [blackview setHidden:YES];
    
    editypearr=[[NSMutableArray alloc]initWithObjects:@"NONE",@"BARCODE",@"QR_CODE",nil];
    
    codetable= [[UITableView alloc]initWithFrame:CGRectMake(10, 100, 300,150)];
    codetable.backgroundColor=[UIColor clearColor];
    [codetable.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    codetable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    codetable.showsVerticalScrollIndicator = NO;
    codetable.delegate=self;
    codetable.dataSource=self;
    [editview addSubview:codetable];
    
    [codetable setHidden:YES];
    
    ////////
    
    
    pages_view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height )];
    pages_view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"1-splashbg-1"]];
    [self.view addSubview:pages_view];
    
    
    UIButton *pages_back=[[UIButton alloc]initWithFrame:CGRectMake(10,35, 100/2, 33/2)];
    [pages_back addTarget:self action:@selector(pagesback:) forControlEvents:UIControlEventTouchUpInside];
    [pages_back setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [[pages_back titleLabel] setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
    pages_back.userInteractionEnabled=YES;
    [pages_view addSubview:pages_back];
    
    
    UIButton *facebook_page=[[UIButton alloc]initWithFrame:CGRectMake(20,80,280, 35)];
    facebook_page.backgroundColor= [UIColor whiteColor];
    [facebook_page addTarget:self action:@selector(shareToFacebook:) forControlEvents:UIControlEventTouchUpInside];
    [facebook_page setTitle:@"facebook" forState:UIControlStateNormal];
    [facebook_page setTitleColor:[UIColor colorWithRed:(61/255.0) green:(92/255.0) blue:(153/255.0) alpha:1] forState:UIControlStateNormal];
    facebook_page.titleLabel.font =[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:20];
    facebook_page.clipsToBounds=YES;
    facebook_page.layer.cornerRadius=5;
    [facebook_page setSelected:YES];
    [pages_view addSubview:facebook_page];
    
    
    UIButton *twitter_page=[[UIButton alloc]initWithFrame:CGRectMake(20,140,280, 35)];
    twitter_page.backgroundColor= [UIColor whiteColor];
    [twitter_page addTarget:self action:@selector(shareTwitter:) forControlEvents:UIControlEventTouchUpInside];
    [twitter_page setTitle:@"twitter" forState:UIControlStateNormal];
    [twitter_page setTitleColor:[UIColor colorWithRed:(70/255.0) green:(150/255.0) blue:(212/255.0) alpha:1] forState:UIControlStateNormal];
    twitter_page.titleLabel.font =[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:20];
    twitter_page.clipsToBounds=YES;
    twitter_page.layer.cornerRadius=5;
    [twitter_page setSelected:YES];
    [pages_view addSubview:twitter_page];
    
    [pages_view setHidden:YES];
    ////////
    
    
    //***********************************mapview
    
    map_backview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
    
    map_backview.backgroundColor=[UIColor blackColor];
    [self.view addSubview:map_backview];
    [map_backview setHidden:YES];
    
    headedit=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
    headedit.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar.png"]];
    [map_backview addSubview:headedit];
    
    UIImageView *mapheading=[[UIImageView alloc]initWithFrame:CGRectMake(120, 25, 183/2, 30)];
    mapheading.image=[UIImage imageNamed:@"topbar-logo"];
    [headedit addSubview:mapheading];
    
    UIImageView *back_map=[[UIImageView alloc]initWithFrame:CGRectMake(15, 30, 23/2, 41/2)];
    back_map.image=[UIImage imageNamed:@"left-arrow_new"];
    [headedit addSubview:back_map];
    
    
    UIView *backview=[[UIView alloc]initWithFrame:CGRectMake(0, 15, 60, 45)];
    backview.backgroundColor=[UIColor clearColor];
    [headedit addSubview:backview];
    
    ////////////////////////////////
    UITapGestureRecognizer *back_tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(done_locatr)];
    [backview addGestureRecognizer:back_tap];
    backview.userInteractionEnabled=YES;
    
    
    
    //    UIButton *done_map=[[UIButton alloc]initWithFrame:CGRectMake(265,30,50, 25)];
    //    done_map.backgroundColor= [UIColor clearColor];
    //    [done_map addTarget:self action:@selector(done_locatr) forControlEvents:UIControlEventTouchUpInside];
    //    [done_map setTitle:@"Done" forState:UIControlStateNormal];
    //    [done_map setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    done_map.titleLabel.font =[UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:16];
    //    done_map.clipsToBounds=YES;
    //    done_map.layer.cornerRadius=5;
    //    [done_map setSelected:YES];
    //
    //    [headedit addSubview:done_map];
    
    
    
    map_View = [[MKMapView alloc] initWithFrame:CGRectMake(0, 70, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
    
    map_View.mapType=MKMapTypeSatellite;
    [map_View setDelegate:self];
    [map_backview addSubview:map_View];
    
    
    
    
    googlebackview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
    
    googlebackview.backgroundColor=[UIColor blackColor];
    [self.view addSubview:googlebackview];
    [googlebackview setHidden:YES];
    
    
    headedit=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
    headedit.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar.png"]];
    [googlebackview addSubview:headedit];
    
    UIImageView *mapheadingq=[[UIImageView alloc]initWithFrame:CGRectMake(120, 25, 183/2, 30)];
    mapheadingq.image=[UIImage imageNamed:@"topbar-logo"];
    [headedit addSubview:mapheadingq];
    
    UIImageView *back_mapq=[[UIImageView alloc]initWithFrame:CGRectMake(15, 30, 23/2, 41/2)];
    back_mapq.image=[UIImage imageNamed:@"left-arrow_new"];
    [headedit addSubview:back_mapq];
    
    
    UIView *backviewq=[[UIView alloc]initWithFrame:CGRectMake(0, 15, 60, 45)];
    backviewq.backgroundColor=[UIColor clearColor];
    [headedit addSubview:backviewq];
    
    ////////////////////////////////
    UITapGestureRecognizer *back_tapq=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(done_goole)];
    [backviewq addGestureRecognizer:back_tapq];
    backviewq.userInteractionEnabled=YES;

    //*******end mapview
    
    
    //     if ([card_dict objectForKey:@"lat"]!=[NSNull null] && [card_dict objectForKey:@"long"]!=[NSNull null]) {
    //    CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake([[card_dict objectForKey:@"lat"]floatValue], [[card_dict objectForKey:@"long"]floatValue]);
    //    MKCoordinateRegion adjustedRegion = [map_View regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 1000, 1000)];
    //    [map_View setRegion:adjustedRegion animated:YES];
    //     }
    //
    //
    //
    //    NSLog(@"lattttt==%@",[card_dict objectForKey:@"lat"]);
    //     NSLog(@"longtttt==%@",[card_dict objectForKey:@"long"]);
    //
    //        myAnnotation = [[MKPointAnnotation alloc] init];
    //    if ([card_dict objectForKey:@"lat"]!=[NSNull null] && [card_dict objectForKey:@"long"]!=[NSNull null]) {
    //myAnnotation.coordinate = CLLocationCoordinate2DMake([[card_dict objectForKey:@"lat"]floatValue], [[card_dict objectForKey:@"long"]floatValue]);
    //    }
    //    else
    //    {
    //
    //         myAnnotation.coordinate = CLLocationCoordinate2DMake(0, 0);
    //
    //    }
    //        myAnnotation.title=[NSString stringWithFormat:@"%@",[card_dict objectForKey:@"name"]];
    //        // myAnnotation.subtitle= [[newarr4 objectAtIndex:i]objectForKey:@"id"];
    //
    //        [map_View addAnnotation:myAnnotation];
    
    
    
    
    

    MainQueue = [[NSOperationQueue alloc]init];
    [MainQueue addOperationWithBlock:^{
        
        NSLog(@"array---%@",DetailsArray);
        
        if(DetailsArray.count != 0)
        {
   
        NSString *  urlString =[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&type=store&radius=10000&name=%@&key=AIzaSyD15g_CRZyYCS9HCQ-xGfDHmbNAubmP2k4",_latitude,_longitude,[[NSString stringWithFormat:@"%@",[[DetailsArray objectAtIndex:0]objectForKey:@"company_name"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        NSLog(@"urlstring----> %@", urlString);
        
        NSError *error;
        NSURL *requestURL = [NSURL URLWithString:urlString];
        
        NSData *signeddataURL =  [NSData dataWithContentsOfURL:requestURL options:NSDataReadingUncached error:&error];
        
        NSDictionary *LocationDict = [NSJSONSerialization JSONObjectWithData:signeddataURL options:kNilOptions error:&error];
        
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            LocationArray = [[NSMutableArray alloc]init];
            
            if ([[LocationDict objectForKey:@"status"] isEqualToString:@"OK"])
            {
                
                NSMutableArray *resultsArray = [[NSMutableArray alloc]init];
                
                resultsArray  = [LocationDict objectForKey:@"results"];
                
                NSLog(@"===========location-------> %lu",(unsigned long)resultsArray.count);
                
                for (int l = 0; l<resultsArray.count; l++)
                {
                    locationdictionary = [[NSMutableDictionary alloc]init];
                    
                    [locationdictionary setObject:[[[[resultsArray objectAtIndex:l]objectForKey:@"geometry"] objectForKey:@"location"]objectForKey:@"lat"] forKey:@"latitude"];
                    [locationdictionary setObject:[[[[resultsArray objectAtIndex:l]objectForKey:@"geometry"] objectForKey:@"location"]objectForKey:@"lng"] forKey:@"longitude"];
                    [locationdictionary setObject:[[resultsArray objectAtIndex:l]objectForKey:@"name"] forKey:@"name"];
                    [locationdictionary setObject:[[resultsArray objectAtIndex:l]objectForKey:@"vicinity"] forKey:@"address"];
                    [LocationArray addObject:locationdictionary];
                    
                }
                
             //   NSLog(@"locationdict----------> %@", LocationArray);
            }
            else
            {
                
            }
            
        }];
        }
    }];
  
    


}
-(void)callno
{
    
    
    UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"Would you like to call %@",[[DetailsArray objectAtIndex:0]objectForKey:@"phone"]] delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"Call", nil];
    alertview.tag = 1;
    
    [alertview show];
//  
//    NSLog(@"in call====%@",[card_dict objectForKey:@"phone"] );

    
    
}


-(void)cust_info:(UIButton *)sender
{

    QTpiechartViewController *pie_chart=[[QTpiechartViewController alloc]init];
    pie_chart.company_id=_card_id;
    [pie_chart setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:pie_chart animated:YES completion:nil];

}
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
//{
//    
//    NSLog(@"view for annotation");
//    
//    
//    
//    
//    // If it's the user location, just return nil.
//    if ([annotation isKindOfClass:[MKUserLocation class]])
//        return nil;
//    
//    // Handle any custom annotations.
//    if ([annotation isKindOfClass:[MKPointAnnotation class]])
//    {
//        // Try to dequeue an existing pin view first.
//        MKPinAnnotationView *pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
//        if (!pinView)
//        {
//            // If an existing pin view was not available, create one.
//            
//            
//            pinView = [[MKPinAnnotationView alloc] init];
//            pinView.canShowCallout = YES;
//            
//           // if(annotation==myAnnotation)
//                pinView.image = [UIImage imageNamed:@"Maplocator.png"];
//            
//       
////            else
////            {
////                
////                pinView.image = [UIImage imageNamed:@"locator_blue1.png"];
////                
////            }
//            pinView.calloutOffset = CGPointMake(0, 0);
//            
//            
//            
//            //            annocnt=(!annocnt);
//            //
//            //            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//            //            pinView.rightCalloutAccessoryView = rightButton;
//            //
//            //            UIImageView *iconView = [[UIImageView alloc] init];
//            //            iconView.frame = CGRectMake(0.0f, 0.0f,20, 20);
//            //            pinView.leftCalloutAccessoryView = iconView;
//            
//
//            pinView.annotation = annotation;
//        }
//        
//        // NSLog(@"Annotation-Index: %d", [mapView.annotations indexOfObject:annotation]);
//        return pinView;
//    }
//    
//    return nil;
//}


-(void)cellfirefn:(UITapGestureRecognizer *)sender
{

    NSLog(@"cellfiretap");
    NSLog(@"company id===%@",[[DetailsArray objectAtIndex:sender.view.tag] objectForKey:@"id"]);
    NSLog(@"marchentid====%@",[merchantIdToCellfireId objectForKey:[NSString stringWithFormat:@"%@",[[DetailsArray objectAtIndex:sender.view.tag] objectForKey:@"id"]]]);

    
    [activityIndicator stopAnimating];
    [activityIndicator setHidden:YES];
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 70, 320,[[UIScreen mainScreen]bounds].size.height-70)];
    webView.delegate=self;
    [self.view addSubview:webView];
    [webView setHidden:YES];
    
    
    

        url2 = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.cellfire.com/mobile/index.php?cfm_tlc=dxx&cfm_card_%@=%@&cfm_merchantId=%@&cfm_guest=1#p_all",marchnt_id,[[[DetailsArray objectAtIndex:sender.view.tag] objectForKey:@"barcode_url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],marchnt_id]];
        // NSURL *url2 = [NSURL URLWithString:@"http://google.com"];
        NSLog(@"website url isss====%@",url2);
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url2];
        [webView loadRequest:requestObj];
        [webView setHidden:NO];
    
    
 
    
    
    
    

}
-(void)open_pages
{
    
    
    [pages_view setHidden:NO];
    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [editypearr count];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.backgroundColor =[UIColor clearColor];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    UILabel *listlb=[[UILabel alloc]initWithFrame:CGRectMake(10 ,0,280,30)];
    listlb.backgroundColor=[UIColor clearColor];
    listlb.text= [NSString stringWithFormat:@"%@",[editypearr objectAtIndex:indexPath.row]];
    listlb.textColor=[UIColor blackColor];
    listlb.lineBreakMode=NSLineBreakByWordWrapping;
    listlb.textAlignment=NSTextAlignmentLeft;
    listlb.font=[UIFont fontWithName:@"helveticaneueltstd-bd" size:13];
    [cell addSubview:listlb];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    typelb.text=[NSString stringWithFormat:@"%@",[editypearr objectAtIndex:indexPath.row]];
    [blackview setHidden:YES];
    [codetable setHidden:YES];
    
    
}
-(void)codetype_tbl
{
    
    [blackview setHidden:NO];
    [codetable setHidden:NO];
    
}
-(void)done_edit
{
    
    card_edit=NO;
    
    editview.hidden=YES;
    if (codetxt.text.length>0) {
        barcodestr=[NSString stringWithFormat:@"%@",[codetxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        if ([typelb.text isEqualToString:@"BARCODE"]) {
            
            
            NSLog(@"generate barcode:%@",barcodestr);
            
            
            NKDUPCEBarcode *code=[[NKDUPCEBarcode alloc]initWithContent:barcodestr];
            
            barcodeimg=[UIImage imageFromBarcode:code];
            
            qrimg.backgroundColor=[UIColor whiteColor];
            qrimg.frame=CGRectMake(0, cardimg.frame.origin.y+cardimg.frame.size.height+20, 320,80);
            qrimg.contentMode = UIViewContentModeScaleAspectFit;
            qrimg.clipsToBounds = YES;
            qrimg.image=barcodeimg;
            
            
            //            UILabel *codestrlb=[[UILabel alloc]initWithFrame:CGRectMake(0, qrimg.frame.origin.y+qrimg.frame.size.height+15, 320, 30)];
            //
            //                codestrlb.text=codetxt.text;
            //
            //            codestrlb.textColor=[UIColor whiteColor];
            //            codestrlb.font=[UIFont boldSystemFontOfSize:20];
            //            codestrlb.textAlignment=NSTextAlignmentCenter;
            //            [mainview addSubview:codestrlb];
            qr_code.text=codetxt.text;
            
            
        }
        else if([typelb.text isEqualToString:@"QR_CODE"])
        {
            
            
            qrimg.frame=CGRectMake(110, cardimg.frame.origin.y+cardimg.frame.size.height+20, 100,100);
            
            qrimg.image = [UIImage QRCodeGenerator:barcodestr
                                    andLightColour:[UIColor whiteColor]
                                     andDarkColour:[UIColor blackColor]
                                      andQuietZone:1
                                           andSize:100];
            
            //            UILabel *codestrlb=[[UILabel alloc]initWithFrame:CGRectMake(0, qrimg.frame.origin.y+qrimg.frame.size.height+15, 320, 30)];
            //
            //            codestrlb.text=codetxt.text;
            //
            //            codestrlb.textColor=[UIColor whiteColor];
            //            codestrlb.font=[UIFont boldSystemFontOfSize:20];
            //            codestrlb.textAlignment=NSTextAlignmentCenter;
            //            [mainview addSubview:codestrlb];
            
            qr_code.text=codetxt.text;
            
            
            //            OBLinear *pLinear = [[OBLinear alloc]init];
            //            [pLinear setNBarcodeType: OB_CODE39];
            //            NSString *pMsg = (@"12345");
            //            [pLinear setPDataMsg: pMsg];
            //
            //            [self setLinearBarcodeDimension: pLinear];
            //
            //            CGRect printArea = CGRectMake(10.0, 20.0, 300.0, 200.0);
            //            [pLinear drawWithView: (qrimg) rect: &printArea alignHCenter: TRUE];
            
            
            
        }
        else
        {
            qrimg.frame=CGRectMake(100, cardimg.frame.origin.y+cardimg.frame.size.height+20, 499/4, 415/4);
            qrimg.image=[UIImage imageNamed:@"barcode_none"];
            
            
        }
        
        
        
    }
    else
    {
        qrimg.frame=CGRectMake(100, cardimg.frame.origin.y+cardimg.frame.size.height+20, 499/4, 415/4);
        qrimg.image=[UIImage imageNamed:@"barcode_none"];
        
    }
    
    NSLog(@"company id===%@",[card_dict objectForKey:@"id"]);
    NSLog(@"id===%@",[card_dict objectForKey:@"card_id"]);
    
    
    NSString *urlString1;
    
    NSError *error=nil;
    
    
    
    if (![[card_dict objectForKey:@"barcode_url"]isKindOfClass:[NSNull class]]) {
        barcodestr=[NSString stringWithFormat:@"%@",[card_dict objectForKey:@"barcode_url"]];
    }
    else
        barcodestr=@"";
    NSString *userid=[[NSUserDefaults standardUserDefaults]objectForKey:@"id"];
    
    //urlString1 =[NSString stringWithFormat:@"%@update_user.php?company_id=%@&barcode_url=%@&barcode_type=%@&code_data=%@&company_name=%@&local_no=%@&user_id=%@",APPS_DOMAIN_URL,[[card_dict objectForKey:@"id"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[barcodestr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[typelb.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[codetxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[cmptxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[locnotxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],userid];  //
    
    
    urlString1 =[NSString stringWithFormat:@"%@update_user.php?company_id=%@&barcode_url=%@&barcode_type=%@&code_data=&company_name=%@&local_no=%@&user_id=%@",APPS_DOMAIN_URL,[[card_dict objectForKey:@"id"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[codetxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[typelb.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[cmptxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[locnotxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],userid];
    
    
    
    NSLog(@"eta holo category:  %@",urlString1);
    
    NSURL *requestURL1 = [NSURL URLWithString:urlString1];
    
    NSData *signeddataURL1 =  [NSData dataWithContentsOfURL:requestURL1 options:NSDataReadingUncached error:&error];
    
    NSString *ret_str = [[NSString alloc] initWithData:signeddataURL1 encoding:NSUTF8StringEncoding];
    
    
    NSLog(@"dictionary====%@",ret_str);
    /////////////////////////////
    if([ret_str isEqualToString:@"success"])
    {
        
        alert = [[UIAlertView alloc] initWithTitle:@"Company edited successfully"
                                           message:@""
                                          delegate:self
                                 cancelButtonTitle:nil
                                 otherButtonTitles:@"OK", nil];
        
        
        alert.tag=10;
        [alert show];
    }

    
    
}




- (void) setLinearBarcodeDimension: (OBLinear *) pLinear;
{
    [pLinear setFX: USER_DEF_BAR_WIDTH];
    [pLinear setFY: USER_DEF_BAR_HEIGHT];
    [pLinear setFBarcodeWidth: USER_DEF_BARCODE_WIDTH];
    [pLinear setFBarcodeHeight: USER_DEF_BARCODE_HEIGHT];
    
    [pLinear setFLeftMargin: USER_DEF_LEFT_MARGIN];
    [pLinear setFRightMargin: USER_DEF_RIGHT_MARGIN];
    [pLinear setFTopMargin: USER_DEF_TOP_MARGIN];
    [pLinear setFBottomMargin: USER_DEF_BOTTOM_MARGIN];
    
    [pLinear setNRotate: (USER_DEF_ROTATION)];
    
    UIFont *pTextFont = [UIFont fontWithName: @"Arial" size: 8.0f];
    [pLinear setPTextFont: pTextFont];
}

//textfield delegate method
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
-(void)cancel_edit
{
    
    card_edit=NO;
    
    editview.hidden=YES;
    
}
-(void)card_edit:(UITapGestureRecognizer *)sender
{
    
    card_edit=YES;
    branded=NO;
    
   // editview.hidden=NO;
    
//    NSString *sectionTitle = [card_dict objectAtIndex:indexPath.section];
//    sectionContactsArray = [add_contacts_dict objectForKey:sectionTitle];
  
    QTcardarr *cardobj=[QTcardarr getInstance];
    
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"scantap"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    for (int i=0; i<[cardobj.card_arr count]; i++) {
      
        if ([_card_id isEqualToString:[[cardobj.card_arr objectAtIndex:i]objectForKey:@"id"]])
        {
            
            branded=YES;
            break;
        }
    }
    if (branded) {
      
    NSString *cmpny_name=[[DetailsArray objectAtIndex:sender.view.tag] objectForKey:@"company_name"];
 //   NSString *cmpny_id=[card_dict objectForKey:@"card_id"];
    
    
    
    QTScanCodeViewController *cardpg=[[QTScanCodeViewController alloc]init];
    //[[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"cardadd"];
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"edit_card"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSLog(@"carddetails... :%@",card_dict);
        
        cardpg.cmp_name=cmpny_name;
        cardpg.cmp_id=[card_dict objectForKey:@"id"];
        cardpg.card_no=[[DetailsArray objectAtIndex:sender.view.tag] objectForKey:@"barcode_url"];
        cardpg.loc_no=[[DetailsArray objectAtIndex:sender.view.tag] objectForKey:@"card_number"];
        cardpg.cmp_image=[[DetailsArray objectAtIndex:sender.view.tag] objectForKey:@"company_image"];
        cardpg.card_type = [[DetailsArray objectAtIndex:sender.view.tag] objectForKey:@"barcode_type"];
        [cardpg setCardid:[[DetailsArray objectAtIndex:sender.view.tag] objectForKey:@"id"]];
        [cardpg setCardownername:[[DetailsArray objectAtIndex:sender.view.tag] objectForKey:@"cardownername"]];
        [cardpg setType:@"editcode"];
        
  // [self.navigationController pushViewController:cardpg animated:NO];
        
        [cardpg setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        
        [self presentViewController:cardpg animated:YES completion:nil];
   
    }
    else
    {
    
//       alert = [[UIAlertView alloc] initWithTitle:@"Not a branded company"
//                                                        message:@""
//                                                       delegate:self
//                                              cancelButtonTitle:nil
//                                              otherButtonTitles:@"OK", nil];
//        [alert show];
        
    
        QTcust_detailsViewController *cust=[[QTcust_detailsViewController alloc]init];
        cust.card_id=[card_dict objectForKey:@"id"];
        cust.card_details=card_dict;
       // [self.navigationController pushViewController:cust animated:NO];

        [cust setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        
        [self presentViewController:cust animated:YES completion:nil];

        
    }
    
    
    
    
    
    
}

-(void)share
{
    
//    UIImage *yourImage=cardimg.image;
//    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObjects:[NSString stringWithFormat:@"I just used my #%@ card with #MyEChain loyalty & rewards card App http://bit.ly/uNox4s",[[DetailsArray objectAtIndex:0]objectForKey:@"company_name"]],yourImage, nil] applicationActivities:nil];
//    activityVC.excludedActivityTypes = @[ UIActivityTypeMessage ,UIActivityTypeSaveToCameraRoll];
//    
//    [self presentViewController:activityVC animated:YES completion:nil];
    
    

    UIImage *imagesh = cardimg.image;
    
    NSString *textToShare = [NSString stringWithFormat:@"I just used my #%@ card with #MyEChain loyalty & rewards card App http://bit.ly/uNox4s",[[DetailsArray objectAtIndex:0]objectForKey:@"company_name"]];
 
    NSArray *objectsToShare = @[textToShare, imagesh];
    
    activityView = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    [self presentViewController:activityView animated:YES completion:nil];
    
    
}
-(void)webcrossfn
{
    
    
    [web_company setHidden:YES];
    
    
}
-(void)website:(UIButton *)sender
{
    [activityIndicator stopAnimating];
    [activityIndicator setHidden:YES];
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 70, 320,[[UIScreen mainScreen]bounds].size.height-70)];
    webView.delegate=self;
    [self.view addSubview:webView];
    [webView setHidden:YES];
    
    webstr = [NSString stringWithFormat:@"%@",[[DetailsArray objectAtIndex:sender.tag] objectForKey:@"website"]];
    
    
    if ([[DetailsArray objectAtIndex:sender.tag] objectForKey:@"website"]==[NSNull null]) {
        UIAlertView *alrt=[[UIAlertView alloc]initWithTitle:@"This webpage is not available" message:@"unable to find and load the requested webpage" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alrt show];
    }
    else
    {
        if([[[DetailsArray objectAtIndex:sender.tag] objectForKey:@"website"] rangeOfString:@"http://"].location == NSNotFound)
        {
            url2 = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",[[DetailsArray objectAtIndex:sender.tag] objectForKey:@"website"]]];
            NSLog(@"website url isss====%@",url2);
            NSURLRequest *requestObj = [NSURLRequest requestWithURL:url2];
            [webView loadRequest:requestObj];
            [webView setHidden:NO];
        }
        else
        {
        url2 = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[[DetailsArray objectAtIndex:sender.tag] objectForKey:@"website"]]];
        NSLog(@"website url isss====%@",url2);
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url2];
        [webView loadRequest:requestObj];
        [webView setHidden:NO];
        }
    }
    
    
}
-(void)locator:(UIButton *)sender
{
    
    
    //**********locator_url
    
    //    [activityIndicator stopAnimating];
    //    [activityIndicator setHidden:YES];
    //
    //
    //
    //    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 70, 320,[[UIScreen mainScreen]bounds].size.height-70)];
    //    webView.delegate=self;
    //    [self.view addSubview:webView];
    //    [webView setHidden:YES];
    //
    //    if ([card_dict objectForKey:@"locator"]==[NSNull null]) {
    //        UIAlertView *alrt=[[UIAlertView alloc]initWithTitle:@"This webpage is not available" message:@"unable to find and load the requested webpage" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    //        [alrt show];
    //    }
    //else
    //{
    //    if ([[card_dict objectForKey:@"locator"] hasPrefix:@"http"])
    //   url2 = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[card_dict objectForKey:@"locator"]]];
    //    else
    //        url2 = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",[card_dict objectForKey:@"locator"]]];
    //    // NSURL *url2 = [NSURL URLWithString:@"http://google.com"];
    //     NSLog(@"locator url isss====%@",url2);
    //    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url2];
    //    [webView loadRequest:requestObj];
    //       [webView setHidden:NO];
    //}
    
//    if ([card_dict objectForKey:@"lat"]!=[NSNull null] && [card_dict objectForKey:@"long"]!=[NSNull null]) {
//        
//        if (![[card_dict objectForKey:@"lat"]isEqualToString:@""] && ![[card_dict objectForKey:@"long"]isEqualToString:@""]) {
    
    
//    NSString *urlString;
//    data_retrived = [[NSMutableArray alloc] init];
//    
//    urlString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=true",_latitude,_longitude];
//    
//    NSLog(@" %@",urlString);
//    NSURL *requestURL = [NSURL URLWithString:urlString];
//    NSError* error = nil;
//    NSLog(@"%@", urlString);
//    NSData *signeddataURL =  [NSData dataWithContentsOfURL:requestURL options:NSDataReadingUncached error:&error];
//    
//    NSMutableDictionary *result = [NSJSONSerialization
//                                   JSONObjectWithData:signeddataURL //1
//                                   
//                                   options:kNilOptions
//                                   error:&error];
//    
//    for(NSMutableDictionary *dict in result)
//    {
//        [data_retrived addObject:dict];
//        
//    }
//    
//    streetAdd = [[[result objectForKey:@"results"] objectAtIndex:0] objectForKey:@"formatted_address"];
//
//    
//    
//    
//              [map_backview setHidden:NO];
//            [map_View addAnnotations:[self annotations]];
    
    
    
//        }
//        else
//        {
//            UIAlertView *alrt=[[UIAlertView alloc]initWithTitle:@"SORRY" message:@"No locator found" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//            [alrt show];
//            
//        }
//
//    }
//    else
//    {
//    UIAlertView *alrt=[[UIAlertView alloc]initWithTitle:@"SORRY" message:@"No locator found" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//        [alrt show];
//    
//    }
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[[DetailsArray objectAtIndex:0]objectForKey:@"company_name"]] forKey:@"companyname"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    QTMapDetailsViewController *MapDetails = [[QTMapDetailsViewController alloc]init];
    [MapDetails setCurrentlocationlat:self.latitude];
    [MapDetails setCurrentlocationlong:self.longitude];
   // [MapDetails setLocationArray:LocationArray];
    [MapDetails setDetailsarray:DetailsArray];
//    [MapDetails setDestinationlat:[[[LocationArray objectAtIndex:i] objectForKey:@"latitude"] floatValue]];
//    [MapDetails setDestinationlong:[[[LocationArray objectAtIndex:i] objectForKey:@"longitude"] floatValue]];
//    [MapDetails setAddress:[[LocationArray objectAtIndex:i] objectForKey:@"address"]];
    [self presentViewController:MapDetails animated:YES completion:nil];

 }

- (NSArray *)annotations {
    // Empire State Building
    
    
    NSMutableArray *locarryret = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<LocationArray.count; i++) {
        
        JPSThumbnail *empire = [[JPSThumbnail alloc] init];
        empire.image = [UIImage imageNamed:@"imageicon"];
        empire.title =[[LocationArray objectAtIndex:i] objectForKey:@"name"];
        empire.subtitle =[[LocationArray objectAtIndex:i] objectForKey:@"address"];
        empire.coordinate = CLLocationCoordinate2DMake([[[LocationArray objectAtIndex:i] objectForKey:@"latitude"] floatValue],[[[LocationArray objectAtIndex:i] objectForKey:@"longitude"] floatValue]);
        empire.disclosureBlock1 = ^{
      
           
            
      [googlebackview setHidden:NO];
     UIWebView *gwebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 70, 320,[[UIScreen mainScreen]bounds].size.height-70)];
      gwebView.delegate=self;
      [googlebackview addSubview:gwebView];

      
        NSURL *url3 = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.google.com/maps?saddr=%@&daddr=%@",[streetAdd stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[[LocationArray objectAtIndex:i] objectForKey:@"address"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
       NSURLRequest *requestObj = [NSURLRequest requestWithURL:url3];
       [gwebView loadRequest:requestObj];

//            QTMapDetailsViewController *MapDetails = [[QTMapDetailsViewController alloc]init];
//            [MapDetails setCurrentlocationlat:self.latitude];
//            [MapDetails setCurrentlocationlong:self.longitude];
//            [MapDetails setDestinationlat:[[[LocationArray objectAtIndex:i] objectForKey:@"latitude"] floatValue]];
//            [MapDetails setDestinationlong:[[[LocationArray objectAtIndex:i] objectForKey:@"longitude"] floatValue]];
//            [MapDetails setAddress:[[LocationArray objectAtIndex:i] objectForKey:@"address"]];
//            [self presentViewController:MapDetails animated:YES completion:nil];
      
        };
        
        empire.disclosureBlock = ^{
            
        };
 
        [locarryret addObject:[JPSThumbnailAnnotation annotationWithThumbnail:empire]];
    };
    
    
    CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(_latitude,_longitude);
    MKCoordinateRegion adjustedRegion = [map_View regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 5000, 5000)];
    [map_View setRegion:adjustedRegion animated:YES];
    
  //  [self.imagegif removeFromSuperview];
    //[spinerview removeFromSuperview];
    
    return locarryret;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didSelectAnnotationViewInMap:mapView];
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didDeselectAnnotationViewInMap:mapView];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation conformsToProtocol:@protocol(JPSThumbnailAnnotationProtocol)]) {
        return [((NSObject<JPSThumbnailAnnotationProtocol> *)annotation) annotationViewInMap:mapView];
    }
    return nil;
}

-(void)done_locatr
{
   
      [map_backview setHidden:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"entry");
    
    //if (![webstr isEqualToString:@"www.abc.com"])
   // {
    
    indicatorview=[[UIView alloc]initWithFrame:CGRectMake(137,170,50,50)];
    indicatorview.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.5];
    indicatorview.layer.cornerRadius=10;
    [webView addSubview:indicatorview];
    
    
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame=CGRectMake(15,15, 20, 20);
    [indicator startAnimating];
    
    [indicatorview addSubview:indicator];
   
   // }
   
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [indicatorview removeFromSuperview];

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
       alrtview=[[UIAlertView alloc]initWithTitle:@"Failed !" message:@"No Internet Connection" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alrtview show];
        [alrtview setHidden:NO];
   [indicatorview removeFromSuperview];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1)
    {
        if (buttonIndex == 0)
        {
            NSString *telurl;
            telurl = [NSString stringWithFormat:@"tel://%@",[[DetailsArray objectAtIndex:0]objectForKey:@"phone"]];
            NSLog(@"in call%@",telurl);
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telurl]];
        }

    }
    else
    {
    [webView setHidden:YES];
    [activityIndicator stopAnimating];
    [activityIndicator setHidden:YES];
    }
}
-(void)dealfn:(UIButton *)sender
{
    
    QTDeal_listViewController *deals=[[QTDeal_listViewController alloc]init];
    deals.company_id=_card_id;
    [deals setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:deals animated:YES completion:nil];
    
}
-(void)back
{
    
    MainQueue = nil;
    
    if (!webView.hidden) {
        [webView setHidden:YES];
        
        for (UIView *view in webView.subviews)
        {
            
            [view removeFromSuperview];
        }
      
        
        [alrtview dismissWithClickedButtonIndex:0 animated:NO];
        [alrtview setHidden:YES];
        [activityIndicator stopAnimating];
        [activityIndicator setHidden:YES];
    }
    else
    {
        //  [self.navigationController popViewControllerAnimated:NO];
        
//        QTCardHomeViewController *home=[[QTCardHomeViewController alloc]init];
//        [self.navigationController pushViewController:home animated:NO];

        
      [self dismissViewControllerAnimated:YES completion:nil];

    }
}
-(void)shareTwitter:(UIButton *)sender
{
    
    ////////////////////////Code for twitter share
    
    
    
    //     if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
    //
    //   SLComposeViewController *composeController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    //
    //    [composeController setInitialText:@"MyEChain"];
    //    [composeController addImage:cardimg.image];
    //    //[composeController addURL: [NSURL URLWithString:
    //     //                           @"http://www.apple.com"]];
    //
    //    [self presentViewController:composeController
    //                       animated:YES completion:nil];
    //
    //    SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
    //        if (result == SLComposeViewControllerResultCancelled) {
    //
    //            NSLog(@"delete");
    //
    //        } else
    //
    //        {
    //            NSLog(@"post");
    //        }
    //
    //        //   [composeController dismissViewControllerAnimated:YES completion:Nil];
    //    };
    //    composeController.completionHandler =myBlock;
    //     }
    //     else{
    //
    //
    //         NSLog(@"twitter account not setup");
    //
    //
    //         alert = [[UIAlertView alloc] initWithTitle:@"Sorry!!!" message:@"Please setup your twitter account" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //         //alert.tag=3;
    //
    //         [alert show];
    //
    //
    //     }
    //
    
    //////////////////////////////////////////////////
    
    
    [pages_view setHidden:YES];
    
    [activityIndicator stopAnimating];
    [activityIndicator setHidden:YES];
    
    
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 70, 320,[[UIScreen mainScreen]bounds].size.height-70)];
    webView.delegate=self;
    [self.view addSubview:webView];
    [webView setHidden:YES];
    
    if ([[DetailsArray objectAtIndex:sender.tag] objectForKey:@"twitter"]==[NSNull null]) {
        UIAlertView *alrt=[[UIAlertView alloc]initWithTitle:@"This webpage is not available" message:@"unable to find and load the requested webpage" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        alert.tag= 0;
        [alrt show];
    }
    else
    {
        
        url2 = [NSURL URLWithString:[NSString stringWithFormat:@"http://twitter.com/%@",[[DetailsArray objectAtIndex:sender.tag] objectForKey:@"twitter"]]];
        // NSURL *url2 = [NSURL URLWithString:@"http://google.com"];
        NSLog(@"locator url isss====%@",url2);
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url2];
        [webView loadRequest:requestObj];
        [webView setHidden:NO];
    }
    
    
    
    
    
    
}
-(void)shareToFacebook:(UIButton *)sender

{
    
    
    //////////////////////////////Code for facebook share
    
    
    
    //    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
    //
    //        SLComposeViewController *mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    //
    //        [mySLComposerSheet setInitialText:@"MyEChain"];
    //
    //        [mySLComposerSheet addImage:cardimg.image];
    //
    //        //[mySLComposerSheet addURL:[NSURL URLWithString:@"http://stackoverflow.com/questions/12503287/tutorial-for-slcomposeviewcontroller-sharing"]];
    //
    //        [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
    //
    //            switch (result) {
    //                case SLComposeViewControllerResultCancelled:
    //                    NSLog(@"Post Canceled");
    //                    break;
    //                case SLComposeViewControllerResultDone:
    //                    NSLog(@"Post Sucessful");
    //                    break;
    //
    //                default:
    //                    break;
    //            }
    //        }];
    //
    //        [self presentViewController:mySLComposerSheet animated:YES completion:nil];
    //
    //    }
    //    else{
    //
    //
    //        NSLog(@"fb account not setup");
    //
    //
    //        alert = [[UIAlertView alloc] initWithTitle:@"Sorry!!!" message:@"Please setup your facebook account" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        //alert.tag=3;
    //
    //        [alert show];
    //
    //
    //    }
    
    ///////////////////////////////////////////////////////
    
    [pages_view setHidden:YES];
    [activityIndicator stopAnimating];
    [activityIndicator setHidden:YES];
    
    
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 70, 320,[[UIScreen mainScreen]bounds].size.height-70)];
    webView.delegate=self;
    [self.view addSubview:webView];
    [webView setHidden:YES];
    
    if ([[DetailsArray objectAtIndex:sender.tag] objectForKey:@"facebook"]==[NSNull null]) {
        UIAlertView *alrt=[[UIAlertView alloc]initWithTitle:@"This webpage is not available" message:@"unable to find and load the requested webpage" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alrt show];
    }
    else
    {
        
        url2 = [NSURL URLWithString:[NSString stringWithFormat:@"http://facebook.com/%@",[[DetailsArray objectAtIndex:sender.tag] objectForKey:@"facebook"]]];
        // NSURL *url2 = [NSURL URLWithString:@"http://google.com"];
        NSLog(@"locator url isss====%@",url2);
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url2];
        [webView loadRequest:requestObj];
        [webView setHidden:NO];
    }
    
    
    
}

-(void)shareToFacebook1

{
    
    if([[FBSession activeSession]isOpen])
    {
        
        [FBSession.activeSession requestNewPublishPermissions:@[@"publish_actions",@"publish_stream"]
         
                                              defaultAudience:FBSessionDefaultAudienceFriends
         
                                            completionHandler:^(FBSession *session,
                                                                
                                                                NSError *error)
         {
             [ self startToPost];
         }];
    }
    
    else
    {
        
        [FBSession openActiveSessionWithPublishPermissions:[[NSArray alloc] initWithObjects:@"publish_stream",@"publish_actions", nil]
         
                                           defaultAudience:FBSessionDefaultAudienceFriends
         
                                              allowLoginUI:YES
         
                                         completionHandler:^(FBSession *session,
                                                             
                                                             FBSessionState state, NSError *error) {
                                             
                                             if(!error)
                                                 
                                             {
                                                 
                                                 [self sessionStateChanged:session state:state error:error];
                                                 
                                             }
                                             
                                         }];
        
    }
    
}

-(void)startToPost

{
    UIImage *to_be_shared_img;
    NSString *tag;
    
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    
                                    
                                    
                                    [NSString stringWithFormat:@"%@",tag], @"message",
                                    
                                    
                                    
                                    UIImageJPEGRepresentation(to_be_shared_img, 1.0), @"source",
                                    
                                    
                                    
                                    nil];
    
    
    
    [FBRequestConnection startWithGraphPath:@"/me/photos"
     
                                 parameters:params
     
                                 HTTPMethod:@"POST"
     
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              
                              if (!error) {
                                  
                                  [SVProgressHUD showSuccessWithStatus:@"fbshare"];
                                  
                              } else {
                                  
                                  NSLog(@" error %@",error);
                                  
                                  [SVProgressHUD showErrorWithStatus:@"There occured an error"];
                                  
                              }
                              
                          }];
    
}

- (void)sessionStateChanged:(FBSession *)session



                      state:(FBSessionState) state



                      error:(NSError *)error

{
    
    switch (state) {
            
        case FBSessionStateClosed:
            
            NSLog(@"FBSessionStateClosed");
            
            break;
            
        case FBSessionStateClosedLoginFailed:
            
            NSLog(@"FBSessionStateClosedLoginFailed");
            
            break;
            
        case FBSessionStateCreated:
            
        case FBSessionStateCreatedOpening:
            
        case FBSessionStateOpen:
            
            [self startToPost];
            
            break;
            
        default:
            
            break;
            
    }
    
}

-(void)showsts:(NSString *)status

{
    
    [SVProgressHUD showSuccessWithStatus:status];
    
}

-(void)pagesback:(UIButton *)sender{
    
    [pages_view setHidden:YES];
    
}
-(void)done_goole
{
    [googlebackview setHidden:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    if(scrollView==scrollViewForZoomImage){
//        float width = self.scrollViewForZoomImage.frame.size.width;
//        float xPos = self.scrollViewForZoomImage.contentOffset.x+10;
//        pagecontrolforzoomimage.currentPage = (int)xPos/width;
//    }else{
        float width = DetailsScrollView.frame.size.width;
        float xPos = DetailsScrollView.contentOffset.x+10;
        
        //Calculate the page we are on based on x coordinate position and width of scroll view
        pagecontrolforzoomimage.currentPage = (int)xPos/width;
    //}
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    CLLocation *currentLocation = newLocation;
    
    
    [locationManager stopUpdatingLocation];
    if (currentLocation != nil) {
        
        
        
        self.latitude=  currentLocation.coordinate.latitude;
        self.longitude=  currentLocation.coordinate.longitude;
    }
    
    // this creates a MKReverseGeocoder to find a placemark using the found coordinates
    
    
    //stops didUpdateToLocation to be called infinite times
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
