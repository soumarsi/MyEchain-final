//
//  QTCardHomeViewController.m
//  MyEchain
//
//  Created by maxcon8 on 22/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "QTCardHomeViewController.h"
#import "QTCarddetailViewController.h"
#import "QTStatic_cardViewController.h"
#import "QTStatic_cardpetViewController.h"
#import "UIImageView+WebCache.h"
#import "Model.h"
#import <QuartzCore/QuartzCore.h>
#import "RootViewController.h"
#import <CoreLocation/CoreLocation.h>
/// end of grid view
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
@interface QTCardHomeViewController ()<CLLocationManagerDelegate>
{
 QTfooterTab *footerview;
    
    UIView *loader_shadow_View;
    UINavigationController *_optionsNav;
    UIPopoverController *_optionsPopOver;
    Mymodel *obj1;
    NSMutableArray *_data;
    NSMutableArray *_data2;
    NSInteger _lastDeleteItemIndexAsked;
    UIButton *button;
}

- (void)presentInfo;
- (void)presentOptions:(UIBarButtonItem *)barButton;
- (void)optionsDoneAction;


@end

@implementation QTCardHomeViewController
@synthesize launcherNavigationController = _launcherNavigationController;
@synthesize launcherView = _launcherView;
@synthesize appControllers = _appControllers;
@synthesize overlayView = _overlayView;
@synthesize currentViewController = _currentViewController;
@synthesize statusBarFrame = _statusBarFrame;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        NSLog(@"here in the nib name.....");
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
	// Do any additional setup after loading the view.
    
    
    
    
    NSLog(@"QTCardHomeViewController");
    mainview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height )];
    mainview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"1-splashbg-1"]];
    [self.view addSubview:mainview];
    mainview.userInteractionEnabled=YES;

    
    headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
    headview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar.png"]];
    [mainview addSubview:headview];
    
    UILabel *head_lb=[[UILabel alloc]initWithFrame:CGRectMake(0,30, [[UIScreen mainScreen]bounds].size.width, 29.5f)];
    head_lb.text=@"My Cards";
    head_lb.textAlignment=NSTextAlignmentCenter;
    head_lb.textColor=[UIColor whiteColor];
    head_lb.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:20];
    [headview addSubview:head_lb];

    
    
    UIButton *DeleteGrid=[UIButton buttonWithType:UIButtonTypeCustom];
    [DeleteGrid setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [DeleteGrid setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [DeleteGrid setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [DeleteGrid setTitle:@"deleteGrid" forState:UIControlStateHighlighted];
    [DeleteGrid setTitle:@"deleteGrid" forState:UIControlStateSelected];
    [DeleteGrid setTitle:@"deleteGrid" forState:UIControlStateNormal];
    
    [DeleteGrid setFrame:CGRectMake(200, 60, 100, 30)];
    //=======footerview
    
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"inhome"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    footerview = [[QTfooterTab alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-98/2, 320.0f,98/2)];
    [footerview.home setSelected:YES];
    [footerview.homesel_bg setHidden:NO];
    footerview.homesel_bg.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"select-bottombg"]];
    [self.view addSubview:footerview];
    
    blackview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    blackview.backgroundColor=[UIColor blackColor];
    blackview.alpha=0.5;
    [self.view addSubview:blackview];
    [blackview setHidden:YES];
    
    lockview = [[UIView alloc] initWithFrame:CGRectMake(10, 200, 300,150)];
    lockview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"1-splashbg-1"]];
    [self.view addSubview:lockview];
    [lockview setHidden:YES];
    
    locktxt=[[UITextField alloc]initWithFrame:CGRectMake(10,20 , 280, 40)];
    locktxt.backgroundColor=[UIColor whiteColor];
    locktxt.delegate=self;
    locktxt.font= [UIFont systemFontOfSize:16];
    locktxt.placeholder=@"Lock key";
    UIColor *passcolor = [UIColor grayColor];
    locktxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Lock key" attributes:@{NSForegroundColorAttributeName: passcolor}];
    locktxt.secureTextEntry=YES;
    locktxt.delegate=self;
    locktxt.textAlignment=NSTextAlignmentCenter;
    [lockview addSubview:locktxt];
    
    savebtn=[[UIButton alloc]initWithFrame:CGRectMake(10, locktxt.frame.origin.y+locktxt.frame.size.height+10, 280, 30)];
    savebtn.backgroundColor=[UIColor whiteColor];
    [savebtn setTitle:@"Process" forState:UIControlStateNormal];
    savebtn.titleLabel.textColor=[UIColor blackColor];
    [savebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [savebtn  addTarget:self action:@selector(savelock) forControlEvents:UIControlEventTouchUpInside];
    [lockview addSubview: savebtn];
    
    cancelbtn=[[UIButton alloc]initWithFrame:CGRectMake(10, savebtn.frame.origin.y+savebtn.frame.size.height+10, 280, 30)];
    cancelbtn.backgroundColor=[UIColor whiteColor];
    [cancelbtn setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelbtn.titleLabel.textColor=[UIColor blackColor];
    [cancelbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelbtn  addTarget:self action:@selector(cancellock) forControlEvents:UIControlEventTouchUpInside];
    [lockview addSubview:cancelbtn];
    
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"remember"] == 1)
    {
        [self lock_popup];
    }
    
    
    
    [self setLauncherView:[[MyLauncherView alloc] initWithFrame:CGRectMake(0.0f, 80, self.view.frame.size.width, self.view.frame.size.height-140)]];
    [self.launcherView setDelegate:self];
    [mainview addSubview:self.launcherView];
    
    
    [self.launcherView setPages:[self savedLauncherItems]];
    [self.launcherView setNumberOfImmovableItems:[(NSNumber *)[self retrieveFromUserDefaults:@"myLauncherViewImmovable"] intValue]];
    
    [self setAppControllers:[[NSMutableDictionary alloc] init]];
    [self setStatusBarFrame:[[UIApplication sharedApplication] statusBarFrame]];
 }





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lock_popup) name:@"lockview" object:nil];
    

    
}

