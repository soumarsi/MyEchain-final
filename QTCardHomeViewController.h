//
//  QTCardHomeViewController.h
//  MyEchain
//
//  Created by maxcon8 on 22/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTfooterTab.h"
#import "QTcardarr.h"
#import "MyLauncherView.h"
#import "MyLauncherItem.h"
#import <CoreLocation/CoreLocation.h>
@interface QTCardHomeViewController : UIViewController<UITextFieldDelegate,UIGestureRecognizerDelegate,UIAlertViewDelegate,UIScrollViewDelegate,MyLauncherViewDelegate>
{
 
    UIView *mainview,*headview;
        UITableView *testtable;
    UIImageView *imgspin;
    UIActivityIndicatorView *spinnern;
    NSMutableArray *cardarr,*extracard,*temparr,*PlistArray;
    NSMutableDictionary *result1;
    int rowcount;
    long t,new_pos,grid_count;
    UIScrollView *boxScroll;
    NSMutableArray *newarr1,*allarr;
     UIView *lockview,*blackview;
    UITextField *locktxt;
    UIButton *savebtn,*cancelbtn;
    UIAlertView *show_alert1;
    UIImageView *redview;
    UIImageView *crossview;
    UIImageView *view;
NSString *path;
    int j;
    long k;
    QTcardarr *cardobj;
    CLLocationManager *locationManager;
    UIPageControl *pagecontrolforzoomimage;
    NSOperationQueue *downloadQueue;
    float latitude;
    float longitude;
    int m;
    Class viewCtrClass;
    NSMutableDictionary *dict;
}
-(NSMutableArray *)savedLauncherItems;
-(NSArray*)retrieveFromUserDefaults:(NSString *)key;
-(void)saveToUserDefaults:(id)object key:(NSString *)key;
@property (nonatomic, strong) UIView *overlayView;
@property (nonatomic, strong) UIViewController *currentViewController;
@property (nonatomic, assign) CGRect statusBarFrame;
@property (nonatomic, strong) UINavigationController *launcherNavigationController;
@property (nonatomic, strong) MyLauncherView *launcherView;
@property (nonatomic, strong) NSMutableDictionary *appControllers;

-(BOOL)hasSavedLauncherItems;
-(void)clearSavedLauncherItems;

-(void)launcherViewItemSelected:(MyLauncherItem*)item;
-(void)closeView;
@end
