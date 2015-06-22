//
//  QTprofileViewController.m
//  MyEchain
//
//  Created by maxcon8 on 22/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "QTprofileViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "QTSignupViewController.h"
#import "QTSplashViewController.h"
#import "QTcardarr.h"
@interface QTprofileViewController ()
{
    QTfooterTab *footerview;
    NSOperationQueue *MainQueue;
    NSString *ret_str;
}
@end

@implementation QTprofileViewController

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
    
    NSLog(@"QTprofileViewController");
    
    MainQueue = [[NSOperationQueue alloc]init];
    [MainQueue addOperationWithBlock:^{
        
        NSString *urlString1;
        
        urlString1 =[NSString stringWithFormat:@"http://esolz.co.in/lab1/Web/myEchain/Iosapp/pic_url.php?id=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"id"]];
        
        NSError *error;
        
        NSLog(@"eta holo category:  %@",urlString1);
        
        NSURL *requestURL1 = [NSURL URLWithString:urlString1];
        
        NSData *signeddataURL1 =  [NSData dataWithContentsOfURL:requestURL1 options:NSDataReadingUncached error:&error];
        
        ret_str = [[NSString alloc] initWithData:signeddataURL1 encoding:NSUTF8StringEncoding];

        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            chosenImage=nil;
            
            
            
            
            
//            spin_img11 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//            spin_img11.hidesWhenStopped = YES;
//            spin_img11.backgroundColor=[UIColor clearColor];
//            [spin_img11 startAnimating];
//            //spinner1a.center = CGPointMake(160, 240);
//            spin_img11.frame=CGRectMake([[UIScreen mainScreen]bounds].size.width/2-25,[[UIScreen mainScreen]bounds].size.height/2-25,50,50);
//            
//            [mainview addSubview: spin_img11];
            

            profimg=[[UIImageView alloc]initWithFrame:CGRectMake(100, headview.frame.origin.y+headview.frame.size.height+10, 250/2, 250/2)];
            
            NSLog(@"userpicthumb====%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"user_pic_thumb"]);
            NSLog(@"userimggg====%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userimage"]);
            
            
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userimage"]!=nil) {
                
                [profimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userimage"]]] placeholderImage:[UIImage imageNamed:@"placeholder"] options:0 == 0?SDWebImageRefreshCached : 0];
                profimg.layer.cornerRadius=125/2;
                profimg.clipsToBounds=YES;
                
            }
            
            
            
            else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"user_pic_thumb"] length]>0)
            {
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"user_pic_thumb"] containsString:@"http"]) {
                    
                    
                    [profimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"user_pic_thumb"]]] placeholderImage:[UIImage imageNamed:@"placeholder"] options:0 == 0?SDWebImageRefreshCached : 0];
                    
                    
                    
                }
                else
                {
                    // [profimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.esolz.co.in/lab1/Web/myEchain/userimage/thumb/%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"user_pic_thumb"]]] placeholderImage:[UIImage imageNamed:@"placeholder"] options:0 == 0?SDWebImageRefreshCached : 0];
                    
                    
                    // [profimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.esolz.co.in/lab1/Web/myEchain/userimage/thumb/%@",ret_str]] placeholderImage:[UIImage imageNamed:@"placeholder"] options:0 == 0?SDWebImageRefreshCached : 0];
                    
                    profimg.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.esolz.co.in/lab1/Web/myEchain/userimage/thumb/%@",ret_str]]]];
                    
                }
                
                
                NSLog(@"img er url===%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"user_pic_thumb"]);
                profimg.contentMode=UIViewContentModeScaleAspectFill;
                profimg.layer.cornerRadius=125/2;
                profimg.clipsToBounds=YES;
                
            }
            else
            {
                //[self loadImage:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userimage"]] andImageView:profimg];
                
                
                profimg.image=[UIImage imageNamed:@"profile-pic"];
                
            }
            [mainview addSubview:profimg];
            
            
           
           
        }];
        
    }];
    
    // Do any additional setup after loading the view.
    
    
}
-(void)viewDidAppear:(BOOL)animated
{

    [super viewDidAppear:animated];
    
        ////////////////

    
    mainview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height )];
    mainview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"1-splashbg-1"]];
    [self.view addSubview:mainview];
    
    
    headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
    headview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar"]];
    [mainview addSubview:headview];
    
    
    //    UIImageView *headimg=[[UIImageView alloc]initWithFrame:CGRectMake(120, 25, 183/2, 30)];
    //    headimg.image=[UIImage imageNamed:@"topbar-logo"];
    //    [headview addSubview:headimg];
    
    
    UILabel *head_lb=[[UILabel alloc]initWithFrame:CGRectMake(0,30, 320, 29.5f)];
    head_lb.text=@"My Profile";
    head_lb.textAlignment=NSTextAlignmentCenter;
    head_lb.textColor=[UIColor whiteColor];
    head_lb.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:20];
    [headview addSubview:head_lb];

    NSLog(@"userimage===%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userimage"]);
    
    
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"email_log"]) {
        
        UITapGestureRecognizer *click=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapDetected)];
        [profimg setUserInteractionEnabled:YES];
        [profimg addGestureRecognizer:click];
        
        
        NSLog(@"editimage... %f",profimg.frame.origin.y+profimg.frame.size.height);
        
        
        UIImageView *editimg=[[UIImageView alloc]initWithFrame:CGRectMake(215.0f, 190, 48/2, 49/2)];
        editimg.image=[UIImage imageNamed:@"edit"];
        [mainview addSubview:editimg];
        
        //  UITapGestureRecognizer *click1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(edit_profimg)];
        UITapGestureRecognizer *click1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapDetected)];
        [editimg setUserInteractionEnabled:YES];
        [editimg addGestureRecognizer:click1];
        
    }
    
    NSLog(@"first name===%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"first_name"]);
    UILabel *namelb=[[UILabel alloc]initWithFrame:CGRectMake(0, 205+20, 320, 20)];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"first_name"]!=nil && [[NSUserDefaults standardUserDefaults]boolForKey:@"email_log"]) {
        NSString *fulname=[NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults]objectForKey:@"first_name"]uppercaseString],[[[NSUserDefaults standardUserDefaults]objectForKey:@"last_name"]uppercaseString]];
        namelb.text=fulname;
    }
    else
    {
        namelb.text=[[[NSUserDefaults standardUserDefaults]objectForKey:@"username"]uppercaseString];
        
    }
    
    namelb.textColor=[UIColor whiteColor];
    namelb.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:16];
    namelb.textAlignment=NSTextAlignmentCenter;
    [mainview addSubview:namelb];
    
    NSArray* foo = [[[NSUserDefaults standardUserDefaults]objectForKey:@"last_sync"] componentsSeparatedByString: @" "];
    NSString* day = [foo objectAtIndex: 0];
    
    syncdt=[[UILabel alloc]initWithFrame:CGRectMake(0, namelb.frame.origin.y+namelb.frame.size.height+5, 320, 20)];
    if ([day isEqualToString:@"0000-00-00"] ) {
        syncdt.text=@"";
    }
    else
        syncdt.text=[NSString stringWithFormat:@"You last synced on %@",day];
    syncdt.textColor=[UIColor whiteColor];
    syncdt.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:15];
    syncdt.textAlignment=NSTextAlignmentCenter;
    [mainview addSubview:syncdt];
    
    
    
    syncbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    syncbtn.frame=CGRectMake(50, syncdt.frame.origin.y+syncdt.frame.size.height+20,182/2, 182/2);
    [syncbtn setBackgroundImage:[UIImage imageNamed:@"sync1"] forState:UIControlStateNormal];
    [syncbtn setBackgroundImage:[UIImage imageNamed:@"sync1"] forState:UIControlStateSelected];
    [syncbtn setBackgroundImage:[UIImage imageNamed:@"sync1"] forState:UIControlStateHighlighted];
    [syncbtn addTarget:self action:@selector(syncfn) forControlEvents:UIControlEventTouchUpInside];
    [mainview addSubview:syncbtn];
    
    UILabel *synclb=[[UILabel alloc]initWithFrame:CGRectMake(50, syncbtn.frame.origin.y+syncbtn.frame.size.height+10, 182/2, 20)];
    synclb.text=@"SYNC";
    synclb.textAlignment=NSTextAlignmentCenter;
    synclb.textColor=[UIColor whiteColor];
    synclb.font=[UIFont systemFontOfSize:16];
    [mainview addSubview:synclb];
    
    NSLog(@"lock key===%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"lock_key"]);
    
    lockbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    lockbtn.frame=CGRectMake(180, syncdt.frame.origin.y+syncdt.frame.size.height+20,182/2, 182/2);
    
    
    [lockbtn setBackgroundImage:[UIImage imageNamed:@"lock"] forState:UIControlStateNormal];
    [lockbtn setBackgroundImage:[UIImage imageNamed:@"Unlock"] forState:UIControlStateSelected];
    [lockbtn setBackgroundImage:[UIImage imageNamed:@"Unlock"] forState:UIControlStateHighlighted];
    [lockbtn addTarget:self action:@selector(lockfn) forControlEvents:UIControlEventTouchUpInside];
    
    
    [mainview addSubview:lockbtn];
    
    
    unlockbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    unlockbtn.frame=CGRectMake(180, lockbtn.frame.origin.y,182/2, 182/2);
    
    
    [unlockbtn setBackgroundImage:[UIImage imageNamed:@"Unlock"] forState:UIControlStateNormal];
    [unlockbtn setBackgroundImage:[UIImage imageNamed:@"lock"] forState:UIControlStateSelected];
    [unlockbtn setBackgroundImage:[UIImage imageNamed:@"lock"] forState:UIControlStateHighlighted];
    [unlockbtn addTarget:self action:@selector(unlock) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [mainview addSubview:unlockbtn];
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"lock_key"]isEqualToString:@"0"]) {
        
        
        [lockbtn setHidden:NO];
        [unlockbtn setHidden:YES];
        
    }
    else
    {
        [lockbtn setHidden:YES];
        [unlockbtn setHidden:NO];
        
        
    }
    
    
    locklb=[[UILabel alloc]initWithFrame:CGRectMake(180, lockbtn.frame.origin.y+lockbtn.frame.size.height+10, 182/2, 20)];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"lock_key"]isEqualToString:@"0"]) {
        locklb.text=@"LOCK";
    }
    else
        locklb.text=@"UNLOCK";
    locklb.textColor=[UIColor whiteColor];
    locklb.textAlignment=NSTextAlignmentCenter;
    locklb.font=[UIFont systemFontOfSize:16];
    [mainview addSubview:locklb];
    
    
    
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"email_log"]) {
        UIButton *editprof_btn=[[UIButton alloc]initWithFrame:CGRectMake(0,420, 320, 98/2)];
        [editprof_btn setBackgroundImage:[UIImage imageNamed:@"edit-profile-bg"] forState:UIControlStateNormal];
        [editprof_btn setBackgroundImage:[UIImage imageNamed:@"edit-profile-bg"] forState:UIControlStateSelected];
        [editprof_btn setBackgroundImage:[UIImage imageNamed:@"edit-profile-bg"] forState:UIControlStateHighlighted];
        [editprof_btn addTarget:self action:@selector(editprof_fn) forControlEvents:UIControlEventTouchUpInside];
        [mainview addSubview:editprof_btn];
        
        
        
        UILabel *edit_prof=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 300, 30)];
        edit_prof.text=@"Edit Password";
        edit_prof.font=[UIFont systemFontOfSize:16];
        [editprof_btn addSubview:edit_prof];
        
    }
    
    
    /////////////////////////////////////////////////////
    //    UIImageView *logout=[[UIImageView alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-196/2, 320, 98/2)];
    //    logout.image=[UIImage imageNamed:@"edit-profile-bg"];
    //    [mainview addSubview:logout];
    
    UIButton *logout_btn=[[UIButton alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-196/2, 320, 97/2)];
    [logout_btn setBackgroundImage:[UIImage imageNamed:@"edit-profile-bg"] forState:UIControlStateNormal];
    [logout_btn setBackgroundImage:[UIImage imageNamed:@"edit-profile-bg"] forState:UIControlStateSelected];
    [logout_btn setBackgroundImage:[UIImage imageNamed:@"edit-profile-bg"] forState:UIControlStateHighlighted];
    [logout_btn addTarget:self action:@selector(logout_fn) forControlEvents:UIControlEventTouchUpInside];
    [mainview addSubview:logout_btn];
    
    UILabel *logout_lbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 300, 30)];
    logout_lbl.text=@"Sign out";
    logout_lbl.font=[UIFont systemFontOfSize:16];
    [logout_btn addSubview:logout_lbl];
    
    
    
    /////////////////////////////////////////////////////////
    
    //=======footerview
    
    
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"inhome"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    footerview = [[QTfooterTab alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-98/2, 320.0f,98/2)];
    [footerview.profile setSelected:YES];
    [footerview.profile_bg setHidden:NO];
    footerview.profile_bg.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"select-bottombg"]];
    [self.view addSubview:footerview];
    
    [spin_img11 stopAnimating];
    
    //        });
    //    });
    
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
    ///////////////////
    blackview1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    blackview1.backgroundColor=[UIColor blackColor];
    blackview1.alpha=0.5;
    [self.view addSubview:blackview1];
    [blackview1 setHidden:YES];
    
    lockview1 = [[UIView alloc] initWithFrame:CGRectMake(10, 200, 300,150)];
    lockview1.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"1-splashbg-1"]];
    [self.view addSubview:lockview1];
    [lockview1 setHidden:YES];
    
    locktxt1=[[UITextField alloc]initWithFrame:CGRectMake(10,20 , 280, 40)];
    locktxt1.backgroundColor=[UIColor whiteColor];
    locktxt1.delegate=self;
    //passwrdtxt.text=@"123456";
    locktxt1.font= [UIFont systemFontOfSize:16];
    locktxt1.placeholder=@"Lock key";
    UIColor *passcolo1 = [UIColor grayColor];
    locktxt1.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Lock key" attributes:@{NSForegroundColorAttributeName: passcolo1}];
    locktxt1.secureTextEntry=YES;
    locktxt1.delegate=self;
    locktxt1.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    locktxt1.textAlignment=NSTextAlignmentCenter;
    [lockview1 addSubview:locktxt1];
    
    savebtn1=[[UIButton alloc]initWithFrame:CGRectMake(10, locktxt.frame.origin.y+locktxt.frame.size.height+10, 280, 30)];
    savebtn1.backgroundColor=[UIColor whiteColor];
    [savebtn1 setTitle:@"Save" forState:UIControlStateNormal];
    //     [registerbtn setBackgroundImage:[UIImage imageNamed:@"register-nownew.png"] forState:UIControlStateNormal];
    savebtn1.titleLabel.textColor=[UIColor blackColor];
    [savebtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [savebtn1  addTarget:self action:@selector(savelock1) forControlEvents:UIControlEventTouchUpInside];
    [lockview1 addSubview: savebtn1];
    
    cancelbtn1=[[UIButton alloc]initWithFrame:CGRectMake(10, savebtn.frame.origin.y+savebtn.frame.size.height+10, 280, 30)];
    cancelbtn1.backgroundColor=[UIColor whiteColor];
    [cancelbtn1 setTitle:@"Cancel" forState:UIControlStateNormal];
    //     [registerbtn setBackgroundImage:[UIImage imageNamed:@"register-nownew.png"] forState:UIControlStateNormal];
    cancelbtn1.titleLabel.textColor=[UIColor blackColor];
    [cancelbtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelbtn1  addTarget:self action:@selector(cancellock1) forControlEvents:UIControlEventTouchUpInside];
    [lockview1 addSubview:cancelbtn1];
    
    
    spin_img = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spin_img.hidesWhenStopped = YES;
    spin_img.backgroundColor=[UIColor clearColor];
    // [spin_img startAnimating];
    //spinner1a.center = CGPointMake(160, 240);
    spin_img.frame=CGRectMake(15,15,50,50);
    
    [profimg addSubview: spin_img];


}
-(void)edit_profimg
{
   
    NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.google.com"]];
    NSString *result = [[NSString alloc] init];
    result = ( URLString != NULL ) ? @"Yes" : @"No";
    NSLog(@"Internet connection availability : %@", result);
    
    //if internet is not available
    if(URLString == NULL)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"No Internet Connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        //[imgspin removeFromSuperview];
        //[spinnern stopAnimating];
        
    }

 else
     
 {
    if(chosenImage==nil)
    {
        NSLog(@"no img selected");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!!!" message:@"Please select an image" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        //alert.tag=3;
        [alert show];
    }
    else
    {
        
        //        sview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 470)];
        //        sview.backgroundColor = [UIColor clearColor];
        //        sview.userInteractionEnabled=NO;
        //        //mainview.userInteractionEnabled=NO;
        //        [mainview addSubview:sview];
        
        
        
        
        
        dispatch_queue_t queue = dispatch_queue_create("com.example.MyQueue", NULL);
        
        dispatch_async(queue, ^{
            
            // Do some computation here.
            
            
            
            // Update UI after computation.
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSError *error1;
                [spin_img startAnimating];
                NSString *urlString =[NSString stringWithFormat:@"%@update_image.php?id=%@",APPS_DOMAIN_URL,[[NSUserDefaults standardUserDefaults] objectForKey:@"id"]];
                
                NSLog(@"connecting to server....%@",urlString);
                
                
                NSURL *requestURL = [NSURL URLWithString:urlString];
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                NSLog(@" req %@",request);
                [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
                [request setHTTPShouldHandleCookies:NO];
                
                [request setURL:requestURL];
                [request setTimeoutInterval:10];
                [request setHTTPMethod:@"POST"];
                request = [[NSMutableURLRequest alloc] init];
                [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
                [request setHTTPShouldHandleCookies:NO];
                [request setURL:requestURL];
                [request setTimeoutInterval:10];
                [request setHTTPMethod:@"POST"];
                
                if([[NSData dataWithData:UIImageJPEGRepresentation(chosenImage, 1)] length]>0)
                {
                    NSString *boundary = [NSString stringWithFormat:@"%0.9u",arc4random()];
                    
                    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
                    
                    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
                    
                    NSMutableData *body = [NSMutableData data];
                    
                    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userimage\"; filename=\".jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    [body appendData:[NSData dataWithData:UIImageJPEGRepresentation(chosenImage, 1)]];
                    
                    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    [request setHTTPBody:body];
                }
                
                NSURLResponse *response = nil;
                NSError *error;
                NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
                NSLog(@"gggg %@",returnData);
                
                if(error)
                {
                    NSLog(@"Please check your internet connectivity");
                    NSLog(@" %@",error);
                    return ;
                }
                else
                {
                    
                    //
                    //        NSString *ret_str = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
                    //        NSLog(@"ret checkuser:%@",ret_str);
                    
                    
                    json = [NSJSONSerialization JSONObjectWithData:returnData //1
                                                           options:kNilOptions
                                                             error:&error1];
                    
                    NSLog(@"json===%@",json);
                    
                    if(error1)
                    {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Profile not edited" message:[error1 localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                        
                    }
                    else
                    {
                        
                        
                        NSLog(@"json for prof img upload===%@",json);
                        
                        if ([[json objectForKey:@"auth"]isEqualToString:@"success"]) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Profile image edited" message:[error1 localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                            
                            //alert.tag=3;
                            [alert show];
                            [[NSUserDefaults standardUserDefaults]setObject:[json objectForKey:@"user_img"] forKey:@"user_pic_thumb"];
                            [[NSUserDefaults standardUserDefaults]synchronize];
                            
                            
                            MainQueue = [[NSOperationQueue alloc]init];
                            [MainQueue addOperationWithBlock:^{
                                
                                NSString *urlString1;
                                
                                urlString1 =[NSString stringWithFormat:@"http://esolz.co.in/lab1/Web/myEchain/Iosapp/pic_url.php?id=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"id"]];
                                
                                NSError *error;
                                
                                NSLog(@"eta holo category:  %@",urlString1);
                                
                                NSURL *requestURL1 = [NSURL URLWithString:urlString1];
                                
                                NSData *signeddataURL1 =  [NSData dataWithContentsOfURL:requestURL1 options:NSDataReadingUncached error:&error];
                                
                                ret_str = [[NSString alloc] initWithData:signeddataURL1 encoding:NSUTF8StringEncoding];
                                
                                
                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                    
                                    chosenImage=nil;
                                    
                                    
                                    
                                    
                                    
                                    //            spin_img11 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                                    //            spin_img11.hidesWhenStopped = YES;
                                    //            spin_img11.backgroundColor=[UIColor clearColor];
                                    //            [spin_img11 startAnimating];
                                    //            //spinner1a.center = CGPointMake(160, 240);
                                    //            spin_img11.frame=CGRectMake([[UIScreen mainScreen]bounds].size.width/2-25,[[UIScreen mainScreen]bounds].size.height/2-25,50,50);
                                    //
                                    //            [mainview addSubview: spin_img11];
                                    
                                    
                                    profimg=[[UIImageView alloc]initWithFrame:CGRectMake(100, headview.frame.origin.y+headview.frame.size.height+10, 250/2, 250/2)];
                                    
                                    NSLog(@"userpicthumb====%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"user_pic_thumb"]);
                                    NSLog(@"userimggg====%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userimage"]);
                                    
                                    
                                    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userimage"]!=nil) {
                                        
                                        [profimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userimage"]]] placeholderImage:[UIImage imageNamed:@"placeholder"] options:0 == 0?SDWebImageRefreshCached : 0];
                                        profimg.layer.cornerRadius=125/2;
                                        profimg.clipsToBounds=YES;
                                        
                                    }
                                    
                                    
                                    
                                    else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"user_pic_thumb"] length]>0)
                                    {
                                        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"user_pic_thumb"] containsString:@"http"]) {
                                            
                                            
                                            [profimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"user_pic_thumb"]]] placeholderImage:[UIImage imageNamed:@"placeholder"] options:0 == 0?SDWebImageRefreshCached : 0];
                                            
                                            
                                            
                                        }
                                        else
                                        {                                            
                                            profimg.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.esolz.co.in/lab1/Web/myEchain/userimage/thumb/%@",ret_str]]]];
                                            
                                        }
                                        
                                        
                                        NSLog(@"img er url===%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"user_pic_thumb"]);
                                        profimg.contentMode=UIViewContentModeScaleAspectFill;
                                        profimg.layer.cornerRadius=125/2;
                                        profimg.clipsToBounds=YES;
                                        
                                    }
                                    else
                                    {
                                        profimg.image=[UIImage imageNamed:@"profile-pic"];
                                        
                                    }
                                    [mainview addSubview:profimg];
                                    
                                    
                                    
                                    
                                }];
                                
                            }];

                        }
                        
                    }
                    
                }
                
                [spin_img stopAnimating];
            });
        });
    }
     
 }
    
}
-(void)editprof_fn
{
    
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"edit_prof"];
    
    
    QTSignupViewController *signup=[[QTSignupViewController alloc]init];
    [self.navigationController pushViewController:signup animated:NO];
    
}
-(void)logout_fn
{
    
    NSString *lockstr=[[NSUserDefaults standardUserDefaults] stringForKey:@"lock_key"];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"remember"] == 1)
    {
        NSString *email = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
        NSString *password = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
        
        
        
        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:email forKey:@"email"];
        [[NSUserDefaults standardUserDefaults]setObject:password forKey:@"password"];
        //[[NSUserDefaults standardUserDefaults]setObject:lockstr forKey:@"lock_key"];
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"remember"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
    }
    else
    {
        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //         [[NSUserDefaults standardUserDefaults]setObject:lockstr forKey:@"lock_key"];
        //         [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
    
    QTSplashViewController *logout=[[QTSplashViewController alloc]init];
    QTAppDelegate *mainDelegate = (QTAppDelegate *)[[UIApplication sharedApplication] delegate];
    [mainDelegate.navigationController pushViewController:logout animated:YES];
    
    
}
-(void)lockfn
{
    NSLog(@"in lock");
    
    
    
    
    //     dialog = [[UIAlertView alloc] init];
    //    [dialog setDelegate:self];
    //    [dialog setTitle:@"Please Enter Lock code"];
    //    [dialog setMessage:@"Lock code should be 4 characters"];
    //    [dialog addButtonWithTitle:@"Cancel"];
    //    [dialog addButtonWithTitle:@"OK"];
    //    dialog.tag = 5;
    //    dialog.alertViewStyle = UIAlertViewStyleSecureTextInput;
    //    [dialog textFieldAtIndex:0].keyboardType = UIKeyboardTypeDefault;
    //    UIColor *color = [UIColor grayColor];
    //     [dialog textFieldAtIndex:0].attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"****" attributes:@{NSForegroundColorAttributeName: color}];
    //     [dialog textFieldAtIndex:0].textAlignment=NSTextAlignmentCenter;
    //    [dialog textFieldAtIndex:0].delegate=self;
    //    [dialog textFieldAtIndex:0].font=[UIFont systemFontOfSize:16];
    //    [dialog textFieldAtIndex:0].textAlignment=NSTextAlignmentCenter;
    //    [dialog show];
    
    
    [blackview1 setHidden:NO];
    [lockview1 setHidden:NO];
    
}
-(void)syncfn
{
    
    
    NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.google.com"]];
    NSString *result = [[NSString alloc] init];
    result = ( URLString != NULL ) ? @"Yes" : @"No";
    NSLog(@"Internet connection availability : %@", result);
    
    //if internet is not available
    if(URLString == NULL)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"No Internet Connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        //[imgspin removeFromSuperview];
        //[spinnern stopAnimating];
        
    }

    
    else
    {
    
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    //[format setDateFormat:@"MMM dd, yyyy HH:mm"];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *now = [[NSDate alloc] init];
    
    NSString *dateString = [format stringFromDate:now];
    
    //    NSDateFormatter *inFormat = [[NSDateFormatter alloc] init];
    //    [inFormat setDateFormat:@"MMM dd, yyyy"];
    //
    //    NSDate *parsed = [inFormat dateFromString:dateString];
    
    
    NSLog(@"now date====%@",dateString);
    
    
    sview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 470)];
    sview.backgroundColor = [UIColor clearColor];
    sview.userInteractionEnabled=NO;
    //mainview.userInteractionEnabled=NO;
    [mainview addSubview:sview];
    
    
    
    spiner1b = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spiner1b.hidesWhenStopped = YES;
    spiner1b.backgroundColor=[UIColor clearColor];
    [spiner1b startAnimating];
    //spinner1a.center = CGPointMake(160, 240);
    spiner1b.frame=CGRectMake(140,250,50,50);
    
    [sview addSubview: spiner1b];
    
    
    
    dispatch_queue_t queue = dispatch_queue_create("com.example.MyQueue", NULL);
    
    dispatch_async(queue, ^{
        
        // Do some computation here.
        
        
        
        // Update UI after computation.
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            
            //#######################card list
            
            NSError *error;
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
            
            NSString *documentsDirectory = [paths objectAtIndex:0]; //2
            
            NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.plist"]; //3
            
            
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            
            
            
            if (![fileManager fileExistsAtPath: path]) //4
                
            {
                
                NSString *bundle = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"]; //5
                
                
                
                [fileManager copyItemAtPath:bundle toPath: path error:&error]; //6
                
            }
            
            
            
            // [self readdata];
            
            
            
            
            
            [self performSelectorInBackground:@selector(urlfetch) withObject:nil];
            
            
            
            NSString *userid=[[NSUserDefaults standardUserDefaults]objectForKey:@"id"];
            
            NSString *urlString1;
            
            
            urlString1 =[NSString stringWithFormat:@"%@update_time.php?userid=%@&last_sync=%@&last_action=%@",APPS_DOMAIN_URL,userid,[dateString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[dateString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSLog(@"eta holo category:  %@",urlString1);
            
            NSURL *requestURL1 = [NSURL URLWithString:urlString1];
            
            NSData *signeddataURL1 =  [NSData dataWithContentsOfURL:requestURL1 options:NSDataReadingUncached error:&error];
            
            NSString *ret_str = [[NSString alloc] initWithData:signeddataURL1 encoding:NSUTF8StringEncoding];
            
            
            NSLog(@"dictionary====%@",ret_str);
            /////////////////////////////
            if([ret_str isEqualToString:@"success"])
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sync completed"
                                                                message:@""
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"OK", nil];
                
                alert.tag=1000;
                [alert show];
                
                [[NSUserDefaults standardUserDefaults]setObject:dateString forKey:@"last_sync"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                NSArray* foo = [dateString componentsSeparatedByString: @" "];
                NSString* day = [foo objectAtIndex: 0];
                
                syncdt.text=[NSString stringWithFormat:@"You last synced on %@",day];
                
                
            }
            
            else
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!!!"
                                                                message:@"Error occured"
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"OK", nil];
                
                //alert.tag=1000;
                [alert show];
                
            }
            
            
            
            
            
            
            
        });
    });
    //#################################
    
    }
    
    
    [[NSUserDefaults standardUserDefaults]setObject:@"profile" forKey:@"cur_page"];
    //to stop sliding view
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    }
  
    
}

