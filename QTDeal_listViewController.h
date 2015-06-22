//
//  QTDeal_listViewController.h
//  MyEchain
//
//  Created by maxcon8 on 23/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QTDeal_listViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate,UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    UIView *tview_det;
    UIButton *back_detbtn;
    CGSize expectedLabelSize;
    UIView *det_view,*det_view_bg;
    UIView *mainview,*headview;
    UITableView *testtable;
    NSMutableArray *dealarr;
    UIImageView *imgspin;
    UIActivityIndicatorView *spinnern;
    UIWebView *webView;
    UIScrollView *mainScroll;
    UIView *lockview,*blackview;
    UITextField *locktxt;
    UIButton *savebtn,*cancelbtn;
    NSMutableDictionary *deal_dict;
    
    /////// RAHUL ////////
    
    UIButton *cellbutton;
    NSMutableArray *expandedCells;
    UITextView *detailstext;
}
@property(nonatomic,retain)NSString *company_id;
@end
