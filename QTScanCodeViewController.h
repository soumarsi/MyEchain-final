//
//  QTScanCodeViewController.h
//  MyEchain
//
//  Created by RAHUL - ( iMAC ) on 24/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTfooterTab.h"
#import <AVFoundation/AVFoundation.h>
#import "RMScannerView.h"
#import "RMOutlineBox.h"
#import "QTCarddetailViewController.h"
#import "QTHomeViewController.h"
#import "QTaddScanViewController.h"



@interface QTScanCodeViewController : UIViewController<RMScannerViewDelegate, UIAlertViewDelegate, UIBarPositioningDelegate,UIWebViewDelegate,AVCaptureMetadataOutputObjectsDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
     UIView *mainview,*headview;
      UIButton *Scan;
    
    RMScannerView *scannerView;
    UILabel *statusText;
    UILabel *scan_lbl;
    UIView *codeview;
    UILabel *codetype,*codescan,*timescan;
   UIActivityIndicatorView *activityIndicator;
    UIButton *urlbtn,*canclbtn;
    NSString *dateInStringFormated,*sendcodetype;
    UIView *lockview,*blackview;
    UITextField *locktxt,*cmptxt,*codetxt,*locnotxt;
    UIButton *savebtn,*cancelbtn;
    UIView *editview,*headedit,*infoview;
    UIImageView *editcrdimg;
    UIButton *done_keyboard;
    UIView *back_key;
    UILabel *donelb,*scan_lbl1;
    NSMutableArray *editypearr;
    UITableView *codetable;
    UILabel *sel_code;
    UIView *BlackEditView;
    UIView *Labelview;
    UIView *BackGroundView;
    UIView *inapp_webview;
    UITextField *CardOwnerName;
}

@property(nonatomic,retain)NSString *sendCode;
@property(nonatomic,retain)NSString *cmp_name;
@property(nonatomic,retain)NSString *cmp_id;
@property(nonatomic,retain)NSString *cmp_image;
@property(nonatomic,retain)NSString *card_no;
@property(nonatomic,retain)NSString *loc_no;
@property(nonatomic,retain)NSString *card_type;
@property(nonatomic,retain)NSString *type;
@property(nonatomic,retain)NSString *cardid;
@property (nonatomic, retain) NSString *cardownername;

@end
