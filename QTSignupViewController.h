//
//  QTSignupViewController.h
//  MyEchain
//
//  Created by maxcon8 on 22/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTLoginViewController.h"
@interface QTSignupViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
    
    
    UIView *mainview;
    UITextField *mailtxt,*passwrdtxt,*rep_passwrdtxt,*fstnametxt,*lstname;
    UIButton *chkbox;
    BOOL termBoxSelected;
    UIImageView *password_img;
     NSDictionary *json,*json1;
    NSUserDefaults *defaults;
    NSString *urlString;
    
}
@property (nonatomic,retain)NSString *fbemail;
@property(nonatomic,retain)NSString *first_name;
@property(nonatomic,retain)NSString *last_name;
@property(nonatomic,retain)NSString *fb_id;
@property(nonatomic,retain)NSString *tw_id;
@property(nonatomic,retain)NSString *social_img;
@end
