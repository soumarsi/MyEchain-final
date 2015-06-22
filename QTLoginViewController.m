//
//  QTLoginViewController.m
//  MyEchain
//
//  Created by maxcon8 on 22/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "QTLoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "QTCardHomeViewController.h"
#import "RootViewController.h"

@interface QTLoginViewController ()
{
NSDictionary *twittdict;
 NSString *emailstring;

}
@end

@implementation QTLoginViewController
@synthesize accountStore,twitterAccount,fblogin_mail;
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
	// Do any additional setup after loading the view.
    
    NSLog(@"QTLoginViewController");
    
    mainview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height )];
    mainview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"1-splashbg-1"]];
    [self.view addSubview:mainview];
    
    UIView *upperview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 128/2)];
    upperview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar"]];
    [mainview addSubview:upperview];
    
    
    UILabel *header=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 320, 50)];
    header.text=@"SIGN IN";
    header.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:18];
    header.textAlignment=NSTextAlignmentCenter;
    [upperview addSubview:header];
    
    UIImageView *back=[[UIImageView alloc]initWithFrame:CGRectMake(15, 30, 23/2, 41/2)];
    back.image=[UIImage imageNamed:@"left-arrow_new"];
    [upperview addSubview:back];
    
    
    UIView *backview=[[UIView alloc]initWithFrame:CGRectMake(0, 15, 60, 45)];
    backview.backgroundColor=[UIColor clearColor];
    [upperview addSubview:backview];
    
    ////////////////////////////////
    UITapGestureRecognizer *back_tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    [backview addGestureRecognizer:back_tap];
    backview.userInteractionEnabled=YES;

    ///////////////////////////////
    
    UILabel *donelb=[[UILabel alloc]initWithFrame:CGRectMake(200, 25, 150, 35)];
    donelb.textAlignment=NSTextAlignmentCenter;
    donelb.backgroundColor=[UIColor clearColor];
    donelb.text=@"DONE";
    donelb.textColor=[UIColor colorWithRed:(15/255.0f) green:(123/255.0f) blue:(255/255.0f) alpha:1];
    [upperview addSubview:donelb];
    
    
    UITapGestureRecognizer *done_tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(done_fn)];
    [donelb addGestureRecognizer:done_tap];
    donelb.userInteractionEnabled=YES;
    
    
    
    //inputfield image for username text
    UIImageView *mail_pas=[[UIImageView alloc]initWithFrame:CGRectMake(0,upperview.frame.origin.y+upperview.frame.size.height , 320, 160/2)];
    mail_pas.image=[UIImage imageNamed:@"email-password-bg"];
    mail_pas.userInteractionEnabled=YES;
    [mainview addSubview:mail_pas];
    
    
    //email textfield
    emailtxt=[[UITextField alloc]initWithFrame:CGRectMake(50,0 , 270, 40)];
    emailtxt.backgroundColor=[UIColor clearColor];
    emailtxt.delegate=self;
    //emailtxt.text=@"arunima@esolzmail.com";
    emailtxt.font= [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:14];
    UIColor *color = [UIColor grayColor];
    emailtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter email address" attributes:@{NSForegroundColorAttributeName: color}];
    emailtxt.textAlignment=NSTextAlignmentLeft;
    emailtxt.delegate=self;
    emailtxt.keyboardType = UIKeyboardTypeEmailAddress;
    [mail_pas addSubview:emailtxt];
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"email"]!=nil) {
        emailtxt.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"email"];
    }
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"loginstat"]isEqualToString:@"fblogin"]|| [[[NSUserDefaults standardUserDefaults]objectForKey:@"loginstat"]isEqualToString:@"twlogin"]) {
        emailtxt.text=fblogin_mail;
    }
    
    
    //password textfield
    passwrdtxt=[[UITextField alloc]initWithFrame:CGRectMake(50,40 , 270, 40)];
    passwrdtxt.backgroundColor=[UIColor clearColor];
    passwrdtxt.delegate=self;
    //passwrdtxt.text=@"123456";
    passwrdtxt.font= [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:14];
    passwrdtxt.placeholder=@"Password";
    UIColor *passcolor = [UIColor grayColor];
    passwrdtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter password" attributes:@{NSForegroundColorAttributeName: passcolor}];
    passwrdtxt.secureTextEntry=YES;
    passwrdtxt.delegate=self;
    passwrdtxt.textAlignment=NSTextAlignmentLeft;
    [mail_pas addSubview:passwrdtxt];
    
    
    NSLog(@"password... ;%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"password"]);
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"password"]!=nil) {
       
         passwrdtxt.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"password"];
    }
      if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"loginstat"]isEqualToString:@"fblogin"]|| [[[NSUserDefaults standardUserDefaults]objectForKey:@"loginstat"]isEqualToString:@"twlogin"]) {
           passwrdtxt.text=@"";
      }
    
    UILabel *forgot=[[UILabel alloc]initWithFrame:CGRectMake(170, mail_pas.frame.origin.y+mail_pas.frame.size.height+15, 150, 25)];
    forgot.text=@"Forgot password?";
    forgot.backgroundColor=[UIColor clearColor];
    forgot.textAlignment=NSTextAlignmentCenter;
    forgot.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:14];
    forgot.textColor=[UIColor whiteColor];
    [mainview addSubview:forgot];
    
    UITapGestureRecognizer *forgot_tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(forgotpass_fn)];
    [forgot addGestureRecognizer:forgot_tap];
    forgot.userInteractionEnabled=YES;
    
    //inputfield image for username text
    UIImageView *orimg=[[UIImageView alloc]initWithFrame:CGRectMake(0,[[UIScreen mainScreen]bounds].size.height/2 , 320, 18/2)];
    orimg.image=[UIImage imageNamed:@"or"];
    orimg.userInteractionEnabled=YES;
    [mainview addSubview:orimg];
    
    
    fb_signin=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    fb_signin.frame=CGRectMake(13, [[UIScreen mainScreen]bounds].size.height /2+50, 587/2, 82/2);
    [fb_signin setBackgroundImage:[UIImage imageNamed:@"fb1"] forState:UIControlStateNormal];
    [fb_signin setBackgroundImage:[UIImage imageNamed:@"fb1"] forState:UIControlStateSelected];
    [fb_signin setBackgroundImage:[UIImage imageNamed:@"fb1"] forState:UIControlStateHighlighted];
    [fb_signin addTarget:self action:@selector(facebook:) forControlEvents:UIControlEventTouchUpInside];
    [mainview addSubview:fb_signin];
    
    twit_signin=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    twit_signin.frame=CGRectMake(13, fb_signin.frame.origin.y+fb_signin.frame.size.height+10,587/2, 82/2);
    [twit_signin setBackgroundImage:[UIImage imageNamed:@"tw1"] forState:UIControlStateNormal];
    [twit_signin setBackgroundImage:[UIImage imageNamed:@"tw1"] forState:UIControlStateSelected];
    [twit_signin setBackgroundImage:[UIImage imageNamed:@"tw1"] forState:UIControlStateHighlighted];
    [twit_signin addTarget:self action:@selector(twitter:) forControlEvents:UIControlEventTouchUpInside];
    [mainview addSubview:twit_signin];
