//
//  QTScanCodeViewController.m
//  MyEchain
//
//  Created by RAHUL - ( iMAC ) on 24/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "QTScanCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImageView+WebCache.h"
#import "QTfooterTab.h"
#import "RootViewController.h"
#import "Model.h"

@interface QTScanCodeViewController ()
{
    QTfooterTab *footerview;
       QTAppDelegate *mainDelegate ;
    NSOperationQueue *MainQueue;
    Mymodel *obj1;
}

@end

@implementation QTScanCodeViewController
@synthesize sendCode,cmp_name,cmp_id,cmp_image,card_no,loc_no,card_type;
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
    
    NSLog(@"QTScanCodeViewController");
    
     NSLog(@"cardadd====%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"scansecurity"]);
//   
//    mainview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height )];
//    mainview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"1-splashbg-1"]];
//    [self.view addSubview:mainview];
//    
//    
//    headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
//    headview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bottom-bar.png"]];
//    [mainview addSubview:headview];
//    
//    
//    UIImageView *headimg=[[UIImageView alloc]initWithFrame:CGRectMake(120, 25, 183/2, 30)];
//    headimg.image=[UIImage imageNamed:@"topbar-logo"];
//    [headview addSubview:headimg];
//
//    footerview = [[QTfooterTab alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-98/2, 320.0f,98/2)];
//    [footerview.profile setSelected:YES];
//    [footerview.profile_bg setHidden:NO];
//    [self.view addSubview:footerview];
//    [footerview setHidden:YES];

///////////////////////////////////////
    
    
    if ([_type isEqualToString:@"editcode"]) {
        
        NSLog(@"editcode");
        


        
        editview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height )];
        editview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"1-splashbg-1"]];
        [self.view addSubview:editview];
        //[editview setHidden:YES];
        
        headedit=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
        headedit.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar.png"]];
        [editview addSubview:headedit];
        
        UIImageView *editheading=[[UIImageView alloc]initWithFrame:CGRectMake(120, 25, 183/2, 30)];
        editheading.image=[UIImage imageNamed:@"topbar-logo"];
        [headedit addSubview:editheading];
        
        
        //********************************
        
        
        UIImageView *scanbar1=[[UIImageView alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-97/2, 320.0f,98/2)];
        scanbar1.image=[UIImage imageNamed:@"scanbar"];
        scanbar1.userInteractionEnabled=YES;
        [editview addSubview:scanbar1];
        
        scan_lbl1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 98/2)];
        scan_lbl1.text=@"Cancel";
        scan_lbl1.textAlignment=NSTextAlignmentCenter;
        scan_lbl1.textColor=[UIColor blackColor];
        scan_lbl1.font=[UIFont systemFontOfSize:20.0f];
        [scanbar1 addSubview:scan_lbl1];
        
        UIView *canclvw=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 98/2)];
        canclvw.backgroundColor=[UIColor clearColor];
        [scanbar1 addSubview:canclvw];
        
        
        UITapGestureRecognizer *canceltap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel_edit)];
        
        canceltap.numberOfTapsRequired=1;
        
        [canclvw addGestureRecognizer:canceltap];
        
        
        
        
        donelb=[[UILabel alloc]initWithFrame:CGRectMake(160, 0, 150, 98/2)];
        donelb.text=@"Done";
        donelb.textAlignment=NSTextAlignmentRight;
        donelb.textColor=[UIColor blackColor];
        donelb.font=[UIFont systemFontOfSize:20.0f];
        [scanbar1 addSubview:donelb];
        
        
        
        UIView *donevw=[[UIView alloc]initWithFrame:CGRectMake(160, 0, 160, 98/2)];
        donevw.backgroundColor=[UIColor clearColor];
        [scanbar1 addSubview:donevw];
        
        
        UITapGestureRecognizer *donetap= [[UITapGestureRecognizer alloc] initWithTarget:self
                                          
                                                                                 action:@selector(done_edit)];
        
        donetap.numberOfTapsRequired=1;
        
        [donevw addGestureRecognizer:donetap];
        
        
        //********************************

        
        
        editcrdimg=[[UIImageView alloc]initWithFrame:CGRectMake(120, headedit.frame.origin.y+headedit.frame.size.height+50, 80, 80)];
        [editcrdimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",cmp_image]] placeholderImage:[UIImage imageNamed:@"logo-1.png"] options:0 == 0?SDWebImageRefreshCached : 0];
        //editcrdimg.image=[UIImage imageNamed:@"logo-1.png"];
        [editview addSubview:editcrdimg];
        
        //    UILabel *cmplbl=[[UILabel alloc]initWithFrame:CGRectMake(0, editcrdimg.frame.origin.y+editcrdimg.frame.size.height+10, 320, 20)];
        //    cmplbl.text=@"Company Name";
        //    cmplbl.textColor=[UIColor whiteColor];
        //    cmplbl.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:16];
        //    cmplbl.textAlignment=NSTextAlignmentCenter;
        //    [editview addSubview:cmplbl];
        
        
        //    UIView *cmptxt_vw=[[UIView alloc]initWithFrame:CGRectMake(10,cmplbl.frame.origin.y+cmplbl.frame.size.height+5,300,40)];
        //    cmptxt_vw.backgroundColor=[UIColor whiteColor];
        //    cmptxt_vw.clipsToBounds=YES;
        //    cmptxt_vw.layer.cornerRadius=5;
        //    [editview addSubview:cmptxt_vw];
        
        
        
        

        
        cmptxt=[[UITextField alloc]initWithFrame:CGRectMake(30, editcrdimg.frame.origin.y+80,[[UIScreen mainScreen]bounds].size.width-60, 40)];
        cmptxt.backgroundColor=[UIColor clearColor];
        cmptxt.delegate=self;
        cmptxt.clipsToBounds=YES;
        cmptxt.layer.cornerRadius=5;
        cmptxt.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:20];
        [cmptxt setAutocorrectionType:UITextAutocorrectionTypeNo];
        UIColor *color = [UIColor grayColor];
        cmptxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Company Name" attributes:@{NSForegroundColorAttributeName: color}];
        cmptxt.textAlignment=NSTextAlignmentCenter;
        if (cmp_name == nil)
        {
            cmptxt.text=@"";
            cmptxt.userInteractionEnabled=YES;
        }
        else
        {
            cmptxt.text=[NSString stringWithFormat:@"%@",cmp_name];
            cmptxt.userInteractionEnabled=NO;
        }
        cmptxt.textColor=[UIColor whiteColor];
        [editview addSubview:cmptxt];
        
        
        
        
        CardOwnerName=[[UITextField alloc]initWithFrame:CGRectMake(30, 265,[[UIScreen mainScreen]bounds].size.width-60, 40)];
        CardOwnerName.backgroundColor=[UIColor clearColor];
        CardOwnerName.delegate=self;
        CardOwnerName.clipsToBounds=YES;
        CardOwnerName.layer.cornerRadius=5;
        [CardOwnerName setAutocorrectionType:UITextAutocorrectionTypeNo];
        CardOwnerName.font= [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:20];
        UIColor *color5 = [UIColor grayColor];
        CardOwnerName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Card owner name" attributes:@{NSForegroundColorAttributeName:color5}];
        CardOwnerName.textAlignment=NSTextAlignmentCenter;
       if ([[NSUserDefaults standardUserDefaults]boolForKey:@"edit_card"]) {
           CardOwnerName.text=[NSString stringWithFormat:@"%@",self.cardownername];
       }
        CardOwnerName.textColor=[UIColor blackColor];
        [editview addSubview:CardOwnerName];
        
        UIImageView *line6=[[UIImageView alloc]initWithFrame:CGRectMake(30, 300,[[UIScreen mainScreen]bounds].size.width-60,1)];
        line6.image=[UIImage imageNamed:@"textline"];
        [editview addSubview:line6];
        

        
        codetxt=[[UITextField alloc]initWithFrame:CGRectMake(30, 305,[[UIScreen mainScreen]bounds].size.width-60, 40)];
        codetxt.backgroundColor=[UIColor clearColor];
        codetxt.delegate=self;
        codetxt.clipsToBounds=YES;
        codetxt.layer.cornerRadius=5;
        codetxt.keyboardType=UIKeyboardTypeNumberPad;
        codetxt.font= [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:20];
        UIColor *color1 = [UIColor grayColor];
        codetxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Edit card number manually" attributes:@{NSForegroundColorAttributeName: color1}];
        codetxt.textAlignment=NSTextAlignmentCenter;
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"edit_card"]) {
            codetxt.text=[NSString stringWithFormat:@"%@",card_no];
        }
        codetxt.textColor=[UIColor blackColor];
        [editview addSubview:codetxt];
        
        UIImageView *line2=[[UIImageView alloc]initWithFrame:CGRectMake(30, 340,[[UIScreen mainScreen]bounds].size.width-60,1)];
        line2.image=[UIImage imageNamed:@"textline"];
        [editview addSubview:line2];
        
        locnotxt=[[UITextField alloc]initWithFrame:CGRectMake(30, 345,[[UIScreen mainScreen]bounds].size.width-60, 40)];
        locnotxt.backgroundColor=[UIColor clearColor];
        locnotxt.delegate=self;
        locnotxt.clipsToBounds=YES;
        locnotxt.layer.cornerRadius=5;
        locnotxt.keyboardType=UIKeyboardTypeNumberPad;
        locnotxt.font= [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:20];
        UIColor *color2 = [UIColor grayColor];
        locnotxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Security Code" attributes:@{NSForegroundColorAttributeName: color2}];
        locnotxt.textAlignment=NSTextAlignmentCenter;
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"edit_card"])
        {
            locnotxt.text=[NSString stringWithFormat:@"%@",loc_no];
        }
        locnotxt.textColor=[UIColor blackColor];
        [editview addSubview:locnotxt];
        
      
        
        UIImageView *line3=[[UIImageView alloc]initWithFrame:CGRectMake(30, 379,[[UIScreen mainScreen]bounds].size.width-60,1.5)];
        line3.image=[UIImage imageNamed:@"textline"];
        [editview addSubview:line3];
        
        UIButton *securitybutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [securitybutton setFrame:CGRectMake(locnotxt.frame.origin.x+locnotxt.frame.size.width-30, 345, 32, 32)];
        [securitybutton setBackgroundImage:[UIImage imageNamed:@"securityinfo"] forState:UIControlStateNormal];
        [securitybutton addTarget:self action:@selector(securitybutton:) forControlEvents:UIControlEventTouchUpInside];
        [editview addSubview:securitybutton];
        
        editypearr=[[NSMutableArray alloc]initWithObjects:@"NONE",@"QR_CODE",@"BARCODE",@"CODE_39",@"CODE_128",@"EAN_13",@"EAN_8",@"UPC_A",@"CODE_93",@"UPC_E",@"UPCEAN",@"PDF417",nil];
        
        
        sel_code=[[UILabel alloc]initWithFrame:CGRectMake(30, line3.frame.origin.y+line3.frame.size.height+5, [[UIScreen mainScreen]bounds].size.width-60,40)];
        sel_code.backgroundColor=[UIColor whiteColor];
        sel_code.textAlignment=NSTextAlignmentCenter;
        sel_code.textColor=[UIColor grayColor];
        sel_code.userInteractionEnabled=YES;
        [editview addSubview:sel_code];
        
        
        if (card_type  == nil) {
            
            sel_code.text=@"Enter code type";
        }
        else
        {
            sel_code.text = card_type;
        }
        
        UIImageView *arrw=[[UIImageView alloc]initWithFrame:CGRectMake(210, 10, 20, 20)];
        arrw.image=[UIImage imageNamed:@"downarrow.png"];
        [sel_code addSubview:arrw];
        
        UITapGestureRecognizer *codetyp_tap= [[UITapGestureRecognizer alloc] initWithTarget:self
                                              
                                                                                     action:@selector(sel_type)];
        
        codetyp_tap.numberOfTapsRequired=1;
        
        [sel_code addGestureRecognizer:codetyp_tap];
        
        
        codetable= [[UITableView alloc]initWithFrame:CGRectMake(30, sel_code.frame.origin.y+sel_code.frame.size.height, [[UIScreen mainScreen]bounds].size.width-60,90)];
        codetable.backgroundColor=[UIColor clearColor];
        [codetable.layer setBorderColor:[[UIColor whiteColor] CGColor]];
        //codetable.backgroundColor=[UIColor whiteColor];
        
        codetable.separatorStyle = UITableViewCellSeparatorStyleNone;
        codetable.showsVerticalScrollIndicator = NO;
        codetable.delegate=self;
        codetable.dataSource=self;
        [editview addSubview:codetable];
        [codetable setHidden:YES];
        
        
        back_key=[[UILabel alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-247, [[UIScreen mainScreen]bounds].size.width, 30)];
        back_key.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:back_key];
        
        
        done_keyboard = [UIButton buttonWithType:UIButtonTypeCustom];
        [done_keyboard setFrame:CGRectMake(230, [[UIScreen mainScreen]bounds].size.height-247, 80, 30)];
        [done_keyboard setTitle:@"DONE" forState:UIControlStateNormal];
        [done_keyboard setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [done_keyboard setBackgroundColor:[UIColor whiteColor]];
        //done_keyboard.layer.cornerRadius=5;
        [done_keyboard addTarget:self action:@selector(done_keyfn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:done_keyboard];
        [done_keyboard setHidden:YES];
        [back_key setHidden:YES];
        
        //************
        
        //////////////////
        
        
        infoview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height )];
        infoview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"camera_info"]];
        // infoview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_cam"]];
        [self.view addSubview:infoview];
        [infoview setHidden:YES];
        
        
        
        
        UIButton *done_info=[[UIButton alloc]initWithFrame:CGRectMake(265,30,50, 25)];
        done_info.backgroundColor= [UIColor clearColor];
        [done_info addTarget:self action:@selector(done_infovw) forControlEvents:UIControlEventTouchUpInside];
        [done_info setTitle:@"Done" forState:UIControlStateNormal];
        [done_info setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        done_info.titleLabel.font = [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:16];
        done_info.clipsToBounds=YES;
        done_info.layer.cornerRadius=5;
        [done_info setSelected:YES];
        [infoview addSubview:done_info];

        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"scansecurity"] isKindOfClass:[NSNull class]] || [[NSUserDefaults standardUserDefaults]objectForKey:@"scansecurity"] ==(id)[NSNull null] || [[[NSUserDefaults standardUserDefaults]objectForKey:@"scansecurity"] isEqualToString:@"(null)"] ||[[[NSUserDefaults standardUserDefaults]objectForKey:@"scansecurity"] length] == 0)
        {
            
            NSLog(@"asche");
            
        BlackEditView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
        [BlackEditView setBackgroundColor:[UIColor blackColor]];
        [BlackEditView setAlpha:0.8f];
        [self.view addSubview:BlackEditView];
        //[BlackEditView setHidden:YES];
        
        Labelview = [[UILabel alloc]initWithFrame:CGRectMake(10, 150, self.view.frame.size.width-20, 200)];
        [Labelview setBackgroundColor:[UIColor whiteColor]];
        Labelview.layer.cornerRadius = 5.0f;
        Labelview.clipsToBounds = YES;
        [self.view addSubview:Labelview];
        
        UILabel *securityLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, Labelview.frame.size.width-20, 150)];
        [securityLabel setBackgroundColor:[UIColor clearColor]];
        [securityLabel setText:@"Security code is not mandatory, you can avoid that code. If you place a code for a card, you can edit and delete that code form edit option of that card details."];
        securityLabel.numberOfLines = 7;
        [securityLabel setTextAlignment:NSTextAlignmentCenter];
        [securityLabel setTextColor:[UIColor blackColor]];
        [securityLabel setFont:[UIFont fontWithName:@"Helvetica" size:18]];
        [Labelview addSubview:securityLabel];
        
        UIImageView *crossimage = [[UIImageView alloc]initWithFrame:CGRectMake(280, 110, 28, 28)];
        [crossimage setImage:[UIImage imageNamed:@"scross"]];
        [BlackEditView addSubview:crossimage];
        
        UIButton *crossbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [crossbutton setFrame:CGRectMake(260, 110, 48, 48)];
        [crossbutton setBackgroundColor:[UIColor clearColor]];
        [crossbutton addTarget:self action:@selector(Crossbuttonfunc:) forControlEvents:UIControlEventTouchUpInside];
        [BlackEditView addSubview:crossbutton];
            
            [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"scansecurity"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        else
        {
            NSLog(@"asche na");
        }
    }
    else
    {
        
        NSLog(@"add code");
        
        BackGroundView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
        [BackGroundView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"1-splashbg-1"]]];
        [self.view addSubview:BackGroundView];
        
    headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 80)];
    headview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bottom-bar.png"]];
    [self.view addSubview:headview];

    UILabel *nt_scanlb=[[UILabel alloc]initWithFrame:CGRectMake(10, 30, 300, 20)];
    nt_scanlb.text=@"NOT SCANNING?";
    [headview addSubview:nt_scanlb];
    
    UILabel *clickadd_lb=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, 300, 20)];
    clickadd_lb.text=@"CLICK TO ADD";
    clickadd_lb.font=[UIFont systemFontOfSize:13];
    [headview addSubview:clickadd_lb];
    
    UITapGestureRecognizer *addtap=[[UITapGestureRecognizer alloc]init];
    [addtap addTarget:self action:@selector(addedit_tap)];
    headview.userInteractionEnabled=YES;
    [headview addGestureRecognizer:addtap];
    
    scanbar=[[UIImageView alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-97/2, 320.0f,98/2)];
    scanbar.image=[UIImage imageNamed:@"scanbar"];
    scanbar.userInteractionEnabled=YES;
    [self.view addSubview:scanbar];
    
    Scan=[[UIButton alloc]initWithFrame:CGRectMake(0,0, 240, 98/2)];
    Scan.backgroundColor=[UIColor clearColor];
    [Scan addTarget:self action:@selector(startNewScannerSession:) forControlEvents:UIControlEventTouchUpInside];
    [scanbar addSubview:Scan];
    
   
    scan_lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 98/2)];
    scan_lbl.text=@"Cancel";
    scan_lbl.textAlignment=NSTextAlignmentCenter;
    scan_lbl.textColor=[UIColor blackColor];
    scan_lbl.font=[UIFont systemFontOfSize:20.0f];
    [Scan addSubview:scan_lbl];
    
    UIImageView *cancl_icon=[[UIImageView alloc]initWithFrame:CGRectMake(270, 10, 25,25)];
    cancl_icon.image=[UIImage imageNamed:@"scan_icon"];
    cancl_icon.userInteractionEnabled=YES;
    [scanbar addSubview:cancl_icon];
    
    UIView *infoview_tap=[[UIView alloc]initWithFrame:CGRectMake(250, 0, 70, 98/2)];
    infoview_tap.backgroundColor=[UIColor clearColor];
    infoview_tap.userInteractionEnabled=YES;
    [scanbar addSubview:infoview_tap];
    
    UITapGestureRecognizer *infot=[[UITapGestureRecognizer alloc]init];
    [infot addTarget:self action:@selector(ifo_pagefn)];
    [infoview_tap addGestureRecognizer:infot];
    
   ///////////////////////////////////////////////
    scannerView=[[RMScannerView alloc]initWithFrame:CGRectMake(0, 80, 320, 518-80)];
    scannerView.delegate=self;
    [self.view addSubview:scannerView];
    
    //////////////////////////////////////////
    
       [scannerView setVerboseLogging:YES];
    
       [scannerView setAnimateScanner:YES];
    
    [scannerView setDisplayCodeOutline:YES];
    
    [scannerView startCaptureSession];
        
   
    
    //self->sessionToggleButton.title = @"Stop";
    