-(void)urlfetch
{
    NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.google.com"]];
    NSString *result = [[NSString alloc] init];
    result = ( URLString != NULL ) ? @"Yes" : @"No";
    NSLog(@"Internet connection availability : %@", result);
    
    //if internet is not available
    if(URLString == NULL)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"No Internet Connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        //[imgspin removeFromSuperview];
        //[spinnern stopAnimating];
        
    }
    else{
    
    con_array=[[NSMutableArray alloc]init];
    NSString *urlString1;
    
    NSError *error=nil;
    
    urlString1 =[NSString stringWithFormat:@"%@company_list.php",APPS_DOMAIN_URL];
    NSLog(@"connecting....%@",urlString1);
    
    NSURL *requestURL1 = [NSURL URLWithString:urlString1];
    
    NSData *signeddataURL1 =  [NSData dataWithContentsOfURL:requestURL1 options:NSDataReadingUncached error:&error];
    
    
    con_array = [NSJSONSerialization
                 
                 JSONObjectWithData:signeddataURL1
                 
                 
                 
                 options:kNilOptions
                 
                 error:&error];
    
    
    QTcardarr *cardobj=[QTcardarr getInstance];
    cardobj.card_arr=con_array;
    
    
    add_contacts_dict =[[NSMutableDictionary alloc]init];
    
    for (int ij =0; ij< [con_array count]; ij++)
    {
        
        // NSString *newString = [[[[con_array objectAtIndex:ij] objectForKey:@"name"] substringToIndex:1] lowercaseString];
        NSString *newString =[[con_array objectAtIndex:ij] objectForKey:@"name"];
        
        NSCharacterSet *strCharSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_"];//1234567890_"];
        
        strCharSet = [strCharSet invertedSet];
        //And you can then use a string method to find if your string contains anything in the inverted set:
        
        NSRange r = [newString rangeOfCharacterFromSet:strCharSet];
        if (r.location != NSNotFound) {
            //            //NSLog(@"the string contains illegal characters");
        }
        else
        {
            if (add_contacts_dict[newString])
            {
                //            //NSLog(@"Exists %@",[add_contacts_dict objectForKey:newString]);
                NSMutableArray *checkarr =[[NSMutableArray alloc]init];
                for (NSDictionary *check in [add_contacts_dict objectForKey:newString] )
                {
                    [checkarr addObject:check];
                }
                [checkarr addObject:[con_array objectAtIndex:ij]];
                NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
                NSArray *sortedArray=[checkarr sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
                
                //            //NSLog(@"checkarray exists: %@",checkarr1);
                [add_contacts_dict removeObjectForKey:newString];
                [add_contacts_dict setObject:sortedArray forKey:newString];
            }
            else
            {
                NSMutableArray *checkarr1 =[[NSMutableArray alloc]init];
                [checkarr1 addObject:[con_array objectAtIndex:ij]];
                //            [add_contacts_dict setObject:[con_array objectAtIndex:ij] forKey:newString];
                [add_contacts_dict setObject:checkarr1 forKey:newString];
            }
            
        }
    }
    
    
    final_con_array= [[NSMutableArray alloc]init];
    for (NSDictionary *dict in add_contacts_dict)
        [final_con_array addObject:dict];
    
    
    // NSLog(@"arrrrry==%@",final_con_array);
    
    
    // [self writedata];
    
    // [self readdata];
    [spiner1b stopAnimating];
    
    
    
    //  [testtable reloadData];
        
    }
    
}
-(void)readdata
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.plist"]; //3
    
    NSMutableArray *savedStock = [[NSMutableArray alloc] initWithContentsOfFile: path];
    NSLog(@"savedStock ===%@",savedStock);
    con_array = [savedStock mutableCopy];
    
    
}
-(void)writedata
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    
    
    
    NSMutableArray *data ;
    
    // if (loadfromwebagain == 0)
    
    data = [con_array mutableCopy];
    
    //  else
    
    //     data= [new_con_array mutableCopy];
    
    
    
    //here add elements to data file and write data to file
    
    
    
    [data writeToFile: path atomically:YES];
    
    
}
-(void)loadImage:(NSString *)url andImageView:(UIImageView *)sentImageView
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:request
                                                                              imageProcessingBlock:nil
                                                                                           success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                                                               
                                                                                               sentImageView.image = image;
                                                                                               
                                                                                           }
                                                                                           failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                                                                               NSLog(@"Error %@",error);
                                                                                           }];
    [operation start];
    
    
}