///////////////////////////////////////////
    chkbox = [[UIButton alloc] initWithFrame:CGRectMake(20,[[UIScreen mainScreen]bounds].size.height/2-126,43/2,41/2)];
    chkbox.backgroundColor=[UIColor clearColor];
    [chkbox setBackgroundImage:[UIImage imageNamed:@"uncheck"]forState:UIControlStateNormal];
    [chkbox setBackgroundImage:[UIImage imageNamed:@"check-box"]
                      forState:UIControlStateSelected];
    [chkbox setBackgroundImage:[UIImage imageNamed:@"check-box"]
                      forState:UIControlStateHighlighted];
    chkbox.adjustsImageWhenHighlighted=YES;
    [chkbox addTarget:self action:@selector(chkbox) forControlEvents:UIControlEventTouchUpInside];
    
    [mainview addSubview:chkbox];
    
    /////////////auto on remember me
   
   
    
    
    termBoxSelected = YES;
    [chkbox setSelected:termBoxSelected];
//    [[NSUserDefaults standardUserDefaults] setBool:termBoxSelected forKey:@"remember"];
//    [[NSUserDefaults standardUserDefaults]synchronize];
    
    ////////////////////////////////
    
    
    UIView *termview=[[UIView alloc]initWithFrame:CGRectMake(35, chkbox.frame.origin.y-15, 120, 50)];
    termview.backgroundColor=[UIColor clearColor];
    [mainview addSubview:termview];
    
    
    //terms and conditions textlabel
    UILabel *terms=[[UILabel alloc]initWithFrame:CGRectMake(15,15, 100, 20)];
    terms.backgroundColor=[UIColor clearColor];
    terms.text=@"Remember me";
    terms.textAlignment=NSTextAlignmentLeft;
    terms.font=[UIFont systemFontOfSize:14];
    terms.textColor=[UIColor blackColor];
    [termview addSubview:terms];

    UITapGestureRecognizer *sigin_tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chkbox)];
    [termview addGestureRecognizer:sigin_tap];
    termview.userInteractionEnabled=YES;
    
    imgspin = [[UIImageView alloc] initWithFrame:CGRectMake(110, 180, 100, 100)];
    [imgspin setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.56]];
    // imgspin.backgroundColor=[UIColor blackColor];
    [imgspin setUserInteractionEnabled:NO];
    imgspin.clipsToBounds=YES;
    imgspin.layer.cornerRadius=20;
    [[imgspin layer] setZPosition:2];
    [mainview addSubview:imgspin];
    [imgspin setHidden:YES];
    
    //start loader animation
    
    spinnern = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinnern.hidesWhenStopped = YES;
    spinnern.backgroundColor=[UIColor clearColor];
    
    spinnern.frame=CGRectMake(25,25,50,50);
    [imgspin addSubview: spinnern];
    
    
    //////////////////////////////////////
//    
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"remember"] == 1)
//    {
//        NSString *email = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
//        
//        NSString *password = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
//        
//        emailtxt.text = email;
//        passwrdtxt.text = password;
//        
//        
//    }
//    chkbox.selected=[[NSUserDefaults standardUserDefaults] boolForKey:@"rem"];
//
    //////////////////////////////////////
    [[FHSTwitterEngine sharedEngine]permanentlySetConsumerKey:@"k8YFSF99lPfd0ozfOTtFEaF28" andSecret:@"WGNd5WH1C4dr2zjs80iWwql15cSnikf4tfyijWbUFLOC16nONp"];
    [[FHSTwitterEngine sharedEngine]setDelegate:self];
    [[FHSTwitterEngine sharedEngine]loadAccessToken];
  
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
    UIColor *passcolor1 = [UIColor grayColor];
    locktxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Lock key" attributes:@{NSForegroundColorAttributeName: passcolor1}];
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
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    //checking if remember me is clicked and username and password field not null
    
    //to stop sliding view
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    }
    
    
    
}

