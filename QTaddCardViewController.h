//
//  QTaddCardViewController.h
//  MyEchain
//
//  Created by maxcon8 on 22/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTfooterTab.h"
@interface QTaddCardViewController : UIViewController<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{

    UIView *mainview,*headview;
    UITableView *testtable;
    UISearchBar *MySearchBar;
    NSMutableArray *con_array,*cardarray;
    NSMutableArray *indexes;
    NSMutableArray * filteredIndexedSet;
    NSMutableArray * filteredIndexes,*final_con_array,*filtered_arr;
    BOOL firsttym;
     NSMutableArray * indexedSet;
    NSMutableDictionary *add_contacts_dict;
    NSArray *dictkeysarr;
    UIImageView *imgspin;
    UIActivityIndicatorView *spinnern;
    NSCharacterSet *whitespace;
    NSString *st;
    int filter;
     NSArray *searchresults;
    NSMutableArray *sectionContactsArray,*search_arr;
    NSPredicate *pred;
    NSArray *result;
    UIView *lockview,*blackview;
    UITextField *locktxt;
    UIButton *savebtn,*cancelbtn;
    UILabel *nodata;
}
@end
