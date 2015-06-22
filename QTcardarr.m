//
//  QTcardarr.m
//  MyEchain
//
//  Created by maxcon8 on 28/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "QTcardarr.h"

@implementation QTcardarr


@synthesize card_arr,final_card_arr,user_card_arr;

static QTcardarr *instance =nil;


+(QTcardarr *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [QTcardarr new];
        }
    }
    return instance;
}
@end