-(void)chkbox{
    
    termBoxSelected = !termBoxSelected;
    [chkbox setSelected:termBoxSelected];
//    [[NSUserDefaults standardUserDefaults] setBool:termBoxSelected forKey:@"remember"];
//    [[NSUserDefaults standardUserDefaults]synchronize];
    NSLog(@"rem===%d",  termBoxSelected);
    
    
}
-(void)back
{
//   QTSplashViewController *home=[[QTSplashViewController alloc]init];
//    [self.navigationController pushViewController:home animated:NO];
    
    [self.navigationController popViewControllerAnimated:NO];
   
}
-(void)done_fn
{
    
    
   
    
    [imgspin setHidden:NO];
    [spinnern startAnimating];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // time-consuming task
        dispatch_async(dispatch_get_main_queue(), ^{
//
//            //finally login
//            
    
          
    
            //checking internet availability
            NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.google.com"]];
            result = [[NSString alloc] init];
            result = ( URLString != NULL ) ? @"Yes" : @"No";
            NSLog(@"Internet connection availability : %@", result);
            
            //if internet is not available
            if(URLString == NULL)
            {
                alert = [[UIAlertView alloc]initWithTitle:@"" message:@"No Internet Connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                //[imgspin removeFromSuperview];
                //[spinnern stopAnimating];
                
            }
            
            else
            {
                
                
                NSString *trimmedString = [emailtxt.text stringByTrimmingCharactersInSet:
                                           [NSCharacterSet whitespaceCharacterSet]];
                
                NSString *trimmedString1 = [passwrdtxt.text stringByTrimmingCharactersInSet:
                                            [NSCharacterSet whitespaceCharacterSet]];
                
                //checking all limitations
                if (trimmedString.length <= 0) {
                    
                    
                    alert = [[UIAlertView alloc]initWithTitle:@"" message:@"please enter username" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    
                    alert.tag=0;
                    
                    
                    
                    [alert show];
                    [imgspin removeFromSuperview];
                    [spinnern stopAnimating];
                    
                    
                }
                
                else if (trimmedString1.length <= 0) {
                    
                    
                    
                    
                    
                    
                    alert = [[UIAlertView alloc]initWithTitle:@"" message:@"please enter password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    
                    alert.tag=1;
                    
                    
                    
                    [alert show];
                    [imgspin removeFromSuperview];
                    [spinnern stopAnimating];
                    
                    
                }
                else{
                    
                    
                    
                    NSLog(@"loginnnnn");
                    
                    
                    NSError *error;
                    
                    NSString *urlString = [[NSString alloc] init];
                    
                    
                    json1=[[NSDictionary alloc]init];
                    
                    urlString = [NSString stringWithFormat:@"%@login.php?email=%@&password=%@&device_type=IOS&deviceToken=%@",APPS_DOMAIN_URL,[emailtxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],passwrdtxt.text,[[NSUserDefaults standardUserDefaults]objectForKey:@"deviceToken"]];
                    
                    NSData *dataURL = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                    
                    NSLog(@"dataurl is %@",urlString);
                    
                    json1 = [NSJSONSerialization JSONObjectWithData:dataURL
                                                           options:kNilOptions
                                                             error:&error];
                    
                    
                    
                    
                    NSLog(@"json is %@ ======> %@",json1, (NSString *)[json1 objectForKey:@"auth"]);
                    NSString *userStatus = (NSString *)[json1 objectForKey:@"auth"];
                    
                    
                    if([[NSString stringWithFormat:@"%@", userStatus] isEqualToString:@"failed"]){
                        
                        alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Invalid Username / Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                        passwrdtxt.text=@"";
//                        passwrdtxt.layer.borderColor=[[UIColor redColor]CGColor];
//                        passwrdtxt.layer.borderWidth=1.5f;
                      //  [imgspin removeFromSuperview];
                      //  [spinnern stopAnimating];
                        
                        
                    } else {
                        
                        //if username or password is valid
                        
                        [imgspin setHidden:YES];
                       // [spinnern stopAnimating];
                        
                        
                        
                        defaults=[NSUserDefaults standardUserDefaults];
//                        
//                        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//                        [defaults removePersistentDomainForName:appDomain];
//                        [defaults synchronize];
                        
                        
                        userDetails = [json1 objectForKey:@"userdetails"];
                        
                        
                        
                        
                        NSLog(@"userdetails is %@",userDetails);
                        
                        [defaults setObject:[userDetails objectForKey:@"id"]forKey:@"id"];
                        [defaults setObject:[userDetails objectForKey:@"first_name"]forKey:@"first_name"];
                        [defaults setObject:[userDetails objectForKey:@"last_name"]forKey:@"last_name"];
                        [defaults setObject:[userDetails objectForKey:@"email"]forKey:@"email"];
                        [defaults setObject:[userDetails objectForKey:@"password"]forKey:@"password"];
                        [defaults setObject:[userDetails objectForKey:@"last_sync"]forKey:@"last_sync"];
                        [defaults setObject:[userDetails objectForKey:@"card_count"]forKey:@"card_count"];
                        [defaults setObject:[userDetails objectForKey:@"user_pic_thumb"]forKey:@"user_pic_thumb"];
                         [defaults setObject:nil forKey:@"userimage"];
                        
                       [defaults setBool:YES forKey:@"email_log"];
                        [defaults setBool:termBoxSelected forKey:@"remember"];
                        

                        [defaults synchronize];
                        [self lock_pop];
   
                    }
                }
            }
                });
           // });
    
}
//function to login via facebook
-(void)facebook:(UIButton *)sender
{
     [[NSUserDefaults standardUserDefaults]setBool:termBoxSelected forKey:@"remember"];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"email_log"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    
    [[FBSession activeSession] closeAndClearTokenInformation];
    [[FBSession activeSession] close];
    [FBSession setActiveSession:nil];
    
    [FBSession openActiveSessionWithReadPermissions:@[@"email"]
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session, FBSessionState state, NSError *error)
     {
         if(!error)
         {
             [self sessionStateChanged:session state:state error:error];
         }
         else
         {
             NSLog(@"fberr error is %@",error.localizedDescription);
         }
         
     }];
    
    
    
    
    
}


//checking session state while login via facebook
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
            
            
            
            NSLog(@"FBSessionStateCreated");
            
            
            
            break;
            
            
            
        case FBSessionStateCreatedOpening:
            
            
            
            NSLog(@"FBSessionStateCreatedOpening");
            
            
            
            break;
            
            
            
        case FBSessionStateOpen:
            
            
            
            [self loginToFHviaFB];
            
            
            
            break;
            
            
            
        case FBSessionStateCreatedTokenLoaded:
            
            
            
            NSLog(@"FBSessionStateCreatedTokenLoaded");
            
            
            
            break;
            
            
            
        case FBSessionStateOpenTokenExtended:
            
            
            
            NSLog(@"FBSessionStateOpenTokenExtended");
            
            
            
            break;
            
            
            
        default:
            
            
            
            break;
            
            
            
    }
    
    
    
}


//start to login via fb
-(void)loginToFHviaFB