-(void)tapDetected{
    
    
    UIAlertView *chosseSource = [[UIAlertView alloc] initWithTitle:@" "
                                                           message:@"Please choose photo source!"
                                                          delegate:self
                                                 cancelButtonTitle:@"Cancel"
                                                 otherButtonTitles:@"From Camera",@"From Album", nil];
    [chosseSource show];
    chosseSource.tag=21;
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag==21) {
        
        if(buttonIndex == 1) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:picker animated:YES completion:NULL];
            
        } else if(buttonIndex == 2) {
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentViewController:picker animated:YES completion:NULL];
        }
        
    }
    if (alertView.tag==5) {
        
        if (buttonIndex != [alertView cancelButtonIndex]) {
            
            
            
            
        }
        
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSLog(@"didFinishPickingMediaWithInfo");
    
    chosenImage = info[UIImagePickerControllerEditedImage];
    if(chosenImage == nil)
    {
        chosenImage = info[UIImagePickerControllerOriginalImage];
    }
    profimg.image =chosenImage;
    
    
    NSData *imageData = UIImagePNGRepresentation(profimg.image);
    imageString = [[NSString alloc] initWithBytes: [imageData bytes] length:[imageData length] encoding:NSUTF8StringEncoding];
    profimg.layer.cornerRadius=125/2;
    profimg.clipsToBounds=YES;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    [self edit_profimg];
    
}




