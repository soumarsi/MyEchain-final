//
//  QTCarddetailViewController.h
//  MyEchain
//
//  Created by maxcon8 on 23/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTDeal_listViewController.h"
#import "NKDUPCEBarcode.h"
#import "UIImage-NKDBarcode.h"
#import "qrencode.h"
#import "UIImage+QRCodeGenerator.h"
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "QTcardarr.h"

#import "NKDBarcode.h"
#import "NKDCode39Barcode.h"
#import "NKDCode128Barcode.h"
#import "NKDEAN13Barcode.h"
#import "NKDEAN8Barcode.h"
#import "NKDAbstractUPCEANBarcode.h"
#import "NKDCodabarBarcode.h"
#import <CoreLocation/CoreLocation.h>
@interface QTCarddetailViewController : UIViewController<UIWebViewDelegate,UIAlertViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,MKMapViewDelegate,UIScrollViewDelegate,CLLocationManagerDelegate>
{
    
    UILabel *qr_code;
    UIView *mainview,*headview,*web_company,*edit_nonbrand;
    UIButton *globe,*arrow,*twit,*fb,*share;
    UIWebView *cmpnyweb;
    UIImageView *cardimg,*editcrdimg;
    UIView *pages_view;
    UIActivityViewController *activityView;
    UIActivityIndicatorView *activityIndicator;
    UIWebView *webView;
    UIAlertView *alert;
    NSURL *url2;
    UIAlertView *alrtview;
    UIImage *barcodeimg;
    BOOL card_edit;
    UITextField *cmptxt,*codetxt,*locnotxt;
    UIView *editview,*headedit;
    UIImageView *qrimg;
    UITableView *codetable;
    UIView *blackview;
    NSString *barcodestr;
    NSMutableArray *editypearr;
    UILabel *typelb;
    UIImageView *imgView;
    MKMapView *map_View;
    UIView *map_backview;
    UIImageView *cellfire_img;
    UITapGestureRecognizer *cellfire_tap;
    NSMutableDictionary *merchantIdToCellfireId;
    NSString *marchnt_id;
    bool branded;
    NSString *qr_codeimg;
    MKPointAnnotation *myAnnotation;
    UILabel *securitycode;
    NSMutableDictionary *locationdictionary;
    NSMutableArray *LocationArray;
    NSDictionary *detailsdict;
    UIScrollView *DetailsScrollView;
    NSMutableArray *DetailsArray;
    UIActivityIndicatorView *spin_img;
    NSString *webstr;
    NSMutableArray *data_retrived;
    NSString *streetAdd;
    UIPageControl *pagecontrolforzoomimage;
    UIWebView *googleweb;
    UIView *googlebackview;
     CLLocationManager *locationManager;
    //--// Rahul 28 Apr
    
    UIView *indicatorview;
    UIActivityIndicatorView *indicator;
}
@property(nonatomic,retain)NSMutableDictionary *card_dict;
@property(nonatomic)float latitude;
@property(nonatomic)float longitude;
@property (nonatomic, retain) NSString *card_id;
@end