{
    
    //loader backgroundview
    
    [imgspin setHidden:NO];
    [spinnern startAnimating];
    
    
    
    dispatch_queue_t queue = dispatch_queue_create("com.example.MyQueue", NULL);
    
    dispatch_async(queue, ^{
        
        // Do some computation here.
        
        
        
        // Update UI after computation.
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            
            NSLog(@"%@",[NSString stringWithFormat:@"https://graph.facebook.com/me?access_token=%@",[FBSession activeSession].accessTokenData.accessToken]);
            
            
            
            [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
            
            
            
            AFJSONRequestOperation *operation_fb_first = [AFJSONRequestOperation JSONRequestOperationWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/me?access_token=%@",[FBSession activeSession].accessTokenData.accessToken]]]
                                                          
                                                          
                                                          
                                                          
                                                          
                                                          
                                                          
                                                                                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
                                                          
                                                          
                                                          
                                                          {
                                                              
                                                              
                                                              
                                                              jsonResults = JSON;
                                                              
                                                              
                                                              
                                                              
                                                              
                                                              
                                                              
                                                              NSURL *urlone = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=200&height=200&redirect=false",[jsonResults valueForKey:@"id"]]];
                                                              
                                                              
                                                              
                                                              
                                                              
                                                              AFJSONRequestOperation *operation_fb_second = [AFJSONRequestOperation JSONRequestOperationWithRequest:[NSURLRequest requestWithURL:urlone]
                                                                                                             
                                                                                                             
                                                                                                             
                                                                                                                                                            success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
                                                                                                             
                                                                                                             
                                                                                                             
                                                                                                             {
                                                                                                                 
                                                                                                                 
                                                                                                                 
                                                                                                                 NSDictionary *imageresult = JSON;
                                                                                                                 
                                                                                                                 
                                                                                                                 
                                                                                                                 NSDictionary *picturedata = [imageresult objectForKey:@"data"];
                                                                                                                 
                                                                                                                 
                                                                                                                 
                                                                                        profileimageURL = [picturedata objectForKey:@"url"];
                                                                                                                 
                                                                                                                 
                                                                                                                 
                                                                                                                 NSLog(@" email is %@",[jsonResults objectForKey:@"email"]);
                                                                                                                 
                                                                                                                 
                                                                                                                 
                                                                                                                 NSLog(@"jsonresult is %@",jsonResults);
                                                                                                                 
                                                                                                                 
                                                                                                                 fbemail=[jsonResults objectForKey:@"email"];
                                                                                 
                                                        /////////////////////////popup when fb not returning email
                                                                                                                 
//                                                                                if(fbemail==nil)
//                                                                                                                 {
//                                                                                                                     
//                                                                                                                     
//                                                                                                                     NSLog(@"no email");
//                                                                                                                     
//                                                                                    givemail= [[UIView alloc] initWithFrame:CGRectMake(25,110, 270, 300)];
//                                                                                                                     givemail.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"1-splashbg-1"]];
//                                                                                                                     [self.view addSubview:givemail];
//                                                                                                                     
//                                                                                                                     emailtextfield = [[UITextField alloc]initWithFrame:CGRectMake(15,120, 240, 40)];
//                                                                                                                     [givemail addSubview: emailtextfield];
//                                                                                                                     emailtextfield.delegate =self;
//                                                                                                                     emailtextfield.textAlignment=NSTextAlignmentCenter;
//                                                                                                                     emailtextfield.backgroundColor=[UIColor whiteColor];
//                                                                                                                     emailtextfield.placeholder=@"facebook email address";
//                                                                                                                     
//                                                                                                                     UILabel *twt=[[UILabel alloc]initWithFrame:CGRectMake(25, 60, 320, 50)];
//                                                                                                                     twt.text=@"Enter your facebook email id";
//                                                                                                                     twt.textColor=[UIColor whiteColor];
//                                                                                                                     twt.font=[UIFont systemFontOfSize:18.0f];
//                                                                                                                     [givemail addSubview:twt];
//                                                                                                                     
//                                                                                                                     UIButton *back=[[UIButton alloc]initWithFrame:CGRectMake(105,180, 49.5f, 29.5f)];
//                                                                                                                     [back addTarget:self action:@selector(login_fbmail) forControlEvents:UIControlEventTouchUpInside];
//                                                                                                                     [back setTitle:@"Login" forState:UIControlStateNormal];
//                                                                                                                     
//                                                                                                                     back.backgroundColor=[UIColor clearColor];
//                                                                                                                     back.titleLabel.font=[UIFont systemFontOfSize:18.0f];
//                                                                                                                     back.userInteractionEnabled=YES;
//                                                                                                                     [givemail addSubview:back];
//                                                                                                                     
//                                                                                                                     
//                                                                                                                     
//                                                                                                                 }
//                                                                                                                 
//                                                                                                                 else
//                                                                                                                 {
//                                                                                                                     
//                                                                                                                     [self fbwithemail];
//                                                                                                                     
//                                                                                                                 }
//                                                                                                                 
                                                                                                                 
      [self go_signup];                                                                                                           
                                                                                                                 
                                                                                                                 
                                                                                                                 //                                                                                                         [SVProgressHUD dismiss];
                                                                                                                 
                                                                                                                 
                                                                                                                 
                                                                                                                 
                                                                                                                 
                                                                                                                 
                                                                                                                 
                                                                                                             }
                                                                                                             
                                                                                                             
                                                                                                             
                                                                                                                                                            failure:^(NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON)
                                                                                                             
                                                                                                             
                                                                                                             
                                                                                                             {
                                                                                                                 
                                                                                                                 NSLog(@"Failed: %@",[error localizedDescription]);
                                                                                                                 
                                                                                                                 //
                                                                                                                 
                                                                                                                 
                                                                                                                 
                                                                                                             }];
                                                              
                                                              
                                                              
                                                              [operation_fb_second start];
                                                              
                                                              
                                                              
                                                          }
                                                          
                                                          
                                                          
                                                          
                                                          
                                                          
                                                          
                                                                                                         failure:^(NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON)
                                                          
                                                          
                                                          
                                                          {}];
            
            
            
            [operation_fb_first start];
        });
    });
}

