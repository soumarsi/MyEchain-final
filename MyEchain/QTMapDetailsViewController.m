//
//  QTMapDetailsViewController.m
//  MyEchain
//
//  Created by Soumarsi Kundu on 25/05/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "QTMapDetailsViewController.h"
#import <MapKit/MapKit.h>
#import "QTCarddetailViewController.h"
#import "JPSThumbnailAnnotation.h"
#import <CoreLocation/CoreLocation.h>
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
@interface QTMapDetailsViewController ()<MKMapViewDelegate,CLLocationManagerDelegate,UIWebViewDelegate>
{
    UIView *map_backview,*headedit;
    MKMapView *map_View;
    MKPointAnnotation *myAnnotation,*myClubAnnot;
    CLLocationManager *locationManager;
    NSOperationQueue *MainQueue;
    UIView *indicatorview;
    UIActivityIndicatorView *indicator;
    UIAlertView *alrtview;
}

@end

@implementation QTMapDetailsViewController


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
    locationManager.distanceFilter=1000.0f;
    [locationManager startUpdatingLocation];

    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    MainQueue = [[NSOperationQueue alloc]init];
    [MainQueue addOperationWithBlock:^{
        
        //  NSLog(@"array---%@",self.detailsarray);
        
        if(_detailsarray.count != 0)
        {
            
            NSString *  urlString =[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&type=store&radius=10000&name=%@&key=AIzaSyD15g_CRZyYCS9HCQ-xGfDHmbNAubmP2k4",self.currentlocationlat,self.currentlocationlong,[[[NSUserDefaults standardUserDefaults]objectForKey:@"companyname"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            NSLog(@"urlstring----> %@", urlString);
            
            NSError *error;
            NSURL *requestURL = [NSURL URLWithString:urlString];
            
            NSData *signeddataURL =  [NSData dataWithContentsOfURL:requestURL options:NSDataReadingUncached error:&error];
            
            NSDictionary *LocationDict = [NSJSONSerialization JSONObjectWithData:signeddataURL options:kNilOptions error:&error];
            
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                self.LocationArray = [[NSMutableArray alloc]init];
                
                if ([[LocationDict objectForKey:@"status"] isEqualToString:@"OK"])
                {
                    
                    NSMutableArray *resultsArray = [[NSMutableArray alloc]init];
                    
                    resultsArray  = [LocationDict objectForKey:@"results"];
                    
                    NSLog(@"===========location-------> %lu",(unsigned long)resultsArray.count);
                    
                    for (int l = 0; l<resultsArray.count; l++)
                    {
                        locationdictionary = [[NSMutableDictionary alloc]init];
                        
                        [locationdictionary setObject:[[[[resultsArray objectAtIndex:l]objectForKey:@"geometry"] objectForKey:@"location"]objectForKey:@"lat"] forKey:@"latitude"];
                        [locationdictionary setObject:[[[[resultsArray objectAtIndex:l]objectForKey:@"geometry"] objectForKey:@"location"]objectForKey:@"lng"] forKey:@"longitude"];
                        [locationdictionary setObject:[[resultsArray objectAtIndex:l]objectForKey:@"name"] forKey:@"name"];
                        [locationdictionary setObject:[[resultsArray objectAtIndex:l]objectForKey:@"vicinity"] forKey:@"address"];
                        [self.LocationArray addObject:locationdictionary];
                        
                    }
                    
                    //   NSLog(@"locationdict----------> %@", LocationArray);
                }
                else
                {
                    
                }
                
            }];
        }
    }];

    
    map_backview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
    
    map_backview.backgroundColor=[UIColor blackColor];
    [self.view addSubview:map_backview];
   // [map_backview setHidden:YES];
    
    headedit=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
    headedit.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar.png"]];
    [map_backview addSubview:headedit];
    
    UIImageView *mapheading=[[UIImageView alloc]initWithFrame:CGRectMake(120, 25, 183/2, 30)];
    mapheading.image=[UIImage imageNamed:@"topbar-logo"];
    [headedit addSubview:mapheading];
    
    UIImageView *back_map=[[UIImageView alloc]initWithFrame:CGRectMake(15, 30, 23/2, 41/2)];
    back_map.image=[UIImage imageNamed:@"left-arrow_new"];
    [headedit addSubview:back_map];
    
    
    UIView *backview=[[UIView alloc]initWithFrame:CGRectMake(0, 15, 60, 45)];
    backview.backgroundColor=[UIColor clearColor];
    [headedit addSubview:backview];
    
    ////////////////////////////////
    UITapGestureRecognizer *back_tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(done_locatr)];
    [backview addGestureRecognizer:back_tap];
    backview.userInteractionEnabled=YES;
    
    googlebackview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
    
    googlebackview.backgroundColor=[UIColor blackColor];
    [self.view addSubview:googlebackview];
    [googlebackview setHidden:YES];
    
    
    headedit=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
    headedit.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar.png"]];
    [googlebackview addSubview:headedit];
    
    UIImageView *mapheadingq=[[UIImageView alloc]initWithFrame:CGRectMake(120, 25, 183/2, 30)];
    mapheadingq.image=[UIImage imageNamed:@"topbar-logo"];
    [headedit addSubview:mapheadingq];
    
    UIImageView *back_mapq=[[UIImageView alloc]initWithFrame:CGRectMake(15, 30, 23/2, 41/2)];
    back_mapq.image=[UIImage imageNamed:@"left-arrow_new"];
    [headedit addSubview:back_mapq];
    
    
    UIView *backviewq=[[UIView alloc]initWithFrame:CGRectMake(0, 15, 60, 45)];
    backviewq.backgroundColor=[UIColor clearColor];
    [headedit addSubview:backviewq];
    
    ////////////////////////////////
    UITapGestureRecognizer *back_tapq=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(done_goole)];
    [backviewq addGestureRecognizer:back_tapq];
    backviewq.userInteractionEnabled=YES;
    
    //    UIButton *done_map=[[UIButton alloc]initWithFrame:CGRectMake(265,30,50, 25)];
    //    done_map.backgroundColor= [UIColor clearColor];
    //    [done_map addTarget:self action:@selector(done_locatr) forControlEvents:UIControlEventTouchUpInside];
    //    [done_map setTitle:@"Done" forState:UIControlStateNormal];
    //    [done_map setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    done_map.titleLabel.font =[UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:16];
    //    done_map.clipsToBounds=YES;
    //    done_map.layer.cornerRadius=5;
    //    [done_map setSelected:YES];
    //
    //    [headedit addSubview:done_map];
    
    
    
    map_View = [[MKMapView alloc] initWithFrame:CGRectMake(0, 70, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
    
    map_View.mapType=MKMapTypeStandard;
    [map_View setDelegate:self];
    [map_backview addSubview:map_View];


    
    
    NSString *urlString;
    data_retrived = [[NSMutableArray alloc] init];
    
    urlString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=true",self.currentlocationlat,self.currentlocationlong];
    
    NSLog(@" %@",urlString);
    NSURL *requestURL = [NSURL URLWithString:urlString];
    NSError* error = nil;
    NSLog(@"%@", urlString);
    NSData *signeddataURL =  [NSData dataWithContentsOfURL:requestURL options:NSDataReadingUncached error:&error];
    
    NSMutableDictionary *result = [NSJSONSerialization
                                   JSONObjectWithData:signeddataURL //1
                                   
                                   options:kNilOptions
                                   error:&error];
    
    for(NSMutableDictionary *dict in result)
    {
        [data_retrived addObject:dict];
        
    }
    
    streetAdd = [[[result objectForKey:@"results"] objectAtIndex:0] objectForKey:@"formatted_address"];
    
    
    
    
   // [map_backview setHidden:NO];
    [map_View addAnnotations:[self annotations]];

    // Do any additional setup after loading the view.
}
- (NSArray *)annotations {
    // Empire State Building
    
    
    NSMutableArray *locarryret = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<self.LocationArray.count; i++) {
        
        JPSThumbnail *empire = [[JPSThumbnail alloc] init];
        empire.image = [UIImage imageNamed:@"imageicon"];
        empire.title =[[self.LocationArray objectAtIndex:i] objectForKey:@"name"];
        empire.subtitle =[[self.LocationArray objectAtIndex:i] objectForKey:@"address"];
        empire.coordinate = CLLocationCoordinate2DMake([[[self.LocationArray objectAtIndex:i] objectForKey:@"latitude"] floatValue],[[[self.LocationArray objectAtIndex:i] objectForKey:@"longitude"] floatValue]);
        empire.disclosureBlock1 = ^{
            
            
            
            [googlebackview setHidden:NO];
            UIWebView *gwebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 70, 320,[[UIScreen mainScreen]bounds].size.height-70)];
            gwebView.delegate=self;
            [googlebackview addSubview:gwebView];
            
            
            NSURL *url3 = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.google.com/maps?saddr=%@&daddr=%@",[streetAdd stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[[self.LocationArray objectAtIndex:i] objectForKey:@"address"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
            NSURLRequest *requestObj = [NSURLRequest requestWithURL:url3];
            [gwebView loadRequest:requestObj];
            
            //            QTMapDetailsViewController *MapDetails = [[QTMapDetailsViewController alloc]init];
            //            [MapDetails setCurrentlocationlat:self.latitude];
            //            [MapDetails setCurrentlocationlong:self.longitude];
            //            [MapDetails setDestinationlat:[[[LocationArray objectAtIndex:i] objectForKey:@"latitude"] floatValue]];
            //            [MapDetails setDestinationlong:[[[LocationArray objectAtIndex:i] objectForKey:@"longitude"] floatValue]];
            //            [MapDetails setAddress:[[LocationArray objectAtIndex:i] objectForKey:@"address"]];
            //            [self presentViewController:MapDetails animated:YES completion:nil];
            
        };
        
        empire.disclosureBlock = ^{
            
        };
        
        [locarryret addObject:[JPSThumbnailAnnotation annotationWithThumbnail:empire]];

    };
    
    

    CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(self.currentlocationlat,self.currentlocationlong);
    MKCoordinateRegion adjustedRegion = [map_View regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 1000, 1000)];
    [map_View setRegion:adjustedRegion animated:YES];
    //  [self.imagegif removeFromSuperview];
    //[spinerview removeFromSuperview];
    
    return locarryret;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didSelectAnnotationViewInMap:mapView];
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didDeselectAnnotationViewInMap:mapView];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation conformsToProtocol:@protocol(JPSThumbnailAnnotationProtocol)]) {
        return [((NSObject<JPSThumbnailAnnotationProtocol> *)annotation) annotationViewInMap:mapView];
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)done_locatr
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    CLLocation *currentLocation = newLocation;
    
    
    //[locationManager stopUpdatingLocation];
    if (currentLocation != nil) {
        
        
        
        self.currentlocationlat=  currentLocation.coordinate.latitude;
        self.currentlocationlong=  currentLocation.coordinate.longitude;
        

        [self viewDidLoad];
        
    }
    
    // this creates a MKReverseGeocoder to find a placemark using the found coordinates
    
    
    //stops didUpdateToLocation to be called infinite times
    
}
-(void)done_goole
{
    [googlebackview setHidden:YES];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"entry");
    
    //if (![webstr isEqualToString:@"www.abc.com"])
    // {
    
    indicatorview=[[UIView alloc]initWithFrame:CGRectMake(137,170,50,50)];
    indicatorview.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:.5];
    indicatorview.layer.cornerRadius=10;
    [webView addSubview:indicatorview];
    
    
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame=CGRectMake(15,15, 20, 20);
    [indicator startAnimating];
    
    [indicatorview addSubview:indicator];
    
    // }
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [indicatorview removeFromSuperview];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    alrtview=[[UIAlertView alloc]initWithTitle:@"Failed !" message:@"No Internet Connection" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alrtview show];
    [alrtview setHidden:NO];
    [indicatorview removeFromSuperview];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