-(void)lock_popup
{
    
    NSLog(@"asche");
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"lock_key"]!=[NSNull null])
        
    {
        
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"lock_key"]isEqualToString:@"0"]) {
            
            
            [blackview setHidden:NO];
            [lockview setHidden:NO];
            
            
        }
        else
        {
            
            
            
        }
        
    }// lock key if
    else
    {
  
        
    }//else lock key
    
    
}
-(void)cancellock
{
    [blackview setHidden:YES];
    
    [lockview setHidden:YES];
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    QTSplashViewController *logout=[[QTSplashViewController alloc]init];
    QTAppDelegate *mainDelegate = (QTAppDelegate *)[[UIApplication sharedApplication] delegate];
    [mainDelegate.navigationController pushViewController:logout animated:YES];
}
-(void)savelock
{
    if ([locktxt.text isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"lock_key"]])
    {
        [blackview setHidden:YES];
        
        [lockview setHidden:YES];

        
    }//if lock key match
    else
    {
        
        UIAlertView *chosseSource = [[UIAlertView alloc] initWithTitle:@"Sorry!!!"
                                                               message:@"Lock key not matching"
                                                              delegate:self
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:nil, nil];
        [chosseSource show];
        
        
    }
    
    
}


////////// for the gridview.....................................................................
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}




- (void)presentInfo
{
    NSString *info = @"Long-press an item and its color will change; letting you know that you can now move it around. \n\nUsing two fingers, pinch/drag/rotate an item; zoom it enough and you will enter the fullsize mode";
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info"
                                                        message:info
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    
    [alertView show];
    
    
}