-(void)forgotpass_fn
{

    QTForgotpasswdViewController *forgot=[[QTForgotpasswdViewController alloc]init];
    [self.navigationController pushViewController:forgot animated:NO];


}
-(void)go_signup
{
    
    NSError *error;
    
    NSString *urlString1 =[NSString stringWithFormat:@"%@check_user.php?email=%@&mode=facebook",APPS_DOMAIN_URL,[jsonResults objectForKey:@"email"]];
    
    NSLog(@"checkuser url: %@",urlString1);
    
    NSURL *requestURL1 = [NSURL URLWithString:urlString1];
    
    NSData *signeddataURL1 =  [NSData dataWithContentsOfURL:requestURL1 options:NSDataReadingUncached error:&error];
    
    ret_str = [[NSString alloc] initWithData:signeddataURL1 encoding:NSUTF8StringEncoding];
    NSLog(@"ret checkuser:%@",ret_str);
    
    if ([ret_str rangeOfString:@"YES"].location == NSNotFound) {
        NSLog(@"no check");
        
        [[NSUserDefaults standardUserDefaults]setObject:@"fbsignup" forKey:@"signupstat"];
        
        QTSignupViewController *signup=[[QTSignupViewController alloc]init];
        signup.fb_id=[jsonResults objectForKey:@"id"];
        signup.social_img=profileimageURL;
        
        if ([jsonResults objectForKey:@"email"]!=nil) {
            signup.fbemail=[jsonResults objectForKey:@"email"];
        }
        else
            signup.fbemail=@"";
        
        
        signup.first_name=[jsonResults objectForKey:@"first_name"];
        signup.last_name=[jsonResults objectForKey:@"last_name"];
        [self.navigationController pushViewController:signup animated:NO];
        
        
        
    }
    
    else
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"fblogin" forKey:@"loginstat"];
        
        NSString *myString = ret_str;
        NSArray *myWords = [myString componentsSeparatedByString:@"#"];
        NSLog(@"cut email str===%@",[myWords objectAtIndex:3]);
        existsemail=[myWords objectAtIndex:3];
       
        emailtxt.text=existsemail;
        passwrdtxt.text=@"";
          [imgspin setHidden:YES];
        
//        QTLoginViewController *login=[[QTLoginViewController alloc]init];
//        login.fblogin_mail=existsemail;
//        [self.navigationController pushViewController:login animated:NO];
        NSLog(@"go for login");
        
    }
    
    
    
    
}
-(void)fbwithemail
{
    
    NSString *strurl = [NSString stringWithFormat:@"%@social_login.php?mode=facebook&name=%@&email=%@&facebookid=%@&picurl=%@&device_type=IOS&deviceToken=%@",APPS_DOMAIN_URL,[[jsonResults objectForKey:@"name"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ],[fbemail stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ],[jsonResults objectForKey:@"id"],profileimageURL,[[NSUserDefaults standardUserDefaults]objectForKey:@"deviceToken"]];
    
    
    
    NSLog(@"========%@ url is",strurl);
    
    
    
    NSError *error=nil;
    
    
    
    NSData *signeddataURL = [NSData dataWithContentsOfURL:[NSURL URLWithString:strurl]options:NSDataReadingUncached error:&error];
    
    
    
    json=[[NSMutableArray alloc]init];
    
    json = [NSJSONSerialization JSONObjectWithData:signeddataURL //1
            
                                           options:kNilOptions
            
                                             error:&error];
    
    
    
    
    
    NSLog(@"json has %@",json);
    
    
    
    defaults=[NSUserDefaults standardUserDefaults];
    
    
    
    
    
    
    
    
    
    
    
    userDetails = [[json objectAtIndex:0] objectForKey:@"details"];
    
    
    
    
    
    
    
    [defaults setObject:[[json objectAtIndex:0] objectForKey:@"email"]forKey:@"email"];
    [defaults setObject:[[json objectAtIndex:0] objectForKey:@"last_sync"]forKey:@"last_sync"];
    [defaults setObject:[[json objectAtIndex:0] objectForKey:@"id"]forKey:@"id"];
    [defaults setObject:[[json objectAtIndex:0] objectForKey:@"user_name"]forKey:@"username"];
    [defaults setObject:[[json objectAtIndex:0] objectForKey:@"card_count"]forKey:@"card_count"];
    
  
    
    
    
    
    [defaults setObject:profileimageURL forKey:@"userimage"];
    
    [defaults synchronize];
    [imgspin setHidden:YES];
    [spinnern stopAnimating];
    [givemail setHidden:YES];
    
    [self lock_pop];
    
//    if ( [[json objectAtIndex:0] objectForKey:@"card_count"]==0) {
//        QTHomeViewController *home=[[QTHomeViewController alloc]init];
//        [self.navigationController pushViewController:home animated:NO];
//    }
//    else
//    {
//        
//        QTCardHomeViewController *home=[[QTCardHomeViewController alloc]init];
//        [self.navigationController pushViewController:home animated:NO];
//        
//        
//        
//    }
    
    
    
    
}

-(void)login_fbmail
{
    
    if (![ self NSStringIsValidEmail:emailtextfield.text])
    {
        NSLog(@"1st");
        alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please provide valid Email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag=1;
        
        [alert show];
        
        
    }
    else
    {
        
        fbemail=emailtextfield.text;
        [givemail setHidden:YES];
        [self fbwithemail];
        
    }
    
    
}
//twitter login function
- (void)twitter:(UIButton *)sender{
    
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"email_log"];
    termBoxSelected = NO;
    [chkbox setSelected:termBoxSelected];
    [[NSUserDefaults standardUserDefaults] setBool:termBoxSelected forKey:@"remember"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    [[NSUserDefaults standardUserDefaults]synchronize];
    

    
    [imgspin setHidden:NO];
    [spinnern startAnimating];
    @try {
        
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
        } completion:^(BOOL finished){
            
            if(!accountStore)
                
                accountStore = [[ACAccountStore alloc] init];
            
            ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
            
            [accountStore
             
             requestAccessToAccountsWithType:accountType
             
             options:NULL
             
             completion:^(BOOL granted, NSError *error) {
                 
                 if (granted) {
                     
                     //  Step 2:  Create a request
                     
                     NSArray *accountsArray = [accountStore accountsWithAccountType:accountType];
                     
                     NSLog(@"----> %@", accountsArray);
                     
                     if([accountsArray count]==0)
                     {
                         [imgspin setHidden:YES];
                         [spinnern stopAnimating];
                         
                         alert = [[UIAlertView alloc] initWithTitle:@"Sorry!!!" message:@"Please setup your twitter account" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                         //alert.tag=3;
                         
                         [alert show];
                     }
                     else
                     {
                         self.twitterAccount = [accountsArray objectAtIndex:0];
                         
                         NSLog(@"coming2");
                         
                         // NSString *userID = [[twitterAccount valueForKey:@"properties"] valueForKey:@"user_id"];
                         
                         NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/users/show.json"];
                         
                         NSLog(@"https://api.twitter.com/1.1/users/show.json");
                         
                         NSDictionary *params = @{@"screen_name" : twitterAccount.username
                                                  
                                                  };
                         
                         SLRequest *request =
                         
                         [SLRequest requestForServiceType:SLServiceTypeTwitter
                          
                                            requestMethod:SLRequestMethodGET
                          
                                                      URL:url
                          
                                               parameters:params];
                         
                         //  Attach an account to the request
                         
                         [request setAccount:[accountsArray lastObject]];
                         
                         //  Step 3:  Execute the request
                         
                         [request performRequestWithHandler:^(NSData *responseData,
                                                              
                                                              NSHTTPURLResponse *urlResponse,
                                                              
                                                              NSError *error) {
                             
                             if (responseData) {
                                 
                                 if (urlResponse.statusCode >= 200 && urlResponse.statusCode < 300) {
                                     
                                     NSError* error = nil;
                                     
                                     NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
                                     
                                     NSLog(@" responseData is %@",json);
                                     
                                     [self performSelectorOnMainThread:@selector(twitterdetails:)
                                      
                                                            withObject:responseData waitUntilDone:YES];
                                 } else {
                                     
                                     NSLog(@"The response status code is %ld", (long)urlResponse.statusCode);
                                 }
                             }
                         }];
                     }
                 }
                 else
                 {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         
                         
                         NSLog(@"got no account");
                     });
                 }
             }];
        }];
    }
    @catch (NSException *exception) {
        NSLog(@" Exception here is %@",exception);
    }
}



