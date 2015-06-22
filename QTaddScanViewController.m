//
//  QTaddScanViewController.m
//  MyEchain
//
//  Created by RAHUL - ( iMAC ) on 24/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "QTaddScanViewController.h"
#import "UIImageView+WebCache.h"
#import "RootViewController.h"

@interface QTaddScanViewController ()

@end

@implementation QTaddScanViewController
@synthesize receiveCode,company_name,company_id,receiveCode_type,company_img,local_no;
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
    
    NSLog(@"QTaddScanViewController");
    
    mainview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height )];
    mainview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"1-splashbg-1"]];
    [self.view addSubview:mainview];
    
    
    headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
    headview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar.png"]];
    [mainview addSubview:headview];
    
    
    UIImageView *headimg=[[UIImageView alloc]initWithFrame:CGRectMake(120, 25, 183/2, 30)];
    headimg.image=[UIImage imageNamed:@"topbar-logo"];
    [headview addSubview:headimg];
    

    
    UIImageView *profimg=[[UIImageView alloc]initWithFrame:CGRectMake(120, headview.frame.origin.y+headview.frame.size.height+50,80,80)];
     [profimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",company_img]] placeholderImage:[UIImage imageNamed:@"logo-1.png"] options:0 == 0?SDWebImageRefreshCached : 0];
    [mainview addSubview:profimg];
    
    
//    UIImageView *editimg=[[UIImageView alloc]initWithFrame:CGRectMake(profimg.frame.origin.x+profimg.frame.size.width-10, headview.frame.origin.y+headview.frame.size.height+120, 48/2, 49/2)];
//    editimg.image=[UIImage imageNamed:@"edit"];
//    [mainview addSubview:editimg];
    
    
    company=[[UITextField alloc]initWithFrame:CGRectMake(30, profimg.frame.origin.y+80,[[UIScreen mainScreen]bounds].size.width-60, 40)];
    company.backgroundColor=[UIColor clearColor];
    company.text=company_name;
    company.clipsToBounds = YES;
    company.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:20];
    company.userInteractionEnabled=NO;
    company.textAlignment=NSTextAlignmentCenter;
    company.textColor=[UIColor whiteColor];
    [mainview addSubview:company];
    