- (void)presentOptions:(UIBarButtonItem *)barButton
{
    if (INTERFACE_IS_PHONE)
    {
        [self presentModalViewController:_optionsNav animated:YES];
    }
    else
    {
        if(![_optionsPopOver isPopoverVisible])
        {
            if (!_optionsPopOver)
            {
                _optionsPopOver = [[UIPopoverController alloc] initWithContentViewController:_optionsNav];
            }
            
            [_optionsPopOver presentPopoverFromBarButtonItem:barButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
        else
        {
            [self optionsDoneAction];
        }
    }
}

- (void)optionsDoneAction
{
    if (INTERFACE_IS_PHONE)
    {
        [self dismissModalViewControllerAnimated:YES];
    }
    else
    {
        [_optionsPopOver dismissPopoverAnimated:YES];
    }
}



////////// for the gridview.....................................................................
-(void)checkLoader
{
    
    if([self.view.subviews containsObject:loader_shadow_View])
    {
        
        
        [loader_shadow_View removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
    }
    else
    {
        
        loader_shadow_View = [[UIView alloc] initWithFrame:self.view.frame];
        [loader_shadow_View setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.56f]];
        
        [loader_shadow_View setUserInteractionEnabled:NO];
        [[loader_shadow_View layer] setZPosition:2];
        [self.view setUserInteractionEnabled:NO];
        UIActivityIndicatorView *loader =[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        [loader setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
        
        [loader startAnimating];
        
        
        [loader_shadow_View addSubview:loader];
        [self.view addSubview:loader_shadow_View];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}




-(void)gotoNextPageByDragging {
    
    NSLog(@"next page a jaaaaaaa");
}


- (void)viewWillLayoutSubviews {
    if (!CGRectEqualToRect(self.statusBarFrame, [[UIApplication sharedApplication] statusBarFrame])) {
        CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
        if (self.launcherNavigationController) {
            CGRect navConFrame = self.launcherNavigationController.view.bounds;
            [UIView animateWithDuration:0.3 animations:^{
                CGRect navBarFrame = self.launcherNavigationController.navigationBar.frame;
                [self.launcherNavigationController.navigationBar setFrame:CGRectMake(navBarFrame.origin.x, statusBarFrame.size.height, navBarFrame.size.width, navBarFrame.size.height)];
                [self.launcherNavigationController.view setFrame:CGRectMake(navConFrame.origin.x, navConFrame.origin.y, navConFrame.size.width, navConFrame.size.height)];
            } completion:^(BOOL finished){
                [self.launcherNavigationController.view setNeedsLayout];
            }];
        }
        [self setStatusBarFrame:statusBarFrame];
    }
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self.launcherView setCurrentOrientation:toInterfaceOrientation];
    if (self.launcherNavigationController) {
        [self.launcherNavigationController setNavigationBarHidden:YES];
        [self.launcherNavigationController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    if(self.launcherNavigationController) {
        [self.launcherNavigationController setNavigationBarHidden:NO];
        [self.launcherNavigationController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    }
    
    self.overlayView.frame = self.launcherView.frame;
    [self.launcherView layoutLauncher];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    locationManager = [[CLLocationManager alloc] init];
    if(IS_OS_8_OR_LATER) {
        
        
        NSUInteger code = [CLLocationManager authorizationStatus];
        
        if (code == kCLAuthorizationStatusNotDetermined && ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
            
            // choose one request according to your business.
            
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                
                
                
                [locationManager  requestAlwaysAuthorization];
                
                
                
            } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                
                
                
                [locationManager  requestWhenInUseAuthorization];
                
                
                
            } else {
                
                
                
            }
            
        }
        
    }
    
    
    
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    locationManager.distanceFilter=kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];

}

- (void)viewDidUnload {
    [super viewDidUnload];
}

#pragma mark - MyLauncherItem management

-(BOOL)hasSavedLauncherItems {
    return ([self retrieveFromUserDefaults:@"myLauncherView"] != nil);
}

-(void)launcherViewItemSelected:(MyLauncherItem*)item {
    
    
        NSLog(@"viewcontrol-------> %@",item.iPadImage);
    NSLog(@"viewcontrol-------> %@",[item controllerStr]);
    
    m = [item.cardnohome intValue];
    NSLog(@"itemviewDetails");
    
    if (![self appControllers] || [self launcherNavigationController]) {
        return;
    }
    
     viewCtrClass = [[self appControllers] objectForKey:[item controllerStr]];
    
    
    obj1 = [Mymodel getInstance];
    
    dict = [[NSMutableDictionary alloc]init];
    
  //
  
    dict = [[NSUserDefaults standardUserDefaults]objectForKey:@"myLauncherView"];
//    NSString* arrayOfStrings = [[NSString alloc]init];
//    
//    arrayOfStrings =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"personDataArray"]];
//    
//    NSMutableArray *array = [[NSMutableArray alloc]init];
//    
//   [array addObject: arrayOfStrings];
//    NSLog(@"%@",array);
//    
//    NSLog(@"objarray... %@",arrayOfStrings);
    
   // dict=[arrayOfStrings objectAtIndex:m];
    
    
    if ([[item controllerStr] isEqualToString:@"QTStatic_cardpetViewController"])
    {
      
        QTStatic_cardpetViewController *card=[[QTStatic_cardpetViewController alloc]init];
        card.card_dict=dict;
        // [self.navigationController pushViewController:card animated:NO];
        
        [self.storyboard instantiateViewControllerWithIdentifier:@"QTStatic_cardpetViewController"];
        //[self presentModalViewController:card animated:YES];
        [self presentViewController:card animated:YES completion:nil];

    }
    else if ([[item controllerStr] isEqualToString:@"QTStatic_cardViewController"])
    {
        QTStatic_cardViewController *card=[[QTStatic_cardViewController alloc]init];
        card.card_dict=dict;
        // [self.navigationController pushViewController:card animated:NO];
        [self.storyboard instantiateViewControllerWithIdentifier:@"QTStatic_cardViewController"];
        [self presentViewController:card animated:YES completion:nil];

    }
    else if ([[item controllerStr] isEqualToString:@"QTCarddetailViewController"])
    {
        QTCarddetailViewController *card=[[QTCarddetailViewController alloc]init];
        //card.card_dict=dict;
        [card setCard_id:item.iPadImage];
        [card setLatitude:latitude];
        [card setLongitude:longitude];
        // [self.navigationController pushViewController:card animated:NO];
        
        
        [card setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        
        [self presentViewController:card animated:YES completion:nil];

    }
    
    
}

-(void)launcherViewDidBeginEditing:(id)sender {
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]
                                                initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                target:self.launcherView action:@selector(endEditing)] animated:YES];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(220.0f, 30, 100, 30)];
    [button setTitle:@"DONE" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
    [button setTitleColor:[UIColor colorWithRed:(15/255.0f) green:(123/255.0f) blue:(255/255.0f) alpha:1] forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentLeft;
    [headview addSubview:button];
    [button addTarget:self.launcherView action:@selector(endEditing) forControlEvents:UIControlEventTouchUpInside];
}

-(void)launcherViewDidEndEditing:(id)sender {
    [self.navigationItem setRightBarButtonItem:nil];
    [button removeFromSuperview];
    
    //NSLog(@"----0-0-0-0-0 %@",[[[NSUserDefaults standardUserDefaults]objectForKey:@"myLauncherView"]objectAtIndex:0]);
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"myLauncherView"] options:0 error:nil];
    
    NSString* jsonString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    
    NSLog(@"jsonstring---- %@",jsonString);
    
    NSError *error = nil;
    
    NSData *swipedata = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@insert_cards.php?id=%@&data=%@",APPS_DOMAIN_URL,[[NSUserDefaults standardUserDefaults]objectForKey:@"id"],[jsonString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]options:NSDataReadingUncached error:&error];
    
    NSString *swipestring = [[NSString alloc]initWithData:swipedata encoding:NSUTF8StringEncoding];
    
    if ([swipestring isEqualToString:@"success"])
    {
        
    }
    //
}

- (void)closeView {
    UIView *viewToClose = [[self.launcherNavigationController topViewController] view];
    if (!viewToClose)
        return;
    
    viewToClose.transform = CGAffineTransformIdentity;
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         viewToClose.alpha = 0;
                         viewToClose.transform = CGAffineTransformMakeScale(0.00001, 0.00001);
                         self.overlayView.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         if ([[UIDevice currentDevice].systemVersion doubleValue] < 5.0) {
                             [[self.launcherNavigationController topViewController] viewWillDisappear:NO];
                         }
                         [[self.launcherNavigationController view] removeFromSuperview];
                         if ([[UIDevice currentDevice].systemVersion doubleValue] < 5.0) {
                             [[self.launcherNavigationController topViewController] viewDidDisappear:NO];
                         }
                         [self.launcherNavigationController setDelegate:nil];
                         [self setLauncherNavigationController:nil];
                         [self setCurrentViewController:nil];
                         [self.parentViewController viewWillAppear:NO];
                         [self.parentViewController viewDidAppear:NO];
                     }];
}
#pragma mark - UINavigationControllerDelegate

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([[UIDevice currentDevice].systemVersion doubleValue] < 5.0) {
        if (self.currentViewController) {
            [self.currentViewController viewWillDisappear:animated];
        }
        [viewController viewWillAppear:animated];
    }
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([[UIDevice currentDevice].systemVersion doubleValue] < 5.0) {
        if (self.currentViewController) {
            [self.currentViewController viewDidDisappear:animated];
        }
        [viewController viewDidAppear:animated];
    }
    [self setCurrentViewController:viewController];
}