//*******************
    
     
    
//***************************
    ////////////////////////////////////////////
    
    
  codeview = [[UIView alloc] initWithFrame:CGRectMake(10, 120, 300,380)];
   codeview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"1-splashbg-1"]];
    [self.view addSubview:codeview];
    
    [codeview setHidden:YES];
    
    UIImageView *qrimg=[[UIImageView alloc]initWithFrame:CGRectMake(70,20, 300/2, 300/2)];
    qrimg.backgroundColor=[UIColor whiteColor];
    qrimg.image=[UIImage imageNamed:@"barcodevejal"];
    [codeview addSubview:qrimg];
    
    UILabel *typelb=[[UILabel alloc]initWithFrame:CGRectMake(10, qrimg.frame.origin.y+qrimg.frame.size.height+10, 100, 20)];
    typelb.text=@"Type:";
    typelb.font=[UIFont boldSystemFontOfSize:18];
    [codeview addSubview:typelb];
    
   codetype=[[UILabel alloc]initWithFrame:CGRectMake(70, qrimg.frame.origin.y+qrimg.frame.size.height+10, 220, 20)];
    codetype.text=@"Type";
    codetype.font=[UIFont boldSystemFontOfSize:15];
    [codeview addSubview:codetype];

    UILabel *datalb=[[UILabel alloc]initWithFrame:CGRectMake(10, typelb.frame.origin.y+typelb.frame.size.height+10, 100, 20)];
    datalb.text=@"Data:";
    datalb.font=[UIFont boldSystemFontOfSize:18];
    [codeview addSubview:datalb];
    
    codescan=[[UILabel alloc]initWithFrame:CGRectMake(70, typelb.frame.origin.y+typelb.frame.size.height+5, 235, 35)];
    codescan.text=@"Data url";
    codescan.numberOfLines=2;
    codescan.font=[UIFont boldSystemFontOfSize:13];
    [codeview addSubview:codescan];
    
    UILabel *timelb=[[UILabel alloc]initWithFrame:CGRectMake(10, datalb.frame.origin.y+datalb.frame.size.height+10, 100, 20)];
    timelb.text=@"Scan Time:";
    timelb.font=[UIFont boldSystemFontOfSize:18];
    [codeview addSubview:timelb];
    
    timescan=[[UILabel alloc]initWithFrame:CGRectMake(110, datalb.frame.origin.y+datalb.frame.size.height+10, 200, 20)];
    timescan.text=@"time";
    timescan.font=[UIFont boldSystemFontOfSize:15];
    [codeview addSubview:timescan];
    
    urlbtn=[[UIButton alloc]initWithFrame:CGRectMake(10, timelb.frame.origin.y+timelb.frame.size.height+20, 280, 40)];
    urlbtn.backgroundColor=[UIColor whiteColor];
    [urlbtn setTitle:@"Open Url" forState:UIControlStateNormal];
    //     [registerbtn setBackgroundImage:[UIImage imageNamed:@"register-nownew.png"] forState:UIControlStateNormal];
    if ([codescan.text containsString:@"http://"]||[codescan.text containsString:@"https://"]) {
        urlbtn.titleLabel.textColor=[UIColor blackColor];
        [urlbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [urlbtn  addTarget:self action:@selector(weburl) forControlEvents:UIControlEventTouchUpInside];
    }
   else
   {
   
       urlbtn.titleLabel.textColor=[UIColor grayColor];
       [urlbtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
      // [urlbtn  addTarget:self action:@selector(weburl) forControlEvents:UIControlEventTouchUpInside];

   
   }
    [codeview addSubview: urlbtn];
    
    canclbtn=[[UIButton alloc]initWithFrame:CGRectMake(10, urlbtn.frame.origin.y+urlbtn.frame.size.height+10, 280, 40)];
    canclbtn.backgroundColor=[UIColor whiteColor];
    [canclbtn setTitle:@"Cancel" forState:UIControlStateNormal];
    //     [registerbtn setBackgroundImage:[UIImage imageNamed:@"register-nownew.png"] forState:UIControlStateNormal];
    canclbtn.titleLabel.textColor=[UIColor blackColor];
    [canclbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [canclbtn  addTarget:self action:@selector(cancelbtn) forControlEvents:UIControlEventTouchUpInside];
    [codeview addSubview: canclbtn];

    // Get current date time
    
    NSDate *currentDateTime = [NSDate date];
    
    // Instantiate a NSDateFormatter
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // Set the dateFormatter format
    
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    // or this format to show day of the week Sat,11-12-2011 23:27:09
    
    [dateFormatter setDateFormat:@"EEE,MM-dd-yyyy HH:mm:ss"];
    
    // Get the date time in NSString
    
    dateInStringFormated = [dateFormatter stringFromDate:currentDateTime];
    
    NSLog(@"date===%@", dateInStringFormated);

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
    
    
    
   //**********
    editview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height )];
    editview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"1-splashbg-1"]];
    [self.view addSubview:editview];
    [editview setHidden:YES];
    
    headedit=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
    headedit.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar.png"]];
    [editview addSubview:headedit];
    
    UIImageView *editheading=[[UIImageView alloc]initWithFrame:CGRectMake(120, 25, 183/2, 30)];
    editheading.image=[UIImage imageNamed:@"topbar-logo"];
    [headedit addSubview:editheading];
    
    
    
