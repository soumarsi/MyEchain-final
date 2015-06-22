//
//  QTLoginViewController.h
//  MyEchain
//
//  Created by maxcon8 on 22/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTHomeViewController.h"
#import "QTForgotpasswdViewController.h"
#import "QTSplashViewController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import <Twitter/Twitter.h>
#import "FHSTwitterEngine.h"
#import "FHSStream.h"
@interface QTLoginViewController : UIViewController<UITextFieldDelegate,FHSTwitterEngineAccessTokenDelegate,UIAlertViewDelegate>
{

    UIView *mainview;
    UITextField *emailtxt,*passwrdtxt;
    UIButton *fb_signin,*twit_signin,*cancelbtn;
    UIAlertView *alert;
    UIButton *chkbox,*savebtn;
    BOOL termBoxSelected;
    UIImageView *imgspin;
    UIActivityIndicatorView *spinnern;
    NSUserDefaults *defaults;
     NSDictionary *userDetails;
    NSMutableArray *json,*lockarr;
    NSDictionary *json1;
    UITextField *emailtextfield,*mailtwtrfield,*locktxt;
    NSDictionary *jsonResults;
    NSString *profileimageURL;
    NSString *fbemail;
 NSString *prof_img;
    NSString *name,*twitterid,*profImageBig,*existsemail;
    BOOL chckusrmail;
    UIAlertView *dialog;
     UIView *lockview,*blackview;
    UIView *givemail;
    NSString *ret_str;
    UINavigationController *navigationController;
    NSString *result;
    NSBundle* mainBundle;
}
@property (nonatomic,retain) ACAccountStore *accountStore;
@property (nonatomic,retain) ACAccount *twitterAccount;
@property(nonatomic,retain)NSString *fblogin_mail;
@end
