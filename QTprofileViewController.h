//
//  QTprofileViewController.h
//  MyEchain
//
//  Created by maxcon8 on 22/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTfooterTab.h"
#import "QTLoginViewController.h"
@interface QTprofileViewController : UIViewController<UIImagePickerControllerDelegate,UIAlertViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate>
{
    
    UIView *mainview,*headview,*sview,*blackview1,*lockview1;
    UIButton *syncbtn,*lockbtn;
    UIActivityIndicatorView *spiner1b,*spin_img;
    NSMutableDictionary *add_contacts_dict;
    UILabel *syncdt;
    NSMutableArray *con_array,*final_con_array;
    UIImageView *profimg;
    UIImage *chosenImage;
    NSString *imageString;
    UIAlertView* dialog;
    UILabel *locklb;
    UIView *lockview,*blackview;
    UITextField *locktxt,*locktxt1;
    UIButton *savebtn,*cancelbtn,*savebtn1,*cancelbtn1;
    UIButton *unlockbtn;
    NSDictionary *json;
    UIActivityIndicatorView *spin_img11;
    
}
@end