//    UIButton *cancel=[[UIButton alloc]initWithFrame:CGRectMake(5,30,50, 25)];
//    cancel.backgroundColor= [UIColor clearColor];
//    [cancel addTarget:self action:@selector(cancel_edit) forControlEvents:UIControlEventTouchUpInside];
//    [cancel setTitle:@"Cancel" forState:UIControlStateNormal];
//    [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    cancel.titleLabel.font = [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:16];
//    cancel.clipsToBounds=YES;
//    cancel.layer.cornerRadius=5;
//    [cancel setSelected:YES];
//    
//    [headedit addSubview:cancel];
//    
//    
//    UIButton *done=[[UIButton alloc]initWithFrame:CGRectMake(265,30,50, 25)];
//    done.backgroundColor= [UIColor clearColor];
//    [done addTarget:self action:@selector(done_edit) forControlEvents:UIControlEventTouchUpInside];
//    [done setTitle:@"Done" forState:UIControlStateNormal];
//    [done setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    done.titleLabel.font = [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:16];
//    done.clipsToBounds=YES;
//    done.layer.cornerRadius=5;
//    [done setSelected:YES];
//    
//    [headedit addSubview:done];
    
    
    //********************************
    
    
    UIImageView *scanbar1=[[UIImageView alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-97/2, 320.0f,98/2)];
    scanbar1.image=[UIImage imageNamed:@"scanbar"];
    scanbar1.userInteractionEnabled=YES;
    [editview addSubview:scanbar1];

    scan_lbl1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 98/2)];
    scan_lbl1.text=@"Cancel";
    scan_lbl1.textAlignment=NSTextAlignmentCenter;
    scan_lbl1.textColor=[UIColor blackColor];
    scan_lbl1.font=[UIFont systemFontOfSize:20.0f];
    [scanbar1 addSubview:scan_lbl1];
    
    UIView *canclvw=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 98/2)];
    canclvw.backgroundColor=[UIColor clearColor];
    [scanbar1 addSubview:canclvw];
    
    
    UITapGestureRecognizer *canceltap= [[UITapGestureRecognizer alloc] initWithTarget:self
                                        
                                                                               action:@selector(cancel_edit)];
    
    canceltap.numberOfTapsRequired=1;
    
    [canclvw addGestureRecognizer:canceltap];
    
    
    
    
    donelb=[[UILabel alloc]initWithFrame:CGRectMake(160, 0, 150, 98/2)];
    donelb.text=@"Done";
    donelb.textAlignment=NSTextAlignmentRight;
    donelb.textColor=[UIColor blackColor];
    donelb.font=[UIFont systemFontOfSize:20.0f];
    [scanbar1 addSubview:donelb];
    
    
    
    UIView *donevw=[[UIView alloc]initWithFrame:CGRectMake(160, 0, 160, 98/2)];
    donevw.backgroundColor=[UIColor clearColor];
    [scanbar1 addSubview:donevw];
    
    
    UITapGestureRecognizer *donetap= [[UITapGestureRecognizer alloc] initWithTarget:self
                                      
                                                                             action:@selector(done_edit)];
    
    donetap.numberOfTapsRequired=1;
    
    [donevw addGestureRecognizer:donetap];
    
    
    //********************************

    
    editcrdimg=[[UIImageView alloc]initWithFrame:CGRectMake(120, headview.frame.origin.y+headview.frame.size.height+50, 80, 80)];
        [editcrdimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",cmp_image]] placeholderImage:[UIImage imageNamed:@"logo-1.png"] options:0 == 0?SDWebImageRefreshCached : 0];
    //editcrdimg.image=[UIImage imageNamed:@"logo-1.png"];
    [editview addSubview:editcrdimg];
    
//    UILabel *cmplbl=[[UILabel alloc]initWithFrame:CGRectMake(0, editcrdimg.frame.origin.y+editcrdimg.frame.size.height+10, 320, 20)];
//    cmplbl.text=@"Company Name";
//    cmplbl.textColor=[UIColor whiteColor];
//    cmplbl.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:16];
//    cmplbl.textAlignment=NSTextAlignmentCenter;
//    [editview addSubview:cmplbl];
    
    
//    UIView *cmptxt_vw=[[UIView alloc]initWithFrame:CGRectMake(10,cmplbl.frame.origin.y+cmplbl.frame.size.height+5,300,40)];
//    cmptxt_vw.backgroundColor=[UIColor whiteColor];
//    cmptxt_vw.clipsToBounds=YES;
//    cmptxt_vw.layer.cornerRadius=5;
//    [editview addSubview:cmptxt_vw];
    

        
        
    cmptxt=[[UITextField alloc]initWithFrame:CGRectMake(30, editcrdimg.frame.origin.y+80,[[UIScreen mainScreen]bounds].size.width-60, 40)];
    cmptxt.backgroundColor=[UIColor clearColor];
    cmptxt.delegate=self;
    cmptxt.clipsToBounds=YES;
    cmptxt.layer.cornerRadius=5;
    cmptxt.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:20];
    [cmptxt setAutocorrectionType:UITextAutocorrectionTypeNo];
    UIColor *color = [UIColor grayColor];
    cmptxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Company Name" attributes:@{NSForegroundColorAttributeName: color}];
    cmptxt.textAlignment=NSTextAlignmentCenter;
    if (cmp_name == nil)
    {
        cmptxt.text=@"";
        cmptxt.userInteractionEnabled=YES;
    }
    else
    {
        cmptxt.text=[NSString stringWithFormat:@"%@",cmp_name];
        cmptxt.userInteractionEnabled=NO;
    }
    cmptxt.textColor=[UIColor whiteColor];
    [editview addSubview:cmptxt];
    
        CardOwnerName=[[UITextField alloc]initWithFrame:CGRectMake(30, 265,[[UIScreen mainScreen]bounds].size.width-60, 40)];
        CardOwnerName.backgroundColor=[UIColor clearColor];
        CardOwnerName.delegate=self;
        CardOwnerName.clipsToBounds=YES;
        CardOwnerName.layer.cornerRadius=5;
        [CardOwnerName setAutocorrectionType:UITextAutocorrectionTypeNo];
        CardOwnerName.font= [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:20];
        UIColor *color5 = [UIColor grayColor];
        CardOwnerName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Card owner name" attributes:@{NSForegroundColorAttributeName:color5}];
        CardOwnerName.textAlignment=NSTextAlignmentCenter;
        // if ([[NSUserDefaults standardUserDefaults]boolForKey:@"edit_card"]) {
        //  CardOwnerName.text=[NSString stringWithFormat:@"%@",card_no];
        // }
        CardOwnerName.textColor=[UIColor blackColor];
        [editview addSubview:CardOwnerName];
        
        UIImageView *line6=[[UIImageView alloc]initWithFrame:CGRectMake(30, 300,[[UIScreen mainScreen]bounds].size.width-60,1)];
        line6.image=[UIImage imageNamed:@"textline"];
        [editview addSubview:line6];


    
    codetxt=[[UITextField alloc]initWithFrame:CGRectMake(30, 305,[[UIScreen mainScreen]bounds].size.width-60, 40)];
    codetxt.backgroundColor=[UIColor clearColor];
    codetxt.delegate=self;
    codetxt.clipsToBounds=YES;
    codetxt.layer.cornerRadius=5;
    codetxt.keyboardType=UIKeyboardTypeNumberPad;
    codetxt.font= [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:20];
    UIColor *color1 = [UIColor grayColor];
    codetxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Edit card number manually" attributes:@{NSForegroundColorAttributeName: color1}];
    codetxt.textAlignment=NSTextAlignmentCenter;
     if ([[NSUserDefaults standardUserDefaults]boolForKey:@"edit_card"]) {
         
         if (card_no == nil) {
             codetxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Edit card number manually" attributes:@{NSForegroundColorAttributeName: color1}];
         }
         else{
    codetxt.text=[NSString stringWithFormat:@"%@",card_no];
         }
     }
    codetxt.textColor=[UIColor blackColor];
    [editview addSubview:codetxt];
    
    UIImageView *line2=[[UIImageView alloc]initWithFrame:CGRectMake(30, 340,[[UIScreen mainScreen]bounds].size.width-60,1)];
    line2.image=[UIImage imageNamed:@"textline"];
    [editview addSubview:line2];
    
  
    locnotxt=[[UITextField alloc]initWithFrame:CGRectMake(30, 345,[[UIScreen mainScreen]bounds].size.width-60, 40)];
    locnotxt.backgroundColor=[UIColor clearColor];
    locnotxt.delegate=self;
    locnotxt.clipsToBounds=YES;
    locnotxt.layer.cornerRadius=5;
    locnotxt.keyboardType=UIKeyboardTypeNumberPad;
    locnotxt.font= [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:20];
    UIColor *color2 = [UIColor grayColor];
    locnotxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Security Code" attributes:@{NSForegroundColorAttributeName: color2}];
    locnotxt.textAlignment=NSTextAlignmentCenter;
     if ([[NSUserDefaults standardUserDefaults]boolForKey:@"edit_card"])
     {
         
         if (loc_no == nil)
         {
             locnotxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Security Code" attributes:@{NSForegroundColorAttributeName: color2}];
         }
         else
         {
    locnotxt.text=[NSString stringWithFormat:@"%@",loc_no];
         }
     }
    locnotxt.textColor=[UIColor blackColor];
    [editview addSubview:locnotxt];
    
        
        UIButton *securitybutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [securitybutton setFrame:CGRectMake(locktxt.frame.origin.x+locktxt.frame.size.width-30, 345, 32, 32)];
        [securitybutton setBackgroundImage:[UIImage imageNamed:@"securityinfo"] forState:UIControlStateNormal];
        [securitybutton addTarget:self action:@selector(securitybutton:) forControlEvents:UIControlEventTouchUpInside];
        [editview addSubview:securitybutton];
        
    UIImageView *line3=[[UIImageView alloc]initWithFrame:CGRectMake(30, 379,[[UIScreen mainScreen]bounds].size.width-60,1.5)];
    line3.image=[UIImage imageNamed:@"textline"];
    [editview addSubview:line3];
    
    
    
    editypearr=[[NSMutableArray alloc]initWithObjects:@"NONE",@"QR_CODE",@"BARCODE",@"CODE_39",@"CODE_128",@"EAN_13",@"EAN_8",@"UPC_A",@"CODE_93",@"UPC_E",@"UPCEAN",@"PDF417",nil];
    
    
    sel_code=[[UILabel alloc]initWithFrame:CGRectMake(30, line3.frame.origin.y+line3.frame.size.height+5, [[UIScreen mainScreen]bounds].size.width-60,40)];
    sel_code.backgroundColor=[UIColor whiteColor];
    sel_code.textAlignment=NSTextAlignmentCenter;
    sel_code.textColor=[UIColor grayColor];
    sel_code.userInteractionEnabled=YES;
    [editview addSubview:sel_code];
    
    
    if (card_type  == nil) {
        
        sel_code.text=@"Enter code type";
    }
    else
    {
        sel_code.text = card_type;
    }
    
    UIImageView *arrw=[[UIImageView alloc]initWithFrame:CGRectMake(210, 10, 20, 20)];
    arrw.image=[UIImage imageNamed:@"downarrow.png"];
    [sel_code addSubview:arrw];
    
    UITapGestureRecognizer *codetyp_tap= [[UITapGestureRecognizer alloc] initWithTarget:self
                                        
                                                                               action:@selector(sel_type)];
    
    codetyp_tap.numberOfTapsRequired=1;
    
    [sel_code addGestureRecognizer:codetyp_tap];

    
    codetable= [[UITableView alloc]initWithFrame:CGRectMake(30, sel_code.frame.origin.y+sel_code.frame.size.height, [[UIScreen mainScreen]bounds].size.width-60,90)];
    codetable.backgroundColor=[UIColor clearColor];
    [codetable.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    //codetable.backgroundColor=[UIColor whiteColor];

    codetable.separatorStyle = UITableViewCellSeparatorStyleNone;
    codetable.showsVerticalScrollIndicator = NO;
    codetable.delegate=self;
    codetable.dataSource=self;
    [editview addSubview:codetable];
    [codetable setHidden:YES];
    
    
    back_key=[[UILabel alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-247, [[UIScreen mainScreen]bounds].size.width, 30)];
    back_key.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:back_key];
    
    
   done_keyboard = [UIButton buttonWithType:UIButtonTypeCustom];
    [done_keyboard setFrame:CGRectMake(230, [[UIScreen mainScreen]bounds].size.height-247, 80, 30)];
    [done_keyboard setTitle:@"DONE" forState:UIControlStateNormal];
    [done_keyboard setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [done_keyboard setBackgroundColor:[UIColor whiteColor]];
    //done_keyboard.layer.cornerRadius=5;
[done_keyboard addTarget:self action:@selector(done_keyfn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:done_keyboard];
    [done_keyboard setHidden:YES];
    [back_key setHidden:YES];
    
//************
    
//////////////////
   
    
    infoview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height )];
    infoview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"camera_info"]];
    [self.view addSubview:infoview];
    [infoview setHidden:YES];
      
    UIButton *done_info=[[UIButton alloc]initWithFrame:CGRectMake(265,30,50, 25)];
    done_info.backgroundColor= [UIColor clearColor];
    [done_info addTarget:self action:@selector(done_infovw) forControlEvents:UIControlEventTouchUpInside];
    [done_info setTitle:@"Done" forState:UIControlStateNormal];
    [done_info setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    done_info.titleLabel.font = [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:16];
    done_info.clipsToBounds=YES;
    done_info.layer.cornerRadius=5;
    [done_info setSelected:YES];
     [infoview addSubview:done_info];
    
    
        BlackEditView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
        [BlackEditView setBackgroundColor:[UIColor blackColor]];
        [BlackEditView setAlpha:0.8f];
        [self.view addSubview:BlackEditView];
        [BlackEditView setHidden:YES];
        
        Labelview = [[UILabel alloc]initWithFrame:CGRectMake(10, 150, self.view.frame.size.width-20, 200)];
        [Labelview setBackgroundColor:[UIColor whiteColor]];
        Labelview.layer.cornerRadius = 5.0f;
        Labelview.clipsToBounds = YES;
        [self.view addSubview:Labelview];
        [Labelview setHidden:YES];
        
        UILabel *securityLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, Labelview.frame.size.width-20, 150)];
        [securityLabel setBackgroundColor:[UIColor clearColor]];
        [securityLabel setText:@"Security code is not mandatory, you can avoid that code. If you place a code for a card, you can edit and delete that code form edit option of that card details."];
        securityLabel.numberOfLines = 7;
        [securityLabel setTextAlignment:NSTextAlignmentCenter];
        [securityLabel setTextColor:[UIColor blackColor]];
        [securityLabel setFont:[UIFont fontWithName:@"Helvetica" size:18]];
        [Labelview addSubview:securityLabel];
        
        UIImageView *crossimage = [[UIImageView alloc]initWithFrame:CGRectMake(280, 110, 28, 28)];
        [crossimage setImage:[UIImage imageNamed:@"scross"]];
        [BlackEditView addSubview:crossimage];
        
        UIButton *crossbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [crossbutton setFrame:CGRectMake(260, 110, 48, 48)];
        [crossbutton setBackgroundColor:[UIColor clearColor]];
        [crossbutton addTarget:self action:@selector(Crossbuttonfunc:) forControlEvents:UIControlEventTouchUpInside];
        [BlackEditView addSubview:crossbutton];
        
 }