-(void)cancellock1
{
    [blackview1 setHidden:YES];
    [lockview1 setHidden:YES];
    
}
-(void)savelock1
{
    NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.google.com"]];
    NSString *result = [[NSString alloc] init];
    result = ( URLString != NULL ) ? @"Yes" : @"No";
    NSLog(@"Internet connection availability : %@", result);
    
    //if internet is not available
    if(URLString == NULL)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"No Internet Connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        //[imgspin removeFromSuperview];
        //[spinnern stopAnimating];
        
    }
    else{
    
    if ([locktxt1.text length]<4) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!!!"
                                                        message:@"lock code must be of 4 characters"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
        [alert show];
        
    }
    else
    {
        //valid lock key
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Saving your lock key" message:@"please wait..." delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
        [alert show];
        
        
        NSString *urlString1;
        
        NSError *error=nil;
        
        NSString *userid=[[NSUserDefaults standardUserDefaults]objectForKey:@"id"];
        urlString1 =[NSString stringWithFormat:@"%@key_details.php?userid=%@&lock_key=%@",APPS_DOMAIN_URL,userid,locktxt1.text];  //
        
        NSLog(@"eta holo category:  %@",urlString1);
        
        NSURL *requestURL1 = [NSURL URLWithString:urlString1];
        
        NSData *signeddataURL1 =  [NSData dataWithContentsOfURL:requestURL1 options:NSDataReadingUncached error:&error];
        
        NSString *ret_str = [[NSString alloc] initWithData:signeddataURL1 encoding:NSUTF8StringEncoding];
        
        
        NSLog(@"dictionary====%@",ret_str);
        /////////////////////////////
        if([ret_str isEqualToString:@"success"])
        {
            [[NSUserDefaults standardUserDefaults] setObject:locktxt1.text forKey:@"lock_key"];
            
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            locklb.text=@"UNLOCK";
            //                    //[lockbtn setSelected:YES];
            //                    [lockbtn addTarget:self action:@selector(unlock) forControlEvents:UIControlEventTouchUpInside];
            [lockbtn setHidden:YES];
            [unlockbtn setHidden:NO];
            
            [alert dismissWithClickedButtonIndex:0 animated:YES];
            // [dialog setHidden:YES];
            NSLog(@"Lock is set");
            
            
            [blackview1 setHidden:YES];
            [lockview1 setHidden:YES];
        }
        
    }//else valid lock key
    
    }
}
    
