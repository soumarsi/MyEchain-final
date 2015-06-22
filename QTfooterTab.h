//
//  QTfooterTab.h
//  MyEchain
//
//  Created by maxcon8 on 22/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTCardHomeViewController.h"
#import "QTaddCardViewController.h"
#import "QTprofileViewController.h"
#import "QTAppDelegate.h"
#import "QTScanCodeViewController.h"
#import "QTScanCodeViewController.h"
#import "QTterms&conditnViewController.h"

@interface QTfooterTab : UIView
{

    //UIView *homesel_bg,*card_bg,*scan_bg,*profile_bg,*upgrade_bg;
    BOOL homeselected;
   

}
@property(nonatomic,retain)UIButton *home;
@property(nonatomic,retain)UIButton *card;
@property(nonatomic,retain)UIButton *scanner;
@property(nonatomic,retain)UIButton *profile;
@property(nonatomic,retain)UIButton *upgrade;
@property(nonatomic,retain)UIView *homesel_bg,*card_bg,*scan_bg,*profile_bg,*upgrade_bg;
@end