#pragma mark - myLauncher caching

-(NSMutableArray *)savedLauncherItems {
    NSArray *savedPages = (NSArray *)[self retrieveFromUserDefaults:@"myLauncherView"];
    
    NSLog(@"savepages--- %@",savedPages);
    
    if(savedPages)
    {
        NSMutableArray *savedLauncherItems = [[NSMutableArray alloc] init];
        
        for (NSArray *page in savedPages)
        {
            NSMutableArray *savedPage = [[NSMutableArray alloc] init];
            for(NSDictionary *item in page)
            {
                NSNumber *version;
                if ((version = [item objectForKey:@"myLauncherViewItemVersion"])) {
                    if ([version intValue] == 2) {
                        [savedPage addObject:[[MyLauncherItem alloc]
                                              initWithTitle:[item objectForKey:@"title"]
                                              iPhoneImage:[item objectForKey:@"image"]
                                              iPadImage:[item objectForKey:@"iPadImage"]
                                              target:[item objectForKey:@"controller"]
                                              targetTitle:[item objectForKey:@"controllerTitle"]
                                              cardno:[item objectForKey:@"cardhome"]
                                              deletable:[[item objectForKey:@"deletable"] boolValue]]];
                    }
                }
                else
                {
                    [savedPage addObject:[[MyLauncherItem alloc]
                                          initWithTitle:[item objectForKey:@"title"]
                                          image:[item objectForKey:@"image"]
                                          target:[item objectForKey:@"controller"]
                                          cardno:[item objectForKey:@"cardhome"]
                                          deletable:[[item objectForKey:@"deletable"] boolValue]]];
                }
            }
            [savedLauncherItems addObject:savedPage];
        }
        
        return savedLauncherItems;
    }
    return nil;
}
-(void)clearSavedLauncherItems {
    [self saveToUserDefaults:nil key:@"myLauncherView"];
    [self saveToUserDefaults:nil key:@"myLauncherViewImmovable"];
}

-(id)retrieveFromUserDefaults:(NSString *)key {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) 
        return [standardUserDefaults objectForKey:key];
    return nil;
}

-(void)saveToUserDefaults:(id)object key:(NSString *)key {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) 
    {
        [standardUserDefaults setObject:object forKey:key];
        [standardUserDefaults synchronize];
    }
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    CLLocation *currentLocation = newLocation;
    
    
    [locationManager stopUpdatingLocation];
    if (currentLocation != nil) {
        
        
        
        latitude=  currentLocation.coordinate.latitude;
        longitude=  currentLocation.coordinate.longitude;
    }
    
    // this creates a MKReverseGeocoder to find a placemark using the found coordinates
    
    
    //stops didUpdateToLocation to be called infinite times
    
}
@end
