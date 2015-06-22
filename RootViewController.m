//
//  RootViewController.m
//  @rigoneri
//  
//  Copyright 2010 Rodrigo Neri
//  Copyright 2011 David Jarrett
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "RootViewController.h"
#import "MyLauncherItem.h"
#import "CustomBadge.h"

#import "Model.h"
#import "QTCarddetailViewController.h"
#import "QTStatic_cardpetViewController.h"
#import "QTStatic_cardViewController.h"

@implementation RootViewController
{
     Mymodel *obj1;
    NSOperationQueue *downloadQueue;
    NSMutableArray *Tmp;
}

-(void)loadView
{
    [super loadView];
    NSLog(@"rootviewcontroller");
    
   self.title = @"";
    
    [[self appControllers] setObject:[QTCarddetailViewController class] forKey:@"QTCarddetailViewController"];
    
    [[self appControllers] setObject:[QTStatic_cardpetViewController class] forKey:@"QTStatic_cardpetViewController"];
    [[self appControllers] setObject:[QTStatic_cardViewController class] forKey:@"QTStatic_cardViewController"];
    
    //Add your view controllers here to be picked up by the launcher; remember to import them above
	//[[self appControllers] setObject:[MyCustomViewController class] forKey:@"MyCustomViewController"];
	//[[self appControllers] setObject:[MyOtherCustomViewController class] forKey:@"MyOtherCustomViewController"];
    
	if(![self hasSavedLauncherItems])
	{

        NSLog(@"lauchitem-------");
        
        Tmp = [[NSMutableArray alloc]init];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"dont launchitem");
   
        
        __block  NSError *error=nil;
        NSMutableArray *Arr = [[NSMutableArray alloc]init];
        
        NSString *  urlString =[NSString stringWithFormat:@"http://www.esolz.co.in/lab1/Web/myEchain/Iosapp/fetch_data.php?id=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"id"]];  //
        
        NSLog(@"urlstring----- %@",urlString);
        
        NSURL *requestURL = [NSURL URLWithString:urlString];
        
        NSData *signeddataURL =  [NSData dataWithContentsOfURL:requestURL options:NSDataReadingUncached error:&error];
        
        Arr = [NSJSONSerialization JSONObjectWithData:signeddataURL options:kNilOptions error:&error];
        
        
        // Arr = [[NSUserDefaults standardUserDefaults]objectForKey:@"myLauncherView"];
        
        NSMutableArray *myItems = [[NSMutableArray alloc] init];
        
        NSMutableArray *pagesArray = [[NSMutableArray alloc] init];
        
        
        
        int itemCount = 1;
        long elements = Arr.count;
        
        NSLog(@"ELEMENT--- %ld",elements);
        
        for (int a = 0; a<elements; a++)
        {
            Tmp = [Arr objectAtIndex:a];
            int l;
            for (l = 0; l< Tmp.count; l++)
            {
                
                //NSLog(@"tmp--- %@",Tmp);
                
                if (itemCount == 1)
                {
                    myItems = [[NSMutableArray alloc] init];
                }
                NSString *IphoneImageCard = [NSString stringWithFormat:@"%@",[[Tmp objectAtIndex:l]objectForKey:@"image"]];
                if ([[[Tmp objectAtIndex:l]objectForKey:@"title"] isEqualToString:@"static1"])
                {
                    [myItems addObject:[[MyLauncherItem alloc] initWithTitle:@"static1"
                                                                 iPhoneImage:IphoneImageCard
                                                                   iPadImage:[NSString stringWithFormat:@"%@",[[Tmp objectAtIndex:l]objectForKey:@"iPadImage"]]
                                                                      target:@"QTStatic_cardViewController"
                                                                 targetTitle:[NSString stringWithFormat:@"%d",l]
                                                                      cardno:[NSString stringWithFormat:@"%d",l]
                                                                   deletable:YES]];
                }
                else if ([[[Tmp objectAtIndex:l]objectForKey:@"title"] isEqualToString:@"static2"])
                {
                    [myItems addObject:[[MyLauncherItem alloc] initWithTitle:@"static2"
                                                                 iPhoneImage:IphoneImageCard
                                                                   iPadImage:[NSString stringWithFormat:@"%@",[[Tmp objectAtIndex:l]objectForKey:@"iPadImage"]]
                                                                      target:@"QTStatic_cardpetViewController"
                                                                 targetTitle:[NSString stringWithFormat:@"%d",l]
                                                                      cardno:[NSString stringWithFormat:@"%d",l]
                                                                   deletable:YES]];
                }
                else
                {
                    if ([[[Tmp objectAtIndex:l]objectForKey:@"image"] length] == 0)
                    {
                        [myItems addObject:[[MyLauncherItem alloc] initWithTitle:@""
                                                                     iPhoneImage:@""
                                                                       iPadImage:[NSString stringWithFormat:@"%@",[[Tmp objectAtIndex:l]objectForKey:@"iPadImage"]]
                                                                          target:@"QTCarddetailViewController"
                                                                     targetTitle:[NSString stringWithFormat:@"%d",l]
                                                                          cardno:[NSString stringWithFormat:@"%d",l]
                                                                       deletable:YES]];
                    }
                    else
                    {
                        [myItems addObject:[[MyLauncherItem alloc] initWithTitle:@""
                                                                     iPhoneImage:IphoneImageCard
                                                                       iPadImage:[NSString stringWithFormat:@"%@",[[Tmp objectAtIndex:l]objectForKey:@"iPadImage"]]
                                                                          target:@"QTCarddetailViewController"
                                                                     targetTitle:[NSString stringWithFormat:@"%d",l]
                                                                          cardno:[NSString stringWithFormat:@"%d",l]
                                                                       deletable:YES]];
                    }
                }
                if ((itemCount == 20) || (l == (Tmp.count - 1))) {
                    [pagesArray addObject:myItems];
                    
                    itemCount = 1;
                } else {
                    itemCount++;
                }
            }
            
        }
        [self.launcherView setPages:pagesArray];
  });
 
        
        // Set number of immovable items below; only set it when you are setting the pages as the 
        // user may still be able to delete these items and setting this then will cause movable 
        // items to become immovable.
      //[self.launcherView setNumberOfImmovableItems:10];
        
        // Or uncomment the line below to disable editing (moving/deleting) completely!
       //[self.launcherView setEditingAllowed:NO];
	}
    else
    {
        
        NSLog(@"dont launchitem");
        
        Tmp = [[NSMutableArray alloc]init];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"dont launchitem");
            
            
            __block  NSError *error=nil;
            NSMutableArray *Arr = [[NSMutableArray alloc]init];
            
            NSString *  urlString =[NSString stringWithFormat:@"http://www.esolz.co.in/lab1/Web/myEchain/Iosapp/fetch_data.php?id=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"id"]];  //
            NSLog(@"urlstring----- %@",urlString);
            
            NSURL *requestURL = [NSURL URLWithString:urlString];
            
            NSData *signeddataURL =  [NSData dataWithContentsOfURL:requestURL options:NSDataReadingUncached error:&error];
            
            Arr = [NSJSONSerialization JSONObjectWithData:signeddataURL options:kNilOptions error:&error];
            
            
            // Arr = [[NSUserDefaults standardUserDefaults]objectForKey:@"myLauncherView"];
            
            NSMutableArray *myItems = [[NSMutableArray alloc] init];
            
            NSMutableArray *pagesArray = [[NSMutableArray alloc] init];
            
            
            
            int itemCount = 1;
            long elements = Arr.count;
            
            NSLog(@"ELEMENT--- %ld",elements);
            
            for (int a = 0; a<elements; a++)
            {
                Tmp = [Arr objectAtIndex:a];
                int l;
                for (l = 0; l< Tmp.count; l++)
                {
                    
                    
                    
                   // NSLog(@"tmp--- %@",Tmp);
                    
                    if (itemCount == 1)
                    {
                        myItems = [[NSMutableArray alloc] init];
                    }
                    NSString *IphoneImageCard = [NSString stringWithFormat:@"%@",[[Tmp objectAtIndex:l]objectForKey:@"image"]];
                    if ([[[Tmp objectAtIndex:l]objectForKey:@"title"] isEqualToString:@"static1"])
                    {
                        [myItems addObject:[[MyLauncherItem alloc] initWithTitle:@"static1"
                                                                     iPhoneImage:IphoneImageCard
                                                                       iPadImage:[NSString stringWithFormat:@"%@",[[Tmp objectAtIndex:l]objectForKey:@"iPadImage"]]
                                                                          target:@"QTStatic_cardViewController"
                                                                     targetTitle:[NSString stringWithFormat:@"%d",l]
                                                                          cardno:[NSString stringWithFormat:@"%d",l]
                                                                       deletable:YES]];
                    }
                    else if ([[[Tmp objectAtIndex:l]objectForKey:@"title"] isEqualToString:@"static2"])
                    {
                        [myItems addObject:[[MyLauncherItem alloc] initWithTitle:@"static2"
                                                                     iPhoneImage:IphoneImageCard
                                                                       iPadImage:[NSString stringWithFormat:@"%@",[[Tmp objectAtIndex:l]objectForKey:@"iPadImage"]]
                                                                          target:@"QTStatic_cardpetViewController"
                                                                     targetTitle:[NSString stringWithFormat:@"%d",l]
                                                                          cardno:[NSString stringWithFormat:@"%d",l]
                                                                       deletable:YES]];
                    }
                    else
                    {
                        if ([[[Tmp objectAtIndex:l]objectForKey:@"image"] length] == 0)
                        {
                            [myItems addObject:[[MyLauncherItem alloc] initWithTitle:@""
                                                                         iPhoneImage:@""
                                                                           iPadImage:[NSString stringWithFormat:@"%@",[[Tmp objectAtIndex:l]objectForKey:@"iPadImage"]]
                                                                              target:@"QTCarddetailViewController"
                                                                         targetTitle:[NSString stringWithFormat:@"%d",l]
                                                                              cardno:[NSString stringWithFormat:@"%d",l]
                                                                           deletable:YES]];
                            
                        }
                        else
                        {
                            [myItems addObject:[[MyLauncherItem alloc] initWithTitle:@""
                                                                         iPhoneImage:IphoneImageCard
                                                                           iPadImage:[NSString stringWithFormat:@"%@",[[Tmp objectAtIndex:l]objectForKey:@"iPadImage"]]
                                                                              target:@"QTCarddetailViewController"
                                                                         targetTitle:[NSString stringWithFormat:@"%d",l]
                                                                              cardno:[NSString stringWithFormat:@"%d",l]
                                                                           deletable:YES]];
                        }
                    }
                    
                    
                    if ((itemCount == 20) || (l == (Tmp.count - 1))) {
                        [pagesArray addObject:myItems];
                        
                        itemCount = 1;
                    } else {
                        itemCount++;
                    }
                }
                
            }
            [self.launcherView setPages:pagesArray];
            
            
            
        });
    }
    
    // Set badge text for a MyLauncherItem using it's setBadgeText: method
    
    //[(MyLauncherItem *)[[[self.launcherView pages] objectAtIndex:0] objectAtIndex:0] setBadgeText:@"4"];
    
    // Alternatively, you can import CustomBadge.h as above and setCustomBadge: as below.
    // This will allow you to change colors, set scale, and remove the shine and/or frame.
   
    
    // [(MyLauncherItem *)[[[self.launcherView pages] objectAtIndex:0] objectAtIndex:1] setCustomBadge:[CustomBadge customBadgeWithString:@"2" withStringColor:[UIColor blackColor] withInsetColor:[UIColor whiteColor] withBadgeFrame:YES withBadgeFrameColor:[UIColor blackColor] withScale:0.8 withShining:NO]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	//If you don't want to support multiple orientations uncomment the line below
    //return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
	return [super shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
}

@end