////////////////
}
-(void)securitybutton:(UIButton *)sender
{
    BlackEditView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
    [BlackEditView setBackgroundColor:[UIColor blackColor]];
    [BlackEditView setAlpha:0.8f];
    [self.view addSubview:BlackEditView];
//    [BlackEditView setHidden:YES];
    
    Labelview = [[UILabel alloc]initWithFrame:CGRectMake(10, 150, self.view.frame.size.width-20, 200)];
    [Labelview setBackgroundColor:[UIColor whiteColor]];
    Labelview.layer.cornerRadius = 5.0f;
    Labelview.clipsToBounds = YES;
    [self.view addSubview:Labelview];
//    [Labelview setHidden:YES];
    
    UILabel *securityLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, Labelview.frame.size.width-20, 150)];
    [securityLabel setBackgroundColor:[UIColor clearColor]];
    [securityLabel setText:@"Security code is not mandatory, you can avoid that code. If you place a code for a card, you can edit and delete that code form edit option of that card details."];
    securityLabel.numberOfLines = 7;
    [securityLabel setTextAlignment:NSTextAlignmentCenter];
    [securityLabel setTextColor:[UIColor blackColor]];
    [securityLabel setFont:[UIFont fontWithName:@"Helvetica" size:18]];
    [Labelview addSubview:securityLabel];
    
    UIImageView *crossimage = [[UIImageView alloc]initWithFrame:CGRectMake(280, 110, 28, 28)];
    [crossimage setImage:[UIImage imageNamed:@"scross"]];
    [BlackEditView addSubview:crossimage];
    
    UIButton *crossbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [crossbutton setFrame:CGRectMake(260, 110, 48, 48)];
    [crossbutton setBackgroundColor:[UIColor clearColor]];
    [crossbutton addTarget:self action:@selector(Crossbuttonfunc:) forControlEvents:UIControlEventTouchUpInside];
    [BlackEditView addSubview:crossbutton];
}
-(void)Crossbuttonfunc:(UIButton *)sender
{
    [BlackEditView setHidden:YES];
    [Labelview setHidden:YES];
}
-(void)sel_type
{


    UITapGestureRecognizer *codetyp_tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sel_typag)];
    codetyp_tap.numberOfTapsRequired=1;
    [sel_code addGestureRecognizer:codetyp_tap];
    [codetable setHidden:NO];

}
-(void)sel_typag
{

    
    UITapGestureRecognizer *codetyp_tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sel_type)];
    codetyp_tap.numberOfTapsRequired=1;
    [sel_code addGestureRecognizer:codetyp_tap];
    [codetable setHidden:YES];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [editypearr count];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.backgroundColor =[UIColor clearColor];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    UILabel *listlb=[[UILabel alloc]initWithFrame:CGRectMake(0 ,0,cell.frame.size.width-60,29)];
    listlb.backgroundColor=[UIColor whiteColor];
    listlb.text= [NSString stringWithFormat:@"%@",[editypearr objectAtIndex:indexPath.row]];
    listlb.textColor=[UIColor blackColor];
    listlb.alpha=0.5;
    listlb.clipsToBounds=YES;
    listlb.lineBreakMode=NSLineBreakByWordWrapping;
    listlb.textAlignment=NSTextAlignmentCenter;
    listlb.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:15];
    [cell addSubview:listlb];
    
    cell.backgroundColor=[UIColor clearColor];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    sel_code.text=[NSString stringWithFormat:@"%@",[editypearr objectAtIndex:indexPath.row]];
    
    
    UITapGestureRecognizer *codetyp_tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sel_type)];
    
    codetyp_tap.numberOfTapsRequired=1;
    
    [sel_code addGestureRecognizer:codetyp_tap];
    
    
    [codetable setHidden:YES];
    
    
}
-(void)done_infovw
{

     [infoview setHidden:YES];

}
-(void)ifo_pagefn
{

    [infoview setHidden:NO];

}
-(void)addedit_tap
{

    NSLog(@"In edit");
     if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"scansecurity"] isKindOfClass:[NSNull class]] || [[NSUserDefaults standardUserDefaults]objectForKey:@"scansecurity"] ==(id)[NSNull null] || [[[NSUserDefaults standardUserDefaults]objectForKey:@"scansecurity"] isEqualToString:@"(null)"] ||[[[NSUserDefaults standardUserDefaults]objectForKey:@"scansecurity"] length] == 0)
    {
        [editview setHidden:NO];
        [BlackEditView setHidden:NO];
        [Labelview setHidden:NO];
        
        [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"scansecurity"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    else
    {
         [editview setHidden:NO];
    }
    
   
    

}
-(void)cancel_edit
{
    if ([_type isEqualToString:@"editcode"])
    {
        NSLog(@"cancel edit.");
        
        
//        QTCarddetailViewController *home = [[QTCarddetailViewController alloc]init];
//        [self.navigationController pushViewController:home animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
    
    [codetxt resignFirstResponder];
    [back_key setHidden:YES];
    done_keyboard.hidden=YES;
    back_key.hidden=YES;
    [editview setHidden:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }

}
-(void)done_edit
{

    
    if ([cmptxt.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter company name"
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
   else if ([codetxt.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter card number"
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        
        
        [alert show];
    }
    else if ([sel_code.text isEqualToString:@"Enter code type"])
    {
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please select code type"
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        
        
        [alert show];
    
    }
    else if ([CardOwnerName.text isEqualToString:@"Card owner name"])
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter card owner name"
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        
        
        [alert show];
    }
    else if ([sel_code.text isEqualToString:@"NONE"])
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please select code type"
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        
        
        [alert show];
        
        
    }

    else
    {
    NSString *userid=[[NSUserDefaults standardUserDefaults]objectForKey:@"id"];
    
    ////////////////////////////////////////
    NSString *urlString1;
    
    NSError *error=nil;
    
  
        
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"scantap"])
    {
        
        
        NSLog(@"loconotext............. :%@",locnotxt.text);
    
        urlString1 = [NSString stringWithFormat:@"%@new_card_details.php?user_id=%@&company_name=%@&barcode_type=%@&code_data=%@&card_number=%@&owner_name=%@",APPS_DOMAIN_URL,userid,[cmptxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[sel_code.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[codetxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[locnotxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[CardOwnerName.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else if ([[NSUserDefaults standardUserDefaults]boolForKey:@"edit_card"])
    {
        urlString1 = [NSString stringWithFormat:@"%@update_details.php?code_data=%@&card_number=%@&name=%@&code_type=%@&id=%@&owner_name=%@",APPS_DOMAIN_URL,[codetxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[locnotxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[cmptxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[sel_code.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],_cardid,[CardOwnerName.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        urlString1 =[NSString stringWithFormat:@"%@code_data_insert.php?user_id=%@&code_data=%@&company_id=%@&code_type=%@&card_number=%@&owner_name=%@",APPS_DOMAIN_URL,userid,[codetxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],cmp_id,[sel_code.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[locnotxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[CardOwnerName.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    NSLog(@"eta holo category:  %@",urlString1);
    
    NSURL *requestURL1 = [NSURL URLWithString:urlString1];
    
    NSData *signeddataURL1 =  [NSData dataWithContentsOfURL:requestURL1 options:NSDataReadingUncached error:&error];
    
    NSString *ret_str = [[NSString alloc] initWithData:signeddataURL1 encoding:NSUTF8StringEncoding];
    
    
    NSLog(@"dictionary====%@",ret_str);
    /////////////////////////////
        
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"scantap"])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Card added successfully"
                                                            message:@""
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
            
            alert.tag=1005;
            [alert show];
        }
        
       else if ([[NSUserDefaults standardUserDefaults]boolForKey:@"edit_card"]) {
         
            if([ret_str isEqualToString:@"success"])
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Card edited successfully"
                                                                message:@""
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"OK", nil];
                
                alert.tag=1000;
                [alert show];
            }
            else if ([ret_str isEqualToString:@"already exsits"])
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Card edited successfully"
                                                                message:@""
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"OK", nil];
                
                alert.tag=1000;
                [alert show];
                
                
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Card cannot be edited"
                                                                message:@""
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                
                
                [alert show];
                
                
            }
            
//            MainQueue = [[NSOperationQueue alloc]init];
//            [MainQueue addOperationWithBlock:^{
//                
//                NSString *  urlString =[NSString stringWithFormat:@"http://www.esolz.co.in/lab1/Web/myEchain/Iosapp/user_companylist.php?userid=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"id"]];  //
//                
//                NSError *error;
//                NSURL *requestURL = [NSURL URLWithString:urlString];
//                
//                NSData *signeddataURL =  [NSData dataWithContentsOfURL:requestURL options:NSDataReadingUncached error:&error];
//                
//                NSMutableArray *Tmp = [NSJSONSerialization JSONObjectWithData:signeddataURL options:kNilOptions error:&error];
//                
//                
//                
//                obj1 = [Mymodel getInstance];
//                
//                obj1.cardarray = Tmp;
//                
//                NSString *string = [Tmp componentsJoinedByString:@","];
//                
//                NSUserDefaults *userData = [NSUserDefaults standardUserDefaults];
//                [userData setObject:string forKey:@"personDataArray"];
//                [userData synchronize];
//                
//                NSLog(@"data---- %@",[userData objectForKey:@"personDataArray"]);
//
//                
//                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                    
//                }];
//                
//            }];
        }
    else
    {
    if([ret_str isEqualToString:@"success"])
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Card added successfully"
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
        
        alert.tag=1001;
        [alert show];
    }
    else if ([ret_str isEqualToString:@"already exsits"])
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Card already exists"
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"ok", nil];
        alert.tag=1;
        [alert show];
        
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Card cannot be added"
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        
      
        [alert show];
        
        
    }
    }//not edit code
   
    }
}

-(void)weburl
{

    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 80, 320,442)];
    webView.delegate=self;
    NSURL *url2 = [NSURL URLWithString:sendCode];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url2];
    [webView loadRequest:requestObj];
    [self.view addSubview:webView];

}
-(void)cancelbtn
{

    [codeview setHidden:YES];
    [scannerView startScanSession];
    scan_lbl.text=@"Cancel";
    scan_lbl.textColor=[UIColor blackColor];
    

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //to stop sliding view
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    }
    
}
-(void)startNewScannerSession:(id)sender
{

    
        [scannerView stopScanSession];
        scan_lbl.text=@"Cancel";
        scan_lbl.textColor=[UIColor blackColor];
    
    
    
  //  [self.navigationController popViewControllerAnimated:NO];
    
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"cur_page"]isEqualToString:@"cardlist"]) {
        QTaddCardViewController *cardlist=[[QTaddCardViewController alloc]init];
        mainDelegate = (QTAppDelegate *)[[UIApplication sharedApplication] delegate];
        [mainDelegate.navigationController pushViewController:cardlist animated:NO];
         [self dismissViewControllerAnimated:YES completion:nil];
        
        
    }
    
  else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"cur_page"]isEqualToString:@"cardhome"]) {
    
    RootViewController *cardpg=[[RootViewController alloc]init];
       [self.navigationController pushViewController:cardpg animated:YES];
//   mainDelegate = (QTAppDelegate *)[[UIApplication sharedApplication] delegate];
//    [mainDelegate.navigationController pushViewController:cardpg animated:NO];
   }
  else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"cur_page"]isEqualToString:@"profile"]) {
        QTprofileViewController *prof=[[QTprofileViewController alloc]init];
        mainDelegate = (QTAppDelegate *)[[UIApplication sharedApplication] delegate];
        [mainDelegate.navigationController pushViewController:prof animated:NO];
    }
    else
    {
        RootViewController *cardpg=[[RootViewController alloc]init];
        [self.navigationController pushViewController:cardpg animated:YES];
    }
    
     [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
-(void)noweburl
{}
- (void)didScanCode:(NSString *)scannedCode onCodeType:(NSString *)codeType {
    
    
    
    dispatch_queue_t queue = dispatch_queue_create("com.example.MyQueue", NULL);
    
    dispatch_async(queue, ^{
        
        // Do some computation here.
        
        
        
        // Update UI after computation.
        
        dispatch_async(dispatch_get_main_queue(), ^{

        
    
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"cardadd"]) {
        
//        [codeview setHidden:NO];
//        codetype.text=[NSString stringWithFormat:@"Scanned %@", [scannerView humanReadableCodeTypeForCode:codeType]];
//        codescan.text=[NSString stringWithFormat:@"%@",scannedCode];
        
    
        
        
        if ([scannedCode containsString:@"http://esolz.co.in/lab1/Web/myEchain/"]||[scannedCode containsString:@"https://esolz.co.in/lab1/Web/myEchain/"]) {
            
            
            [BackGroundView removeFromSuperview];
            
            inapp_webview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
            inapp_webview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"1-splashbg-1"]];
            [self.view addSubview:inapp_webview];
            
            
            headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 70)];
            headview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bottom-bar.png"]];
            [inapp_webview addSubview:headview];
            
            
            UIImageView *headimg=[[UIImageView alloc]initWithFrame:CGRectMake(120, 25, 183/2, 30)];
            headimg.image=[UIImage imageNamed:@"topbar-logo"];
            [headview addSubview:headimg];
        
            UIButton *back=[[UIButton alloc]initWithFrame:CGRectMake(10,35, 100/2, 33/2)];
            [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
            [back setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
            [[back titleLabel] setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
            back.userInteractionEnabled=YES;
            [headview addSubview:back];
            
            //=======footerview
            
            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"inhome"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
//            footerview = [[QTfooterTab alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-98/2, 320.0f,98/2)];
//            [footerview.scanner setSelected:YES];
//            [footerview.scan_bg setHidden:NO];
//            footerview.scan_bg.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"select-bottombg"]];
//            [self.view addSubview:footerview];
            
           NSString *fulname=[NSString stringWithFormat:@"%@ %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"first_name"],[[NSUserDefaults standardUserDefaults]objectForKey:@"last_name"]];
            
            
        NSString *append_url=[NSString stringWithFormat:@"%@?name=%@&email=%@&sex=&city=&state=&zip=&address=&address2=&phone=&birthday=&type=app&type1=app_form",scannedCode,[fulname stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults]objectForKey:@"email"]];
            
            NSLog(@"appendurl----- %@", append_url);
            
            UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 70, [[UIScreen mainScreen]bounds].size.width,[[UIScreen mainScreen]bounds].size.height-70)];
            webView.delegate=self;
            NSURL *url2 = [NSURL URLWithString:append_url];
            NSURLRequest *requestObj = [NSURLRequest requestWithURL:url2];
            [webView loadRequest:requestObj];
            [inapp_webview addSubview:webView];
        
        }
        else
        {
            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"This is not a MyEchain Business card"] message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];

            sendCode=[NSString stringWithFormat:@"%@",scannedCode];
            sendcodetype=[NSString stringWithFormat:@"%@", [scannerView humanReadableCodeTypeForCode:codeType]];
//            [scannerView setHidden:YES];
//            [BackGroundView setHidden:YES];
//            [scanbar setHidden:YES];
//            [headview setHidden:YES];
            sel_code.text = @"";
            sel_code.text =sendcodetype;
            codetxt.text = @"";
            codetxt.text = scannedCode;
            
            [editview setHidden:NO];
        }
        
       timescan.text=[NSString stringWithFormat:@"%@",dateInStringFormated];
                
      
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Scanned %@", [scannerView humanReadableCodeTypeForCode:codeType]] message:scannedCode delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:@"Re-Scan", nil];
//            [alert show];
         sendCode=[NSString stringWithFormat:@"%@",scannedCode];
        
       //******
        
        
        NSLog(@"-=-=-= %@-=-=-=%@-=-=-=%@-=-=-=-=-",scannedCode,[scannerView humanReadableCodeTypeForCode:codeType],dateInStringFormated);
        
        
    }

    else
    {
    sendCode=[NSString stringWithFormat:@"%@",scannedCode];
        sendcodetype=[NSString stringWithFormat:@"%@", [scannerView humanReadableCodeTypeForCode:codeType]];
        
        NSLog(@"sendcodetype---------> %@",sendcodetype);
    
    QTaddScanViewController *cardpg=[[QTaddScanViewController alloc]init];
    cardpg.receiveCode=sendCode;
    cardpg.receiveCode_type=sendcodetype;
    cardpg.company_name=cmp_name;
    cardpg.company_id=cmp_id;
        cardpg.local_no=loc_no;
        cardpg.company_img=cmp_image;
    QTAppDelegate *mainDelegate = (QTAppDelegate *)[[UIApplication sharedApplication] delegate];
    [mainDelegate.navigationController pushViewController:cardpg animated:YES];
    }
  
            
        });
    });
            
}

