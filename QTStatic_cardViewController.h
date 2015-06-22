//
//  QTStatic_cardViewController.h
//  MyEchain
//
//  Created by maxcon8 on 17/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QTStatic_cardViewController : UIViewController
{

    UIView *mainview,*headview;
    UIScrollView *mainscroll;
    UIImageView *cardimg;


}
@property(nonatomic,retain)NSDictionary *card_dict;
@end
