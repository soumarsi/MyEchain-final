//
//  QTMapDetailsViewController.h
//  MyEchain
//
//  Created by Soumarsi Kundu on 25/05/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QTMapDetailsViewController : UIViewController
{
    NSMutableArray *data_retrived;
    NSString *streetAdd;
    NSMutableDictionary *locationdictionary;
    UIView *googlebackview;
}

@property(nonatomic) float currentlocationlat;
@property(nonatomic) float currentlocationlong;
@property(nonatomic) float destinationlat;
@property(nonatomic) float destinationlong;
@property(nonatomic,retain) NSString *Address;
@property (nonatomic,retain) NSMutableArray *LocationArray;
@property (nonatomic,strong) NSMutableArray *detailsarray;
@end
