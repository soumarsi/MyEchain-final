//
//  QTSplashViewController.h
//  MyEchain
//
//  Created by maxcon8 on 22/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTLoginViewController.h"
#import "QTSignupViewController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import <Twitter/Twitter.h>
#import "FHSTwitterEngine.h"
#import "FHSStream.h"
@interface QTSplashViewController : UIViewController<UITextFieldDelegate,FHSTwitterEngineAccessTokenDelegate>
{

    UIView *mainview;
    UIButton *fb,*twit,*mail,*savebtn,*cancelbtn;
    UIImageView *imgspin;
    UIActivityIndicatorView *spinnern;
    NSUserDefaults *defaults;
    NSDictionary *userDetails;
    NSMutableArray *json;
    UITextField *emailtextfield,*mailtwtrfield,*locktxt;
    NSDictionary *jsonResults;
    NSString *profileimageURL;
    UIAlertView *alert;
    NSString *fbemail;
    NSDictionary *json1;
    NSDictionary *twittdict;
     NSString *emailstring;
    NSString *prof_img;
    NSString *name,*twitterid,*profImageBig,*existsemail;
    BOOL chckusrmail;
      UIAlertView *dialog;
    UIView *lockview,*blackview;
    NSMutableArray *lockarr;
    UIView *givemail;
    NSMutableArray *con_array;
    NSString *ret_str;
}
@property (nonatomic,retain) ACAccountStore *accountStore;
@property (nonatomic,retain) ACAccount *twitterAccount;
@end
