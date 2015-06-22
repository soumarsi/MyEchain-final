//
//  QTSignupViewController.m
//  MyEchain
//
//  Created by maxcon8 on 22/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "QTSignupViewController.h"

@interface QTSignupViewController ()

@end

@implementation QTSignupViewController
@synthesize fbemail,first_name,last_name,fb_id,tw_id,social_img;

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
    
    NSLog(@"QTSignupViewController");
    
    NSLog(@"sign up status is====%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"signupstat"]);
    
    mainview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height )];
    mainview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"1-splashbg-1"]];
    [self.view addSubview:mainview];
    
    UIView *upperview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 128/2)];
    upperview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar"]];
    [mainview addSubview:upperview];
    
    
    UILabel *header=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 320, 50)];
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"edit_prof"]) {
        header.text=@"EDIT PASSWORD";
    }
    else
    header.text=@"SIGN UP";
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
    
    
    
    UIButton *done=[[UIButton alloc]initWithFrame:CGRectMake(250, 25,67, 30)];
    done.backgroundColor=[UIColor clearColor];
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"edit_prof"]) {
   
         [done addTarget:self action:@selector(edit_proffn) forControlEvents:UIControlEventTouchUpInside];
        
    }
    else
    {
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"term"];
    
     [done addTarget:self action:@selector(sign_up) forControlEvents:UIControlEventTouchUpInside];
    
    }
    [upperview addSubview:done];
    
    UILabel *donelbl=[[UILabel alloc]initWithFrame:CGRectMake(247, 25,67, 30)];
    donelbl.text=@"DONE";
    donelbl.textAlignment=NSTextAlignmentCenter;
    //donelbl.textColor=[UIColor colorWithRed:(22.0f/255.0f) green:(187.0f/255.0f) blue:(238.0f/255.0f) alpha:1];
    donelbl.textColor=[UIColor colorWithRed:(15/255.0f) green:(123/255.0f) blue:(255/255.0f) alpha:1];
    donelbl.font=[UIFont systemFontOfSize:18.0f];
    [upperview addSubview:donelbl];
    
    
    
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"edit_prof"]) {
        
        
    
    //inputfield image for username text
    UIImageView *mail=[[UIImageView alloc]initWithFrame:CGRectMake(0,upperview.frame.origin.y+upperview.frame.size.height, 640/2,79/2)];
    mail.image=[UIImage imageNamed:@"newemail.png"];
    mail.userInteractionEnabled=YES;
    [mainview addSubview:mail];
    
    mailtxt=[[UITextField alloc]initWithFrame:CGRectMake(50,0 , 270, 40)];
    mailtxt.backgroundColor=[UIColor clearColor];
    mailtxt.delegate=self;
    mailtxt.font= [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:14];
    UIColor *passcolor2 = [UIColor grayColor];
    mailtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter email address" attributes:@{NSForegroundColorAttributeName: passcolor2}];
    mailtxt.delegate=self;
    mailtxt.keyboardType = UIKeyboardTypeEmailAddress;
    mailtxt.textAlignment=NSTextAlignmentLeft;
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"edit_prof"]) {
        NSLog(@"edit profile mail====%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"email"]);
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"email"]!=nil) {
            if ([[NSUserDefaults standardUserDefaults]objectForKey:@"email"]!=[NSNull null]) {
                
                  mailtxt.text=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"email"]];
            }
          else
          {
          
          mailtxt.text=@"";
          
          }
        }
      
    }
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"signupstat"]isEqualToString:@"fbsignup"] || [[[NSUserDefaults standardUserDefaults]objectForKey:@"signupstat"]isEqualToString:@"twsignup"] ) {
        mailtxt.text=[NSString stringWithFormat:@"%@",fbemail];
    }

    [mail addSubview:mailtxt];
    
}
    
    ////////////////////////////
     if ([[NSUserDefaults standardUserDefaults]boolForKey:@"edit_prof"]) {
   password_img=[[UIImageView alloc]initWithFrame:CGRectMake(0,upperview.frame.origin.y+upperview.frame.size.height , 640/2,79/2)];
    password_img.image=[UIImage imageNamed:@"password.png"];
    password_img.userInteractionEnabled=YES;
    [mainview addSubview:password_img];
     }
    else
    {
       password_img=[[UIImageView alloc]initWithFrame:CGRectMake(0,upperview.frame.origin.y+upperview.frame.size.height +80/2, 640/2,79/2)];
        password_img.image=[UIImage imageNamed:@"password.png"];
        password_img.userInteractionEnabled=YES;
        [mainview addSubview:password_img];
    
    }
    
    //password textfield
    passwrdtxt=[[UITextField alloc]initWithFrame:CGRectMake(50,0 , 270, 40)];
    passwrdtxt.backgroundColor=[UIColor clearColor];
    passwrdtxt.delegate=self;
    passwrdtxt.font= [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:14];
    UIColor *passcolor = [UIColor grayColor];
    passwrdtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Desired password" attributes:@{NSForegroundColorAttributeName: passcolor}];
    passwrdtxt.secureTextEntry=YES;
    passwrdtxt.delegate=self;
    passwrdtxt.textAlignment=NSTextAlignmentLeft;
