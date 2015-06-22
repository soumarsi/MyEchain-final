//
//  QTForgotpasswdViewController.m
//  MyEchain
//
//  Created by maxcon8 on 22/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "QTForgotpasswdViewController.h"
#import "QTLoginViewController.h"

@interface QTForgotpasswdViewController ()

@end

@implementation QTForgotpasswdViewController

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
    
    NSLog(@"QTForgotpasswdViewController");
    
    
    mainview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height )];
    mainview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"1-splashbg-1"]];
    [self.view addSubview:mainview];
    
    UIView *upperview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 128/2)];
    upperview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar"]];
    [mainview addSubview:upperview];
    
    
    UILabel *header=[[UILabel alloc]initWithFrame:CGRectMake(-10, 20, 320, 50)];
    header.text=@"FORGOT PASSWORD";
    header.font=[UIFont systemFontOfSize:18];
    header.textAlignment=NSTextAlignmentCenter;
    [upperview addSubview:header];
    
    UIImageView *back=[[UIImageView alloc]initWithFrame:CGRectMake(15, 35, 23/2, 41/2)];
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
    
    
    UILabel *donelb=[[UILabel alloc]initWithFrame:CGRectMake(200, 27, 150, 35)];
    donelb.textAlignment=NSTextAlignmentCenter;
    donelb.backgroundColor=[UIColor clearColor];
    donelb.text=@"DONE";
    donelb.textColor=[UIColor blueColor];
    [upperview addSubview:donelb];
    
    
    UITapGestureRecognizer *done_tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(done_fn)];
    [donelb addGestureRecognizer:done_tap];
    donelb.userInteractionEnabled=YES;
    
    
    
    //inputfield image for username text
    UIImageView *mail_pas=[[UIImageView alloc]initWithFrame:CGRectMake(0,upperview.frame.origin.y+upperview.frame.size.height , 320, 40)];
    mail_pas.image=[UIImage imageNamed:@"email-bg"];
    mail_pas.userInteractionEnabled=YES;
    [mainview addSubview:mail_pas];
    
    //email textfield
    mailtxt=[[UITextField alloc]initWithFrame:CGRectMake(50,0 , 270, 40)];
    mailtxt.backgroundColor=[UIColor clearColor];
    mailtxt.delegate=self;
    mailtxt.font= [UIFont systemFontOfSize:16];
    // usernametxt.placeholder=@"Username";
    UIColor *color = [UIColor grayColor];
    mailtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter email address" attributes:@{NSForegroundColorAttributeName: color}];
    mailtxt.textAlignment=NSTextAlignmentLeft;
    // usernametxt.text=@"ruh151";
    mailtxt.keyboardType = UIKeyboardTypeEmailAddress;
    mailtxt.delegate=self;
    [mail_pas addSubview:mailtxt];
  
    
    
}
-(void)done_fn
{
    
    NSError *error;
    
    if (![ self NSStringIsValidEmail:mailtxt.text])
    {
        NSLog(@"1st");
        alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please provide valid Email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag=1;
        
        [alert show];
        
        
    }
    else
    {
    
        NSString *urlString1 =[NSString stringWithFormat:@"%@forgotpass.php?email=%@",APPS_DOMAIN_URL,mailtxt.text];
        
        NSLog(@"checkuser url: %@",urlString1);
        
        NSURL *requestURL1 = [NSURL URLWithString:urlString1];
        
        NSData *signeddataURL1 =  [NSData dataWithContentsOfURL:requestURL1 options:NSDataReadingUncached error:&error];
        
        NSString *ret_str = [[NSString alloc] initWithData:signeddataURL1 encoding:NSUTF8StringEncoding];
        NSLog(@"ret checkuser:%@",ret_str);
    
        if ([ret_str isEqualToString:@"success"])
        {
            alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Password is sent through mail" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag=1;
            
            [alert show];
            
            
            QTLoginViewController *login=[[QTLoginViewController alloc]init];
            [self.navigationController pushViewController:login animated:NO];
            
            
            
        }
        else if ([ret_str isEqualToString:@"FB login"])
        {
        
            alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Password is sent through mail" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag=1;
            
            [alert show];
            
            
            QTLoginViewController *login=[[QTLoginViewController alloc]init];
            [self.navigationController pushViewController:login animated:NO];
            
        }
        else if ([ret_str isEqualToString:@"Tw login"])
        {
            
            alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Password is sent through mail" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag=1;
            
            [alert show];
            
            
            QTLoginViewController *login=[[QTLoginViewController alloc]init];
            [self.navigationController pushViewController:login animated:NO];
            
        
        }
        else
        {
        
            alert = [[UIAlertView alloc]initWithTitle:@"Sorry!!!" message:@"Email does not exist" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag=1;
            
            [alert show];
        
        }
    
    }
    
    
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