//function to fetch twitter details
- (void)twitterdetails:(NSData *)responseData {
    NSLog(@"details");
    
    @try {
        NSError* error = nil;
        
        json1 = [NSJSONSerialization
                
                JSONObjectWithData:responseData //1
                
                options:NSJSONReadingAllowFragments
                
                error:&error];
        
        NSLog(@"===details%@",json1);
        
        twittdict = json1;
        
        NSLog(@"1--------------> Came from Twitter");
        
       name = [json1 objectForKey:@"name"];
        
     //   NSString *email = [json1 objectForKey:@"email"];
        
        //    NSString *scrnm = [json objectForKey:@"screen_name"];
        
       twitterid = [json1 objectForKey:@"id"];
        
  prof_img = [json1 objectForKey:@"profile_image_url"];
        
        //   NSString *location = [json objectForKey:@"location"];
        
        NSLog(@"2--------------> Came from Twitter");
        
       profImageBig =[prof_img stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
        
        NSBundle* mainBundle;
        
        mainBundle = [NSBundle mainBundle];
        
        
        //////////////////
        
        NSString *myString = ret_str;
        NSArray *myWords = [myString componentsSeparatedByString:@"#"];
        NSLog(@"cut email str===%@",[myWords objectAtIndex:3]);
        existsemail=[myWords objectAtIndex:3];

        
        //////////////////
        
        
        NSString *urlString1 =[NSString stringWithFormat:@"%@check_user.php?check_user.php?email=%@&mode=twitter",APPS_DOMAIN_URL,existsemail];
        
        NSLog(@"checkuser url: %@",urlString1);
        
        NSURL *requestURL1 = [NSURL URLWithString:urlString1];
        
        NSData *signeddataURL1 =  [NSData dataWithContentsOfURL:requestURL1 options:NSDataReadingUncached error:&error];
        
        ret_str = [[NSString alloc] initWithData:signeddataURL1 encoding:NSUTF8StringEncoding];
        NSLog(@"ret checkuser:%@",ret_str);
        
        if ([ret_str rangeOfString:@"YES"].location == NSNotFound) {
            NSLog(@"no check");
            [[NSUserDefaults standardUserDefaults]setObject:@"twsignup" forKey:@"signupstat"];
            
            QTSignupViewController *signup=[[QTSignupViewController alloc]init];
            signup.tw_id=twitterid;
            signup.social_img=[profImageBig stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            //            if ([jsonResults objectForKey:@"email"]!=nil) {
            //                signup.fbemail=[jsonResults objectForKey:@"email"];
            //            }
            //            else
            signup.fbemail=@"";
            
            
            signup.first_name=name;
            signup.last_name=@"";
            [self.navigationController pushViewController:signup animated:NO];
            

            
//            givemail= [[UIView alloc] initWithFrame:CGRectMake(25,110, 270, 300)];
//            givemail.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"1-splashbg-1"]];
//            [self.view addSubview:givemail];
//            
//            mailtwtrfield = [[UITextField alloc]initWithFrame:CGRectMake(15,120, 240, 40)];
//            [givemail addSubview: mailtwtrfield];
//            mailtwtrfield.delegate =self;
//            mailtwtrfield.textAlignment=NSTextAlignmentCenter;
//            mailtwtrfield.backgroundColor=[UIColor whiteColor];
//            mailtwtrfield.placeholder=@"twitter email address";
//            
//           
//          
//            
//            UILabel *twt=[[UILabel alloc]initWithFrame:CGRectMake(25, 60, 320, 50)];
//            twt.text=@"Enter your twitter email id";
//            twt.textColor=[UIColor whiteColor];
//            twt.font=[UIFont systemFontOfSize:18.0f];
//            [givemail addSubview:twt];
//            
//            UIButton *back=[[UIButton alloc]initWithFrame:CGRectMake(105,180, 49.5f, 29.5f)];
//            [back addTarget:self action:@selector(login_twmail) forControlEvents:UIControlEventTouchUpInside];
//            [back setTitle:@"Login" forState:UIControlStateNormal];
//            
//            back.backgroundColor=[UIColor clearColor];
//            back.titleLabel.font=[UIFont systemFontOfSize:18.0f];
//            back.userInteractionEnabled=YES;
//            [givemail addSubview:back];
//            
//            emailstring=mailtwtrfield.text;
//            chckusrmail=0;
            
        }
        else
        {
            
            
            [[NSUserDefaults standardUserDefaults]setObject:@"twlogin" forKey:@"loginstat"];
            
            NSString *myString = ret_str;
            NSArray *myWords = [myString componentsSeparatedByString:@"#"];
            NSLog(@"cut email str===%@",[myWords objectAtIndex:3]);
            existsemail=[myWords objectAtIndex:3];
            
            emailtxt.text=existsemail;
            passwrdtxt.text=@"";
            
//            QTLoginViewController *login=[[QTLoginViewController alloc]init];
//            login.fblogin_mail=existsemail;
//            [self.navigationController pushViewController:login animated:NO];
            NSLog(@"go for login");
      
            
            
            
            
//            chckusrmail=1;
//         NSLog(@"yes check");
//           
//            NSString *myString = ret_str;
//            NSArray *myWords = [myString componentsSeparatedByString:@"#"];
//            NSLog(@"cut email str===%@",[myWords objectAtIndex:3]);
//            existsemail=[myWords objectAtIndex:3];
//            
//            [self login_twmail];
        }

        }
    
    
    @catch (NSException *exception) {
        
        NSLog(@" Exception %@",exception);
        // [self dismissError:@" There is an issue with your connectivity"];
    }
}
-(void)login_twmail
{
    if (chckusrmail==0) {
        emailstring=[NSString stringWithFormat:@"%@",mailtwtrfield.text];
    }
    else
    {
         emailstring=existsemail;
    }
        
    NSLog(@"email==%@",emailstring);
  NSError *error = Nil;
    
    NSString *strURL = [NSString stringWithFormat:@"%@twitter_login.php?name=%@&email=%@&twitterid=%@&picurl=%@&device_type=IOS&deviceToken=%@",APPS_DOMAIN_URL,[name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[emailstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],twitterid,[profImageBig stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults]objectForKey:@"deviceToken"]];
    
    NSLog(@" url fired %@",strURL);
    
    NSData *signeddataURL =  [NSData dataWithContentsOfURL:[NSURL URLWithString:strURL]options:NSDataReadingUncached error:&error];
    if (error)
    {
        NSLog(@"Error : %@", [error localizedDescription]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@" Kindly check your internet connection");
        });
    }
    else
    {
        
        NSMutableArray *result=[[NSMutableArray alloc]init];
        
        result = [NSJSONSerialization
                  
                  JSONObjectWithData:signeddataURL //1
                  
                  options:kNilOptions
                  
                  error:&error];
        
        NSLog(@"result=======%@",result);
        
        NSLog(@"%@",[[result objectAtIndex:0] objectForKey:@"id"]);
        
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        [prefs setObject:[[result objectAtIndex:0] objectForKey:@"id"] forKey:@"id"];
        [prefs setObject:[[result objectAtIndex:0] objectForKey:@"email"]forKey:@"email"];
        
        
        
        [prefs setObject:[[result objectAtIndex:0] objectForKey:@"last_sync"]forKey:@"last_sync"];
        
        
        
        [prefs setObject:[[result objectAtIndex:0] objectForKey:@"pic_url"] forKey:@"userimage"];
        
        
        [prefs setObject:[[result objectAtIndex:0] objectForKey:@"user_name"]forKey:@"username"];
         [prefs setObject:[[result objectAtIndex:0] objectForKey:@"card_count"]forKey:@"card_count"];
        
        [prefs setObject:[[NSData alloc] initWithContentsOfURL:[[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@",[[result objectAtIndex:0] objectForKey:@"photo"]]]] forKey:@"photo"];
        
        [prefs setObject:@"twitter" forKey:@"logintype"];
        
        if([[result objectAtIndex:0] objectForKey:@"photo"])
        {
            [defaults setObject:[[result objectAtIndex:0] objectForKey:@"photo"]forKey:@"userimage"];
        }
        
        [[NSUserDefaults standardUserDefaults] synchronize];
     
//        if ( [[result objectAtIndex:0] objectForKey:@"card_count"]==0) {
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

       [self lock_pop];  
       
    }
   
}
//function to login via twitter account
-(void)twittersubmit
{
    [mailtwtrfield resignFirstResponder];
    emailstring = mailtwtrfield.text;
    NSError *error = Nil;
    name = [twittdict objectForKey:@"name"];
    
   // NSString *email = [twittdict objectForKey:@"email"];
    
    //    NSString *scrnm = [json objectForKey:@"screen_name"];
    
    twitterid = [twittdict objectForKey:@"id"];
    
  prof_img = [twittdict objectForKey:@"profile_image_url"];
    
    //   NSString *location = [json objectForKey:@"location"];
    
    NSLog(@"2--------------> Came from Twitter");
    
  profImageBig =[prof_img stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
    
    
    
    mainBundle = [NSBundle mainBundle];
    
    
    NSString *strURL = [NSString stringWithFormat:@"%@twitter_login.php?name=%@&email=%@&twitterid=%@&picurl=%@&device_type=IOS&deviceToken=%@",APPS_DOMAIN_URL,[name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[emailstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],twitterid,[profImageBig stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults]objectForKey:@"deviceToken"]];
    
    
    NSLog(@" url fired %@",strURL);
    
    NSData *signeddataURL =  [NSData dataWithContentsOfURL:[NSURL URLWithString:strURL]options:NSDataReadingUncached error:&error];
    if (error)
    {
        NSLog(@"Error : %@", [error localizedDescription]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@" Kindly check your internet connection");
        });
    }
    else
    {
        NSMutableArray *result=[[NSMutableArray alloc]init];
     result = [NSJSONSerialization
                                
                                JSONObjectWithData:signeddataURL //1
                                
                                options:kNilOptions
                                
                                error:&error];
        
        NSLog(@"result=======%@",result);
        
        NSLog(@"%@",[[result objectAtIndex:0] objectForKey:@"id"]);
        
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        [prefs setObject:[[result objectAtIndex:0] objectForKey:@"id"] forKey:@"id"];
        [prefs setObject:[[result objectAtIndex:0] objectForKey:@"email"]forKey:@"email"];
        
        
        
        [prefs setObject:[[result objectAtIndex:0] objectForKey:@"last_sync"]forKey:@"last_sync"];
        
        [prefs setObject:[[result objectAtIndex:0] objectForKey:@"pic_url"] forKey:@"userimage"];

        [prefs setObject:[[result objectAtIndex:0] objectForKey:@"card_count"] forKey:@"card_count"];
        
        
        [prefs setObject:[[result objectAtIndex:0] objectForKey:@"user_name"]forKey:@"username"];
        
        [prefs setObject:[[NSData alloc] initWithContentsOfURL:[[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@",[[result objectAtIndex:0] objectForKey:@"photo"]]]] forKey:@"photo"];
        
        [prefs setObject:@"twitter" forKey:@"logintype"];
        
        if([[result objectAtIndex:0] objectForKey:@"photo"])
        {
            [defaults setObject:[[result objectAtIndex:0] objectForKey:@"photo"]forKey:@"userimage"];
        }
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        if ( [[result objectAtIndex:0] objectForKey:@"card_count"]==0) {
            QTHomeViewController *home=[[QTHomeViewController alloc]init];
            [self.navigationController pushViewController:home animated:NO];
        }
        else
        {
            
            RootViewController *home=[[RootViewController alloc]init];
            [self.navigationController pushViewController:home animated:NO];
            
            
            
        }
        

        
    }
}
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//   
//    if (alertView.tag==5) {
//        
//        if (buttonIndex != [alertView cancelButtonIndex]) {
//            
//            if ([[dialog textFieldAtIndex:0].text isEqualToString:[userDetails objectForKey:@"lock_key"]])
//            {
//                if ([userDetails objectForKey:@"card_count"]==0) {
//                    QTHomeViewController *home=[[QTHomeViewController alloc]init];
//                    [self.navigationController pushViewController:home animated:NO];
//                }
//                else
//                {
//                    
//                    QTCardHomeViewController *home=[[QTCardHomeViewController alloc]init];
//                    [self.navigationController pushViewController:home animated:NO];
//                    
//                    
//                    
//                }
//                
//            }//if lock key match
//            else
//            {
//                
//                UIAlertView *chosseSource = [[UIAlertView alloc] initWithTitle:@"Sorry!!!"
//                                                                       message:@"Lock key not matching"
//                                                                      delegate:self
//                                                             cancelButtonTitle:@"OK"
//                                                             otherButtonTitles:nil, nil];
//                [chosseSource show];
//                
//            }
// 
//            
//            
//            
//        }
//    }
//    
//    
//}


-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
   
    if (buttonIndex==0) {
        
        [imgspin setHidden:YES];
        [spinnern stopAnimating];
        passwrdtxt.layer.borderColor=[[UIColor whiteColor]CGColor];
        passwrdtxt.layer.borderWidth=1.5f;
        
    }
    
    
    
    
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
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"card_count"]==0) {
            QTHomeViewController *home=[[QTHomeViewController alloc]init];
            [self.navigationController pushViewController:home animated:NO];
        }
        else
        {
            
            RootViewController *home=[[RootViewController alloc]init];
            [self.navigationController pushViewController:home animated:NO];
            
            
            
        }
        
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
-(void)lock_pop
{
    
    lockarr=[[NSMutableArray alloc]init];
    NSString *urlString1;
    
    NSError *error=nil;
    
    urlString1 =[NSString stringWithFormat:@"%@get_key.php?userid=%@",APPS_DOMAIN_URL,[[NSUserDefaults standardUserDefaults]objectForKey:@"id"]];  //
    
    NSLog(@"eta holo category:  %@",urlString1);
    
    NSURL *requestURL1 = [NSURL URLWithString:urlString1];
    
    NSData *signeddataURL1 =  [NSData dataWithContentsOfURL:requestURL1 options:NSDataReadingUncached error:&error];
    
    
    
    lockarr = [NSJSONSerialization
                 
                 JSONObjectWithData:signeddataURL1
                 
                 
                 
                 options:kNilOptions
                 
                 error:&error];
   
   

    //if ([[lockarr objectAtIndex:0]objectForKey:@"lock_key"]!=[NSNull null] )
        if ([lockarr count]>0 )

    {
         NSLog(@"lockkey==%@",[[lockarr objectAtIndex:0]objectForKey:@"lock_key"]);
        [[NSUserDefaults standardUserDefaults] setObject:[[lockarr objectAtIndex:0]objectForKey:@"lock_key"]forKey:@"lock_key"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if (![[[lockarr objectAtIndex:0]objectForKey:@"lock_key"]isEqualToString:@"0"]) {
          
            [blackview setHidden:NO];
            [lockview setHidden:NO];
            
            
        }
        else
        {
            
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"card_count"]==0) {
                QTHomeViewController *home=[[QTHomeViewController alloc]init];
                [self.navigationController pushViewController:home animated:NO];
            }
            else
            {
                
                NSLog(@"cardhome");
                
                RootViewController *home=[[RootViewController alloc]init];
                [self.navigationController pushViewController:home animated:NO];
                
            }
            
            
        }
        
    }// lock key if
    else
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"lock_key"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"card_count"]==0) {
            QTHomeViewController *home=[[QTHomeViewController alloc]init];
            [self.navigationController pushViewController:home animated:NO];
        }
        else
        {
            NSLog(@"cardhome");
            
            
            RootViewController *home=[[RootViewController alloc]init];
            [self.navigationController pushViewController:home animated:NO];
            
            
            //navigationController = [[UINavigationController alloc] initWithRootViewController:[[RootViewController alloc] init]];
        }
        
        
        
    }//else lock key


}

//email validation checking
-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
//textfield delegate method
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