- (void)errorGeneratingCaptureSession:(NSError *)error {
//    [scannerView stopCaptureSession];
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unsupported Device" message:@"This device does not have a camera. Run this app on an iOS device that has a camera." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
//    [alert show];
//    
//    statusText.text = @"Unsupported Device";
  
}

- (void)errorAcquiringDeviceHardwareLock:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Focus Unavailable" message:@"Tap to focus is currently unavailable. Try again in a little while." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alert show];
}

- (BOOL)shouldEndSessionAfterFirstSuccessfulScan {
    // Return YES to only scan one barcode, and then finish - return NO to continually scan.
    // If you plan to test the return NO functionality, it is recommended that you remove the alert view from the "didScanCode:" delegate method implementation
    // The Display Code Outline only works if this method returns NO
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    //alertview when inserting manually
    
    if (alertView.tag==1000) {
        
        
        if (buttonIndex != [alertView cancelButtonIndex]) {
            NSLog(@"Launching the store");
            //replace appname with any specific name you want
            
            //--// Rahul 28 Apr
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DataEdited" object:self];
            
            ///////
            
            QTCarddetailViewController *view = [[QTCarddetailViewController alloc]init];
            [self.navigationController pushViewController:view animated:NO];
//       mainDelegate = (QTAppDelegate *)[[UIApplication sharedApplication] delegate];
//        [mainDelegate.navigationController pushViewController:cardpg animated:NO];
            
//            [cardpg setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
//            
//            [self presentViewController:cardpg animated:YES completion:nil];
            
           [self dismissViewControllerAnimated:YES completion:nil];
            
        }
    }
    else if (alertView.tag == 1005)
    {
        RootViewController *cardpg=[[RootViewController alloc]init];
        QTAppDelegate *mainDelegate = (QTAppDelegate *)[[UIApplication sharedApplication] delegate];
        [mainDelegate.navigationController pushViewController:cardpg animated:NO];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if (alertView.tag == 1001)
    {
        RootViewController *view = [[RootViewController alloc]init];
        [self.navigationController pushViewController:view animated:NO];
        
    }
    else
    {

    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Re-Scan"])
    {
        [scannerView startScanSession];
        scan_lbl.text=@"Cancel";
        scan_lbl.textColor=[UIColor blackColor];
        
       
      
    } else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Okay"])
    {
      
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 80, 320,442)];
        webView.delegate=self;
        NSURL *url2 = [NSURL URLWithString:sendCode];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url2];
        [webView loadRequest:requestObj];
        [self.view addSubview:webView];
        
    }
    }
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    activityIndicator.backgroundColor=[UIColor lightGrayColor];
    activityIndicator.center = self.view.center;
    [self.view addSubview: activityIndicator];
    
    [activityIndicator startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicator stopAnimating];
    [activityIndicator setHidden:YES];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alrt=[[UIAlertView alloc]initWithTitle:@"No Internet Access / Not Valide URL" message:@"Check your WiFi or 3G connection" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alrt show];
}

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar {
    return UIBarPositionTopAttached;
}
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    
//    OBLinear *pLinear = [OBLinear new];
//    [pLinear setNBarcodeType: OB_CODE128A];
//    [pLinear setPDataMsg: [[NSString alloc] initWithString: (@"AB")]];
//    //[pLinear setPSupData: [[NSString alloc] initWithString: (@"14562")]];
//    [pLinear setFX: USER_DEF_BAR_WIDTH];
//    [pLinear setFY: USER_DEF_BAR_HEIGHT];
//    
//    [pLinear setFLeftMargin: (USER_DEF_LEFT_MARGIN)];
//    [pLinear setFRightMargin: (USER_DEF_RIGHT_MARGIN)];
//    [pLinear setFTopMargin: (USER_DEF_TOP_MARGIN)];
//    [pLinear setFBottomMargin: (USER_DEF_BOTTOM_MARGIN)];
//    
//    [pLinear setNRotate: (OB_Rotate0)];
//    
//    UIFont *pTextFont = [UIFont fontWithName: @"Arial" size: 8.0f];
//    [pLinear setPTextFont: pTextFont];
//    
//    [pLinear drawWithView: (self)];
//    [pLinear release];
//    
//}
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
     
     [locktxt resignFirstResponder];
        
        
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