//    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"edit_prof"]) {
//        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"password"]!=nil) {
//    passwrdtxt.text=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"password"]];
//        }
//  
//    }

    [password_img addSubview:passwrdtxt];
    ////////////////////////////////
    
    UIImageView *rep_password=[[UIImageView alloc]initWithFrame:CGRectMake(0,password_img.frame.origin.y+password_img.frame.size.height+1, 640/2,79/2)];
    rep_password.image=[UIImage imageNamed:@"password2.png"];
    rep_password.userInteractionEnabled=YES;
    [mainview addSubview:rep_password];

    //repeat passwd textfield
    rep_passwrdtxt=[[UITextField alloc]initWithFrame:CGRectMake(50,0 , 270, 40)];
    rep_passwrdtxt.backgroundColor=[UIColor clearColor];
    rep_passwrdtxt.delegate=self;
    rep_passwrdtxt.font= [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:14];
    UIColor *passcolor1 = [UIColor grayColor];
    rep_passwrdtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Repeat password" attributes:@{NSForegroundColorAttributeName: passcolor1}];
    rep_passwrdtxt.secureTextEntry=YES;
    rep_passwrdtxt.delegate=self;
    rep_passwrdtxt.textAlignment=NSTextAlignmentLeft;
//    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"edit_prof"]) {
//        
//         if ([[NSUserDefaults standardUserDefaults]objectForKey:@"password"]!=nil) {
//rep_passwrdtxt.text=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"password"]];
//             
//    }
//    }
    [rep_password addSubview:rep_passwrdtxt];
   
    
     if (![[NSUserDefaults standardUserDefaults]boolForKey:@"edit_prof"]) {
    
    ///////////////////////////////////////////
    UIImageView *fname=[[UIImageView alloc]initWithFrame:CGRectMake(0,rep_password.frame.origin.y+rep_password.frame.size.height+1, 640/2,79/2)];
    fname.image=[UIImage imageNamed:@"fullname.png"];
    fname.userInteractionEnabled=YES;
    [mainview addSubview:fname];
    
    //name textfield
    fstnametxt=[[UITextField alloc]initWithFrame:CGRectMake(50,0 , 270, 40)];
    fstnametxt.backgroundColor=[UIColor clearColor];
    fstnametxt.delegate=self;
    fstnametxt.font= [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:14];
    UIColor *color1 = [UIColor grayColor];
    fstnametxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"First name" attributes:@{NSForegroundColorAttributeName: color1}];
    fstnametxt.textAlignment=NSTextAlignmentLeft;
    fstnametxt.delegate=self;
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"edit_prof"]) {
        fstnametxt.text=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"first_name"]];
    }
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"signupstat"]isEqualToString:@"fbsignup"]|| [[[NSUserDefaults standardUserDefaults]objectForKey:@"signupstat"]isEqualToString:@"twsignup"]) {
        
         if (first_name!=nil) {
         fstnametxt.text=[NSString stringWithFormat:@"%@",first_name];
         }
    }
    [fname addSubview:fstnametxt];
    
    /////////////////////////////////////
    UIImageView *lname=[[UIImageView alloc]initWithFrame:CGRectMake(0,fname.frame.origin.y+fname.frame.size.height+1, 640/2,79/2)];
    lname.image=[UIImage imageNamed:@"fullname.png"];
    lname.userInteractionEnabled=YES;
    [mainview addSubview:lname];
    

    lstname=[[UITextField alloc]initWithFrame:CGRectMake(50,0 , 270, 40)];
    lstname.backgroundColor=[UIColor clearColor];
    lstname.delegate=self;
    lstname.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:14];
    UIColor *color2 = [UIColor grayColor];
    lstname
    .attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Last name" attributes:@{NSForegroundColorAttributeName: color2}];
    lstname.textAlignment=NSTextAlignmentLeft;
    lstname.delegate=self;
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"edit_prof"]) {
        lstname.text=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"last_name"]];
    }
       if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"signupstat"]isEqualToString:@"fbsignup"]|| [[[NSUserDefaults standardUserDefaults]objectForKey:@"signupstat"]isEqualToString:@"twsignup"]) {
           
            if (last_name!=nil) {
           lstname.text=[NSString stringWithFormat:@"%@",last_name];
            }
       }
    [lname addSubview:lstname];

         
}
         
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"edit_prof"]) {
    //checkbox for terms and conditions
    chkbox = [[UIButton alloc] initWithFrame:CGRectMake(20,[[UIScreen mainScreen]bounds].size.height/2 ,43/2,41/2)];
    chkbox.backgroundColor=[UIColor clearColor];
    [chkbox setBackgroundImage:[UIImage imageNamed:@"uncheck"]forState:UIControlStateNormal];
    [chkbox setBackgroundImage:[UIImage imageNamed:@"check-box"]
                      forState:UIControlStateSelected];
    [chkbox setBackgroundImage:[UIImage imageNamed:@"check-box"]
                      forState:UIControlStateHighlighted];
    chkbox.adjustsImageWhenHighlighted=YES;
    [chkbox addTarget:self action:@selector(chkbox) forControlEvents:UIControlEventTouchUpInside];
    [mainview addSubview:chkbox];
    
    
    UIView *termview=[[UIView alloc]initWithFrame:CGRectMake(35, chkbox.frame.origin.y-15, 260, 50)];
    termview.backgroundColor=[UIColor clearColor];
    [mainview addSubview:termview];
    
    
    //terms and conditions textlabel
    UILabel *terms=[[UILabel alloc]initWithFrame:CGRectMake(15,18, 100, 20)];
    terms.backgroundColor=[UIColor clearColor];
    terms.text=@"I agree to the";
    terms.textAlignment=NSTextAlignmentLeft;
    terms.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:15];
    terms.textColor=[UIColor blackColor];
    [termview addSubview:terms];
    
    //terms and conditions textlabel
    UILabel *termscon=[[UILabel alloc]initWithFrame:CGRectMake(110,18, 170, 20)];
    termscon.backgroundColor=[UIColor clearColor];
    termscon.text=@"terms and conditions";
    termscon.textAlignment=NSTextAlignmentLeft;
    termscon.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:15];
    termscon.textColor=[UIColor blackColor];
    [termview addSubview:termscon];
    
    
    UITapGestureRecognizer *gesterm=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chkbox)];
    [termview addGestureRecognizer:gesterm];
    termview.userInteractionEnabled=YES;
    
    
    
    UILabel *alredy=[[UILabel alloc]initWithFrame:CGRectMake(25,[[UIScreen mainScreen]bounds].size.height-60, 180, 20)];
    alredy.text=@"Already have an account?";
    alredy.font=[UIFont systemFontOfSize:15];
    alredy.textColor=[UIColor whiteColor];
    [mainview addSubview:alredy];
    
    
    UILabel *signin=[[UILabel alloc]initWithFrame:CGRectMake(210, alredy.frame.origin.y, 250, 20)];
    signin.text=@"Sign in Now";
    signin.font=[UIFont boldSystemFontOfSize:15];
    signin.textColor=[UIColor whiteColor];
    [mainview addSubview:signin];
    
    UITapGestureRecognizer *sigin_tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sigin_tap)];
    [signin addGestureRecognizer:sigin_tap];
    signin.userInteractionEnabled=YES;
    

    }
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    //checking if remember me is clicked and username and password field not null
    
    //to stop sliding view
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    }
    
    
    
}
//function to select textbox of terms and conditions
-(void)chkbox{
    
    termBoxSelected = !termBoxSelected;
    [chkbox setSelected:termBoxSelected];
    [[NSUserDefaults standardUserDefaults] setBool:termBoxSelected forKey:@"term"];
    
    
    
    
}
-(void)sigin_tap
{
    
    QTLoginViewController *login=[[QTLoginViewController alloc]init];
    [self.navigationController pushViewController:login animated:NO];
    
    
}
-(void)edit_proffn
{
    
    NSLog(@"edit profile");
    
   // NSString *check = mailtxt.text;
    //NSRange whiteSpaceRange = [check rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
//    if ([lstname.text isEqualToString:@""]  && [fstnametxt.text isEqualToString:@""]  && [mailtxt.text isEqualToString:@""] &&[passwrdtxt.text isEqualToString:@""] &&[rep_passwrdtxt.text isEqualToString:@""]) {
    
    
      if ([passwrdtxt.text isEqualToString:@""] &&[rep_passwrdtxt.text isEqualToString:@""]) {
    
    
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:Nil message:@"All Required Inputs Are Left Blank ...!   Please input something" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag=0;
        
        [alert show];
        
    }
    
    else if ([passwrdtxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ].length < 1){
        
        UIAlertView *alert  = [[UIAlertView alloc]initWithTitle:@"" message:@"Desired Password cannot be blank" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        
    }
    else if ([rep_passwrdtxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ].length < 1){
        
        UIAlertView *alert  = [[UIAlertView alloc]initWithTitle:@"" message:@"Repeat Password cannot be blank" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        
    }
    
//    else if ([mailtxt.text isEqualToString:@""] && ( [passwrdtxt.text isEqualToString:@""] ||[rep_passwrdtxt.text isEqualToString:@""]||[fstnametxt.text isEqualToString:@""]||[lstname.text isEqualToString:@""]) ) {
//        
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please enter email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        alert.tag=1;
//        
//        [alert show];
//    }
  
    
//    else if (whiteSpaceRange.location != NSNotFound)
//    {
//        NSLog(@"Found whitespace");
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please omit whitespace in email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        alert.tag=1;
//        
//        [alert show];
//        
//    }
//    else if (![ self NSStringIsValidEmail:mailtxt.text])
//    {
//        
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please provide valid Email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        alert.tag=1;
//        
//        [alert show];
//        
//        
//    }
//    
    
    else if ([passwrdtxt.text isEqualToString:@""] &&[rep_passwrdtxt.text isEqualToString:@""]) {
        
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please enter Desired Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag=1;
        
        [alert show];
    }
    else if ([rep_passwrdtxt.text isEqualToString:@""]  ) {
        
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please enter confirm password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag=1;
        
        [alert show];
    }
    else if (![passwrdtxt.text isEqualToString:rep_passwrdtxt.text]) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please repeat password correctly" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag=1;
        
        [alert show];
    }
    else if ([passwrdtxt.text length]< 6) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Password should be atleast 6 characters" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag=1;
        
        [alert show];
        return;
    }
   
    else
    {
        
        NSError *error1;
//        NSString *urlString1 =[NSString stringWithFormat:@"%@update_profile.php?first_name=%@&last_name=%@&password=%@&email=%@&userid=%@",APPS_DOMAIN_URL,[fstnametxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[lstname.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ],[passwrdtxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ],[mailtxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults]objectForKey:@"id"]];
        
        NSString *urlString1 =[NSString stringWithFormat:@"%@update_profile.php?password=%@&userid=%@",APPS_DOMAIN_URL,[passwrdtxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ],[[NSUserDefaults standardUserDefaults]objectForKey:@"id"]];

        
        
        
        NSLog(@" %@",urlString1);
        
        NSString *frstname=[fstnametxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *lastnm=[lstname.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
        NSString *passwd=[passwrdtxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
        NSString *mailstr=[mailtxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *idstr=[[NSUserDefaults standardUserDefaults]objectForKey:@"id"];
        
        NSLog(@"eta holo category:  %@",urlString1);
        
        NSURL *requestURL1 = [NSURL URLWithString:urlString1];
        
        NSData *signeddataURL1 =  [NSData dataWithContentsOfURL:requestURL1 options:NSDataReadingUncached error:&error1];
        
        NSString *ret_str = [[NSString alloc] initWithData:signeddataURL1 encoding:NSUTF8StringEncoding];
        
        
        NSLog(@"dictionary====%@",ret_str);
        /////////////////////////////
        if([ret_str isEqualToString:@"success"])
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Profile edited successfully"
                                                            message:@""
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
            [alert show];
            
           // NSDictionary *detdict=[json objectForKey:@"User_Details"];
            
            
            
            [[NSUserDefaults standardUserDefaults] setObject:frstname forKey:@"first_name"];
            [[NSUserDefaults standardUserDefaults] setObject:lastnm forKey:@"last_name"];
            [[NSUserDefaults standardUserDefaults] setObject:passwd forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] setObject:mailstr forKey:@"email"];
             [[NSUserDefaults standardUserDefaults] setObject:idstr forKey:@"id"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            
            QTHomeViewController *home=[[QTHomeViewController alloc]init];
            [self.navigationController pushViewController:home animated:YES];
            

            
        }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Profile cannot be edited"
                                                                message:@""
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"OK", nil];
                [alert show];
                

                
            }
          }
        }
        

-(void)sign_up
{
   
    

      NSLog(@"terms=====%d",[[NSUserDefaults standardUserDefaults] boolForKey:@"term"]);
    NSString *check = mailtxt.text;
    NSRange whiteSpaceRange = [check rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    if ([lstname.text isEqualToString:@""]  && [fstnametxt.text isEqualToString:@""]  && [mailtxt.text isEqualToString:@""] &&[passwrdtxt.text isEqualToString:@""] &&[rep_passwrdtxt.text isEqualToString:@""]) {
       
        
     UIAlertView *alert = [[UIAlertView alloc]initWithTitle:Nil message:@"All Required Inputs Are Left Blank ...!   Please input something" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag=0;
        
        [alert show];
        
    }
    else if ([mailtxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ].length < 1){
        
        UIAlertView *alert  = [[UIAlertView alloc]initWithTitle:@"" message:@"Email cannot be blank" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        
    }
    else if ([fstnametxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ].length < 1){
        
       UIAlertView *alert  = [[UIAlertView alloc]initWithTitle:@"" message:@"First name cannot be blank" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        
    }
    else if ([lstname.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ].length < 1){
        
        UIAlertView *alert  = [[UIAlertView alloc]initWithTitle:@"" message:@"Last name cannot be blank" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        
    }

    else if ([passwrdtxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ].length < 1){
        
     UIAlertView *alert  = [[UIAlertView alloc]initWithTitle:@"" message:@"Desired Password cannot be blank" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        
    }
//    else if ([rep_passwrdtxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ].length < 1){
//        
//    UIAlertView *alert  = [[UIAlertView alloc]initWithTitle:@"" message:@"Repeat Password correctly" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        
//        [alert show];
//        
//    }
    
    else if ([mailtxt.text isEqualToString:@""] && ( [passwrdtxt.text isEqualToString:@""] ||[rep_passwrdtxt.text isEqualToString:@""]||[fstnametxt.text isEqualToString:@""]||[lstname.text isEqualToString:@""]) ) {
        
     UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please enter email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag=1;
        
        [alert show];
    }
    else if (whiteSpaceRange.location != NSNotFound)
    {
        NSLog(@"Found whitespace");
      UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please omit whitespace in email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag=1;
        
        [alert show];
        
    }
    else if (![ self NSStringIsValidEmail:mailtxt.text])
    {
        
       UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please provide valid Email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag=1;
        
        [alert show];
        
        
    }
    
    
    else if ([passwrdtxt.text isEqualToString:@""] &&[rep_passwrdtxt.text isEqualToString:@""]) {
        
    
       UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please enter Desired Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag=1;
        
        [alert show];
    }
    else if ([rep_passwrdtxt.text isEqualToString:@""]  ) {
        

       UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please enter confirm password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag=1;
        
        [alert show];
    }
    else if (![passwrdtxt.text isEqualToString:rep_passwrdtxt.text]) {
      
       UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please enter Repeat Password correctly" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag=1;
        
        [alert show];
    }
    else if ([passwrdtxt.text length]< 6) {
        
       UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Password should be atleast 6 characters" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag=1;
        
        [alert show];
        return;
    }
  
    else if (![[NSUserDefaults standardUserDefaults] boolForKey:@"term"])
    {
        
       UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"You must follow the terms and conditions to continue" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag=1;
        
        [alert show];
        return;
        
        
    }
    else
    {
       
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"signupstat"]isEqualToString:@"fbsignup"]) {
//         
//            NSLog(@"social_img====%@",social_img);
//            NSString *myimg = social_img;
//            NSArray *myWords = [myimg componentsSeparatedByString:@"&"];
//            NSLog(@"cut email str===%@",myWords );
//            
//            for (int i=0; i<myWords.count; i++) {
//                 new_picstr = [NSString stringWithFormat:@"%@%@", new_picstr,[myWords objectAtIndex:i] ];
//            }
//            NSLog(@"new_picstr====%@",new_picstr);
      
            
        NSString *new_picstr=[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large",fb_id];
            
            
            
urlString =[NSString stringWithFormat:@"%@registration.php?first_name=%@&last_name=%@&password=%@&email=%@&last_sync=&last_action=&newsletter=&send_initial=&send_onefive_day=&user_name=&facebookid=%@&twitterid=&img_url=%@&device_type=IOS&deviceToken=%@",APPS_DOMAIN_URL,[fstnametxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[lstname.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ],[passwrdtxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ],[mailtxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],fb_id,new_picstr,[[NSUserDefaults standardUserDefaults]objectForKey:@"deviceToken"]];
            NSLog(@"register %@",urlString);

            
        }
        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"signupstat"]isEqualToString:@"twsignup"])
        {
        
            urlString =[NSString stringWithFormat:@"%@registration.php?first_name=%@&last_name=%@&password=%@&email=%@&last_sync=&last_action=&newsletter=&send_initial=&send_onefive_day=&user_name=&facebookid=&twitterid=%@&img_url=%@&device_type=IOS&deviceToken=%@",APPS_DOMAIN_URL,[fstnametxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[lstname.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ],[passwrdtxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ],[mailtxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],tw_id,social_img,[[NSUserDefaults standardUserDefaults]objectForKey:@"deviceToken"]];
            NSLog(@"register %@",urlString);
        
        }
        
   else
   {
   
    urlString =[NSString stringWithFormat:@"%@registration.php?first_name=%@&last_name=%@&password=%@&email=%@&last_sync=&last_action=&newsletter=&send_initial=&send_onefive_day=&user_name=&facebookid=&twitterid=&device_type=IOS&deviceToken=%@",APPS_DOMAIN_URL,[fstnametxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[lstname.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ],[passwrdtxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ],[mailtxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults]objectForKey:@"deviceToken"]];
       NSLog(@"register %@",urlString);

   }
 
        
        NSError *error;
        NSData *dataURL = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        NSLog(@"dataurl is %@",urlString);
        
        json = [NSJSONSerialization JSONObjectWithData:dataURL
                                                options:kNilOptions
                                                  error:&error];
        
        
        
        
       // NSLog(@"json is %@ ======> %@",json, (NSString *)[json objectForKey:@"auth"]);
        NSString *userStatus = (NSString *)[json objectForKey:@"auth"];
        
        
        if([[NSString stringWithFormat:@"%@", userStatus] isEqualToString:@"success"]){
            
            //if username or password is valid
            NSDictionary *detdict=[json objectForKey:@"userdetails"];
            NSLog(@"detdict==%@",detdict);
            
            defaults=[NSUserDefaults standardUserDefaults];
            
            [defaults setObject:[detdict objectForKey:@"id"]forKey:@"id"];
            [defaults setObject:[detdict objectForKey:@"first_name"]forKey:@"first_name"];
            [defaults setObject:[detdict objectForKey:@"last_name"]forKey:@"last_name"];
            [defaults setObject:[detdict objectForKey:@"email"]forKey:@"email"];
            [defaults setObject:[detdict objectForKey:@"password"]forKey:@"password"];
            [defaults setObject:[detdict objectForKey:@"last_sync"]forKey:@"last_sync"];
             [defaults setObject:nil forKey:@"user_pic_thumb"];
            if ( [[[NSUserDefaults standardUserDefaults]objectForKey:@"signupstat"]isEqualToString:@"fbsignup"]||[[[NSUserDefaults standardUserDefaults]objectForKey:@"signupstat"]isEqualToString:@"twsignup"]) {
                  [defaults setObject:[detdict objectForKey:@"pic_url"] forKey:@"userimage"];
            }
            else
            [defaults setObject:nil forKey:@"userimage"];
             [defaults setObject:@"0" forKey:@"lock_key"];
             [defaults setBool:NO forKey:@"remember"];
            
            
            [defaults setBool:YES forKey:@"email_log"];
            
            
            
            [defaults synchronize];
            
            
            
            QTHomeViewController *home=[[QTHomeViewController alloc]init];
            [self.navigationController pushViewController:home animated:YES];
            
  
            
        } else {
            
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration failed!!!" message:@"Duplicacy occured" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
            

            
            
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

//textfield delegate method
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:NO];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
