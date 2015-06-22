//
//  QTForgotpasswdViewController.h
//  MyEchain
//
//  Created by maxcon8 on 22/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QTForgotpasswdViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
{


    UIView *mainview;
    UITextField *mailtxt;
    UIAlertView *alert;

}
@end
