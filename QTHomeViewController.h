//
//  QTHomeViewController.h
//  MyEchain
//
//  Created by maxcon8 on 22/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTfooterTab.h"
#import "QTLoginViewController.h"
@interface QTHomeViewController : UIViewController<UITextFieldDelegate>
{

    UIView *mainview;
    UIView *lockview,*blackview;
    UITextField *locktxt;
    UIButton *savebtn,*cancelbtn;
    //NSMutableArray *con_array;



}
@end
