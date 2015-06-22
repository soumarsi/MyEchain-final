//
//  QTcust_detailsViewController.h
//  MyEchain
//
//  Created by maxcon8 on 09/01/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QTcust_detailsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{

    float height,nxtht,nxtht2;
    UIView *mainview,*headview,*pad_vw9;
    NSMutableArray *data_arr;
    NSMutableDictionary *result;
    UITableView *ListTableview;
    UIScrollView *edit_nonbrand;
    UITextField *nametxt,*emailtxt,*sextxt,*addrtxt,*addr2txt,*citytxt,*statetxt,*ziptxt,*phntxt,*birthtxt;
    UIButton *cal_view;
    UIDatePicker *datePicker;
    UIView *pickview;

}
@property(nonatomic,retain)NSString *card_id;
@property(nonatomic,retain)NSMutableDictionary *card_details;
@end
