//
//  Model.m
//  Mcoupon
//
//  Created by Anirban Tah on 06/06/14.
//  Copyright (c) 2014 Anirban Tah. All rights reserved.
//

#import "Model.h"

@implementation Mymodel


@synthesize cardarray;

static Mymodel *instance =nil;

+(Mymodel *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [Mymodel new];
        }
    }
    return instance;
}
@end