//    UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(40, company.frame.origin.y+35,508/2,1)];
//    line.image=[UIImage imageNamed:@"textline"];
//    [mainview addSubview:line];
    
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
    [mainview addSubview:CardOwnerName];
    
    

    code=[[UITextField alloc]initWithFrame:CGRectMake(30, 305,[[UIScreen mainScreen]bounds].size.width-60, 40)];
    code.backgroundColor=[UIColor clearColor];
    code.delegate=self;
    code.keyboardType=UIKeyboardTypeNumberPad;
    UIColor *color1 = [UIColor grayColor];
    code.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Edit card number manually" attributes:@{NSForegroundColorAttributeName: color1}];
   
       // code.text=receiveCode;

    code.text=receiveCode;
    code.textAlignment=NSTextAlignmentCenter;
   code.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:20];
    [mainview addSubview:code];
    
    
    
    locnotxt=[[UITextField alloc]initWithFrame:CGRectMake(30, 345,[[UIScreen mainScreen]bounds].size.width-60, 40)];
    locnotxt.backgroundColor=[UIColor clearColor];
    locnotxt.delegate=self;
    locnotxt.clipsToBounds=YES;
    locnotxt.layer.cornerRadius=5;
    locnotxt.keyboardType=UIKeyboardTypeNumberPad;
    locnotxt.font= [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:20];
    // usernametxt.placeholder=@"Username";
    UIColor *color2 = [UIColor grayColor];
    locnotxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Security Code" attributes:@{NSForegroundColorAttributeName: color2}];
    locnotxt.textAlignment=NSTextAlignmentCenter;
    // codetxt.text=[NSString stringWithFormat:@"%@",[card_dict objectForKey:@"name"]];
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"edit_card"])
    {
        locnotxt.text=[NSString stringWithFormat:@"%@",local_no];
    }
    locnotxt.textColor=[UIColor blackColor];
    [mainview addSubview:locnotxt];
    
    
    
    UIButton *securitybutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [securitybutton setFrame:CGRectMake(locnotxt.frame.origin.x+locnotxt.frame.size.width-30,345, 32, 32)];
    [securitybutton setBackgroundImage:[UIImage imageNamed:@"securityinfo"] forState:UIControlStateNormal];
    [securitybutton addTarget:self action:@selector(securitybutton:) forControlEvents:UIControlEventTouchUpInside];
    [mainview addSubview:securitybutton];
    
    
    UIImageView *line2=[[UIImageView alloc]initWithFrame:CGRectMake(30, 300,[[UIScreen mainScreen]bounds].size.width-60,1)];
    line2.image=[UIImage imageNamed:@"textline"];
    [mainview addSubview:line2];

    UIImageView *line3=[[UIImageView alloc]initWithFrame:CGRectMake(30, 340,[[UIScreen mainScreen]bounds].size.width-60,1)];
    line3.image=[UIImage imageNamed:@"textline"];
    [mainview addSubview:line3];
    
    UIImageView *line4=[[UIImageView alloc]initWithFrame:CGRectMake(30, 379,[[UIScreen mainScreen]bounds].size.width-60,1)];
    line4.image=[UIImage imageNamed:@"textline"];
    [mainview addSubview:line4];
    
    editypearr = [[NSMutableArray alloc]init];
    
    editypearr=[[NSMutableArray alloc]initWithObjects:@"NONE",@"QR_CODE",@"BARCODE",@"CODE_39",@"CODE_128",@"EAN_13",@"EAN_8",@"UPC_A",@"CODE_93",@"UPC_E",@"UPCEAN",nil];
    

    
    
    sel_code=[[UILabel alloc]initWithFrame:CGRectMake(30, line4.frame.origin.y+line4.frame.size.height+5, [[UIScreen mainScreen]bounds].size.width-60,40)];
    sel_code.backgroundColor=[UIColor whiteColor];
    sel_code.textAlignment=NSTextAlignmentCenter;
    sel_code.textColor=[UIColor grayColor];
    sel_code.userInteractionEnabled=YES;
    [mainview addSubview:sel_code];
    
    
    if (receiveCode_type  == nil)
    {
        sel_code.text=@"Enter code type";
    }
    else
    {
        if ([receiveCode_type isEqualToString:@"Code 93"]) {
            
            sel_code.text = @"CODE_93";
        }
        else if ([receiveCode_type isEqualToString:@"Code 128"])
        {
            sel_code.text = @"CODE_128";
        }
       else if ([receiveCode_type isEqualToString:@"Code 39"]) {
            
            sel_code.text = @"CODE_39";
        }
        else if ([receiveCode_type isEqualToString:@"EAN13"])
        {
            sel_code.text = @"EAN_13";
        }
        else if ([receiveCode_type isEqualToString:@"EAN8"])
        {
            sel_code.text = @"EAN_8";
        }
        else if ([receiveCode_type isEqualToString:@"QR"]) {
            
            sel_code.text = @"QR_CODE";
        }
        else if ([receiveCode_type isEqualToString:@"UPCE"])
        {
            sel_code.text = @"UPC_E";
        }
        else
        {
        sel_code.text = receiveCode_type;
        }
    }
    
    UIImageView *arrw=[[UIImageView alloc]initWithFrame:CGRectMake(210, 10, 20, 20)];
    arrw.image=[UIImage imageNamed:@"downarrow.png"];
    [sel_code addSubview:arrw];
    
    UITapGestureRecognizer *codetyp_tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sel_type)];
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
    [mainview addSubview:codetable];
    [codetable setHidden:YES];
    
    UIImageView *scanbar=[[UIImageView alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-97/2, 320.0f,98/2)];
    scanbar.image=[UIImage imageNamed:@"scanbar"];
    scanbar.userInteractionEnabled=YES;
    [self.view addSubview:scanbar];
    
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

 //   done_keyboard = [UIButton buttonWithType:UIButtonTypeCustom];
//    [done_keyboard setFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-247, 80, 30)];
//    [done_keyboard setTitle:@"DONE" forState:UIControlStateNormal];
//    [done_keyboard setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [done_keyboard setBackgroundColor:[UIColor whiteColor]];
//    done_keyboard.layer.cornerRadius=5;
//    [done_keyboard addTarget:self action:@selector(done_keyfn:) forControlEvents:UIControlEventTouchUpInside];
//    [mainview addSubview:done_keyboard];
//    [done_keyboard setHidden:YES];

    scan_lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 98/2)];
    scan_lbl.text=@"Cancel";
    scan_lbl.textAlignment=NSTextAlignmentCenter;
    scan_lbl.textColor=[UIColor blackColor];
    scan_lbl.font=[UIFont systemFontOfSize:20.0f];
    [scanbar addSubview:scan_lbl];
    
    UIView *canclvw=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 98/2)];
    canclvw.backgroundColor=[UIColor clearColor];
    [scanbar addSubview:canclvw];

    
    UITapGestureRecognizer *canceltap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel)];
    canceltap.numberOfTapsRequired=1;
    [canclvw addGestureRecognizer:canceltap];
    
    
    
    
    donelb=[[UILabel alloc]initWithFrame:CGRectMake(160, 0, 150, 98/2)];
    donelb.text=@"Done";
    donelb.textAlignment=NSTextAlignmentRight;
    donelb.textColor=[UIColor blackColor];
    donelb.font=[UIFont systemFontOfSize:20.0f];
    [scanbar addSubview:donelb];
    
    
    
    UIView *donevw=[[UIView alloc]initWithFrame:CGRectMake(160, 0, 160, 98/2)];
    donevw.backgroundColor=[UIColor clearColor];
    [scanbar addSubview:donevw];
    
    
    UITapGestureRecognizer *donetap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(donefn)];
    donetap.numberOfTapsRequired=1;
    [donevw addGestureRecognizer:donetap];
    
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
-(void)Crossbuttonfunc:(UIButton *)sender
{
    [BlackEditView setHidden:YES];
    [Labelview setHidden:YES];
}
-(void)securitybutton:(UIButton *)sender
{
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
}
-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    //to stop sliding view
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    }
    
}

