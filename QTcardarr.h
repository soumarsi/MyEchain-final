//
//  QTcardarr.h
//  MyEchain
//
//  Created by maxcon8 on 28/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QTcardarr : NSObject
{
    
    NSMutableArray *card_arr;
    NSMutableArray *user_card_arr;
    
    
}
@property(nonatomic,retain)NSMutableArray *card_arr;
@property(nonatomic,retain)NSMutableArray *user_card_arr;
@property(nonatomic,retain)NSMutableArray *final_card_arr;
+(QTcardarr*)getInstance;
@end