-(void)unlock
{
  
    
    NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.google.com"]];
    NSString *result = [[NSString alloc] init];
    result = ( URLString != NULL ) ? @"Yes" : @"No";
    NSLog(@"Internet connection availability : %@", result);
    
    //if internet is not available
    if(URLString == NULL)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"No Internet Connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        //[imgspin removeFromSuperview];
        //[spinnern stopAnimating];
        
    }
else
{
    
    
    NSLog(@"in unlock");
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unlocking key" message:@"please wait..." delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [alert show];
    
    
    NSString *urlString1;
    
    NSError *error=nil;
    
    NSString *userid=[[NSUserDefaults standardUserDefaults]objectForKey:@"id"];
    urlString1 =[NSString stringWithFormat:@"%@key_details.php?userid=%@&lock_key=0",APPS_DOMAIN_URL,userid];  //
    
    NSLog(@"eta holo category:  %@",urlString1);
    
    NSURL *requestURL1 = [NSURL URLWithString:urlString1];
    
    NSData *signeddataURL1 =  [NSData dataWithContentsOfURL:requestURL1 options:NSDataReadingUncached error:&error];
    
    NSString *ret_str = [[NSString alloc] initWithData:signeddataURL1 encoding:NSUTF8StringEncoding];
    
    
    NSLog(@"dictionary====%@",ret_str);
    /////////////////////////////
    if([ret_str isEqualToString:@"success"])
    {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"lock_key"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        locklb.text=@"LOCK";
        //        [lockbtn setSelected:YES];
        //        [lockbtn addTarget:self action:@selector(lockfn) forControlEvents:UIControlEventTouchUpInside];
        //        [lockbtn setBackgroundImage:[UIImage imageNamed:@"lock"] forState:UIControlStateNormal];
        //        [lockbtn setBackgroundImage:[UIImage imageNamed:@"lock"] forState:UIControlStateSelected];
        //        [lockbtn setBackgroundImage:[UIImage imageNamed:@"lock"] forState:UIControlStateHighlighted];
        //        [lockbtn addTarget:self action:@selector(lockfn) forControlEvents:UIControlEventTouchUpInside];
        [lockbtn setHidden:NO];
        [unlockbtn setHidden:YES];
        
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        NSLog(@"unLock is set");
    }
}
    
}
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    NSLog(@"image e asche");
//
//    chosenImage = info[UIImagePickerControllerEditedImage];
//    if(chosenImage == nil)
//    {
//        chosenImage = info[UIImagePickerControllerOriginalImage];
//    }
//    profimg.image =chosenImage;
//    NSLog(@"%@ image",profimg.image);
//
//    NSData *imageData = UIImagePNGRepresentation(profimg.image);
//    imageString = [[NSString alloc] initWithBytes: [imageData bytes] length:[imageData length] encoding:NSUTF8StringEncoding];
//    NSLog(@"%@ image1",imageString);
//    profimg.layer.cornerRadius=125/2;
//    profimg.clipsToBounds=YES;
//
//    [picker dismissViewControllerAnimated:YES completion:NULL];
//
//
//
//}
//textfield delegate method
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    // if (textField==[dialog textFieldAtIndex:0])
    if (textField==locktxt1)
    {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 4) ? NO : YES;
        
    }
    
    else
        return YES;
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
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