-(void)delayedfunc
{
    done_keyboard.hidden=NO;
    back_key.hidden=NO;
    
    [cmptxt resignFirstResponder];
}

//textfield delegate method
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
     if (textField==locnotxt) {
     editview.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
     }
    editview.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField==codetxt) {
        
        [self performSelector:@selector(delayedfunc) withObject:nil afterDelay:0.4f];
        editview.frame = CGRectMake(0, -50, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    }
    if (textField==locnotxt) {
        
        [self performSelector:@selector(delayedfunc) withObject:nil afterDelay:0.4f];
        
        editview.frame = CGRectMake(0, -60, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
       
    }
    if (textField == cmptxt || textField == CardOwnerName) {
        
        //[donelb setHidden:YES];
        [done_keyboard setHidden:YES];
        [back_key setHidden:YES];
        
        editview.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    }
    return YES;
}
-(void)done_keyfn:(UIButton*)sender
{
    editview.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
[codetxt resignFirstResponder];
    [locnotxt resignFirstResponder];
     done_keyboard.hidden=YES;
     back_key.hidden=YES;

    

}

-(void)back:(UIButton *)sender
{
    [inapp_webview removeFromSuperview];
    RootViewController *cardpg=[[RootViewController alloc]init];
    QTAppDelegate *mainDelegate = (QTAppDelegate *)[[UIApplication sharedApplication] delegate];
    [mainDelegate.navigationController pushViewController:cardpg animated:NO];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