//textfield delegate method
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
     [textField resignFirstResponder];
    
    if (textField==locnotxt) {
        mainview.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    }
    mainview.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);

    return YES;
}

-(void)donefn
{

    NSLog(@"add company id==%@",company_id);
    
    NSLog(@"barcode===%@",receiveCode);
    NSLog(@"userid===%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"id"]);
    NSString *userid=[[NSUserDefaults standardUserDefaults]objectForKey:@"id"];
    
    ////////////////////////////////////////
    NSString *urlString1;
    
    NSError *error=nil;
    
  if([code.text isEqualToString:@""])
    {
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter card number"
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
  else if ([sel_code.text isEqualToString:@"Enter code type"])
  {
      
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please select code type"
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
     else{
        
    
    urlString1 =[NSString stringWithFormat:@"%@code_data_insert.php?user_id=%@&code_data=%@&company_id=%@&code_type=%@&card_number=%@&owner_name=%@",APPS_DOMAIN_URL,userid,[code.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],company_id,[sel_code.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[locnotxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[CardOwnerName.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSLog(@"eta holo category:  %@",urlString1);
    
    NSURL *requestURL1 = [NSURL URLWithString:urlString1];
    
    NSData *signeddataURL1 =  [NSData dataWithContentsOfURL:requestURL1 options:NSDataReadingUncached error:&error];
    
   NSString *ret_str = [[NSString alloc] initWithData:signeddataURL1 encoding:NSUTF8StringEncoding];
    

    NSLog(@"dictionary====%@",ret_str);
    /////////////////////////////
    
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"edit_card"]) {
        
        if([ret_str isEqualToString:@"success"])
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Card edited successfully"
                                                            message:@""
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
            
            alert.tag=0;
            [alert show];
        }
        else if ([ret_str isEqualToString:@"already exsits"])
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Card edited successfully"
                                                            message:@""
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
            
            alert.tag=0;
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
        alert.tag=0;
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
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"ok", nil];
        alert.tag=1;
        [alert show];
    
    }
}//not edit code
     }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag==0) {
        if (buttonIndex != [alertView cancelButtonIndex]) {
            NSLog(@"Launching the store");
            //replace appname with any specific name you want
        //    QTCardHomeViewController *cardpg=[[QTCardHomeViewController alloc]init];
            RootViewController *home=[[RootViewController alloc]init];
            [home setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
            [self.navigationController pushViewController:home animated:NO];
            
            
//            [self presentViewController:cardpg animated:YES completion:nil];
    
            
        }

    }
   }
-(void)cancel
{
//    QTHomeViewController *cardpg=[[QTHomeViewController alloc]init];
//    QTAppDelegate *mainDelegate = (QTAppDelegate *)[[UIApplication sharedApplication] delegate];
//    [mainDelegate.navigationController pushViewController:cardpg animated:YES];

    [self.navigationController popViewControllerAnimated:NO];
    
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
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField==code) {
        
        [self performSelector:@selector(delayedfunc) withObject:nil afterDelay:0.4f];
         mainview.frame = CGRectMake(0, -50, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    }
    if (textField==locnotxt) {
        
        [self performSelector:@selector(delayedfunc) withObject:nil afterDelay:0.4f];
        
        mainview.frame = CGRectMake(0, -60, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
        
    }
    if (textField == company || textField == CardOwnerName) {
        
        //[donelb setHidden:YES];
        [done_keyboard setHidden:YES];
        [back_key setHidden:YES];
        
    }
    return YES;
}
-(void)delayedfunc
{
    done_keyboard.hidden=NO;
    back_key.hidden=NO;
    
    [company resignFirstResponder];
}
-(void)done_keyfn:(UIButton*)sender
{
 
    mainview.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    [locnotxt resignFirstResponder];
    [code resignFirstResponder];
    done_keyboard.hidden=YES;
    back_key.hidden=YES;
    
    
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
