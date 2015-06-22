//
//  QTaddScanViewController.h
//  MyEchain
//
//  Created by RAHUL - ( iMAC ) on 24/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTHomeViewController.h"
@interface QTaddScanViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>


{
    UIView *mainview,*headview;
    UITextField *code,*company,*locnotxt;
      UIButton *Scan;
      UILabel *scan_lbl;
    UILabel *donelb;
    NSMutableDictionary *result1;
    UIView *lockview,*blackview;
    UITextField *locktxt;
    UIButton *savebtn,*cancelbtn;
    NSString *barcodestr;
    UIButton *done_keyboard;
    UILabel *back_key;
    NSMutableArray *editypearr;
    UILabel *sel_code;
    UITableView *codetable;
    UIView *BlackEditView,*Labelview;
    UITextField *CardOwnerName;
}

@property(nonatomic,retain) NSString *receiveCode;
@property(nonatomic,retain) NSString *receiveCode_type;
@property(nonatomic,retain) NSString *company_name;
@property(nonatomic,retain) NSString *company_id;
@property(nonatomic,retain) NSString *company_img;
@property(nonatomic,retain) NSString *local_no;
@end
