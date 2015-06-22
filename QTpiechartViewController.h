//
//  QTpiechartViewController.h
//  MyEchain
//
//  Created by maxcon8 on 21/01/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PieChartView.h"

@interface QTpiechartViewController : UIViewController<PieChartDelegate>
{

    UIView *mainview,*headview;
    NSString *urlString1;
    NSMutableDictionary *redm_dict;
    int opesnumber,resnumber;
    int percnt;

}
@property (nonatomic,retain)NSString *company_id;
@property (nonatomic,strong) PieChartView *pieChartView;
@property (nonatomic,strong) NSMutableArray *valueArray;
@property (nonatomic,strong) NSMutableArray *colorArray;
@property (nonatomic,strong) UIView *pieContainer;
@property (nonatomic,strong) UILabel *selLabel;
@end
