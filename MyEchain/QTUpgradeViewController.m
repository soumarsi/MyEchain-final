//
//  QTUpgradeViewController.m
//  MyEchain
//
//  Created by Soumarsi Kundu on 18/03/15.
//  Copyright (c) 2015 Esolz. All rights reserved.
//

#import "QTUpgradeViewController.h"
#import "QTfooterTab.h"
#import "UIImageView+WebCache.h"

@interface QTUpgradeViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    UIView *mainview,*headview,*blackview,*lockview;
    QTfooterTab *footerview;
    UITextField *locktxt;
    UIButton *savebtn,*cancelbtn;
    NSMutableArray *expandedCells;
    NSOperationQueue *MainQueue;
    UIImageView *imgspin;
    UIActivityIndicatorView *spinnern;
    NSMutableArray *dealarr;
    UITableView *testtable;
    UIButton *cellbutton;
    UITextView *detailstext;
}

@end

@implementation QTUpgradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    expandedCells = [[NSMutableArray alloc]init];
    
    mainview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height )];
    mainview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"1-splashbg-1"]];
    [self.view addSubview:mainview];
    
    headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
    headview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar"]];
    [mainview addSubview:headview];
    
    UIImageView *headimg=[[UIImageView alloc]initWithFrame:CGRectMake(120, 25, 183/2, 30)];
    headimg.image=[UIImage imageNamed:@"topbar-logo"];
    [headview addSubview:headimg];
    
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"inhome"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    footerview = [[QTfooterTab alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-98/2, 320.0f,98/2)];
    [footerview.upgrade setSelected:YES];
    [footerview.upgrade_bg setHidden:NO];
    footerview.upgrade_bg.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"select-bottombg"]];
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
    //     [registerbtn setBackgroundImage:[UIImage imageNamed:@"register-nownew.png"] forState:UIControlStateNormal];
    savebtn.titleLabel.textColor=[UIColor blackColor];
    [savebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [savebtn  addTarget:self action:@selector(savelock) forControlEvents:UIControlEventTouchUpInside];
    [lockview addSubview: savebtn];
    
    cancelbtn=[[UIButton alloc]initWithFrame:CGRectMake(10, savebtn.frame.origin.y+savebtn.frame.size.height+10, 280, 30)];
    cancelbtn.backgroundColor=[UIColor whiteColor];
    [cancelbtn setTitle:@"Cancel" forState:UIControlStateNormal];
    //     [registerbtn setBackgroundImage:[UIImage imageNamed:@"register-nownew.png"] forState:UIControlStateNormal];
    cancelbtn.titleLabel.textColor=[UIColor blackColor];
    [cancelbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelbtn  addTarget:self action:@selector(cancellock) forControlEvents:UIControlEventTouchUpInside];
    [lockview addSubview:cancelbtn];
    
    
    imgspin = [[UIImageView alloc] initWithFrame:CGRectMake(110, 180, 100, 100)];
    [imgspin setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.56]];
    // imgspin.backgroundColor=[UIColor blackColor];
    [imgspin setUserInteractionEnabled:NO];
    imgspin.clipsToBounds=YES;
    imgspin.layer.cornerRadius=20;
    [[imgspin layer] setZPosition:2];
    // [mainview addSubview:imgspin];
    
    
    //start loader animation
    
    spinnern = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinnern.hidesWhenStopped = YES;
    spinnern.backgroundColor=[UIColor clearColor];
    
    spinnern.frame=CGRectMake(25,25,50,50);
    [imgspin addSubview: spinnern];
    
    NSOperationQueue *queue2 = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self
                                                                            selector:@selector(dataImport)
                                                                              object:nil];
    [queue2 addOperation:operation];

    // Do any additional setup after loading the view.
}
-(void)dataImport
{

    dispatch_async(dispatch_get_main_queue(), ^{

        
        dealarr=[[NSMutableArray alloc]init];
        NSString *urlString1;
        
        NSError *error=nil;
        
        
        //  urlString1 =[NSString stringWithFormat:@"%@company_deals.php?company_id=%@&start=0&limit=10",APPS_DOMAIN_URL,company_id];  //
        
        // urlString1 =[NSString stringWithFormat:@"%@deals_of_company.php?company_id=%@",APPS_DOMAIN_URL,company_id];
        
        urlString1 =[NSString stringWithFormat:@"http://esolz.co.in/lab1/Web/myEchain/Iosapp/push_noti.php?id=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"id"]];
        
        NSLog(@"url==%@",urlString1);
        
        NSURL *requestURL1 = [NSURL URLWithString:urlString1];
        
        NSData *signeddataURL1 =  [NSData dataWithContentsOfURL:requestURL1 options:NSDataReadingUncached error:&error];
        
        dealarr = [NSJSONSerialization JSONObjectWithData:signeddataURL1 options:kNilOptions error:&error];
        
        NSLog(@"dealarr====%@",dealarr);
        
        
        if ([dealarr count]==0) {
            
            UILabel *nodata=[[UILabel alloc]initWithFrame:CGRectMake(10, 150, 300, 20)];
            nodata.backgroundColor=[UIColor clearColor];
            nodata.text=@"No Notification Available";
            nodata.textColor=[UIColor whiteColor];
            nodata.textAlignment=NSTextAlignmentCenter;
            nodata.font=[UIFont boldSystemFontOfSize:20];
            [mainview addSubview:nodata];
        }
        else
        {
            testtable=[[UITableView alloc]initWithFrame:CGRectMake(0, headview.frame.origin.y+headview.frame.size.height+2, [[UIScreen mainScreen]bounds].size.width,[[UIScreen mainScreen]bounds].size.height-122) style:UITableViewStylePlain];
            testtable.backgroundColor=[UIColor clearColor];
            [testtable.layer setBorderColor:[[UIColor blackColor] CGColor]];
            testtable.separatorStyle = UITableViewCellSeparatorStyleNone;
            testtable.showsVerticalScrollIndicator = NO;
            testtable.tag = 1;
            testtable.delegate=self;
            testtable.dataSource=self;
            
            [mainview addSubview:testtable];
        }
        
        [imgspin setHidden:YES];
        [spinnern stopAnimating];
        
        
    });
   
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:NO];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dealarr count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.backgroundColor =[UIColor clearColor];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    

 if ([[NSString stringWithFormat:@"%@",[[dealarr objectAtIndex:indexPath.row]objectForKey:@"link"]] isKindOfClass:[NSNull class]] || [NSString stringWithFormat:@"%@",[[dealarr objectAtIndex:indexPath.row]objectForKey:@"link"]] ==(id)[NSNull null] || [[NSString stringWithFormat:@"%@",[[dealarr objectAtIndex:indexPath.row]objectForKey:@"link"]] isEqualToString:@""])
 {
     
        cellback=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 64)];
        cellback.image=[UIImage imageNamed:@"row_deal"];
        cellback.userInteractionEnabled=YES;
        [cell addSubview:cellback];
        
        name=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 270, 30)];
        name.backgroundColor=[UIColor clearColor];
        name.userInteractionEnabled=YES;
        name.textColor = [UIColor whiteColor];
        name.text=[[[dealarr objectAtIndex:indexPath.row]objectForKey:@"title"]capitalizedString];
        name.font=[UIFont boldSystemFontOfSize:15];
        [cellback addSubview:name];
        
        sub_title=[[UILabel alloc]initWithFrame:CGRectMake(15, name.frame.origin.y+name.frame.size.height, 270, 15)];
        sub_title.backgroundColor=[UIColor clearColor];
        sub_title.numberOfLines=1;
        sub_title.userInteractionEnabled=YES;
        sub_title.text=[[dealarr objectAtIndex:indexPath.row]objectForKey:@"message"];
        sub_title.font=[UIFont systemFontOfSize:13];
        [cellback addSubview:sub_title];

     
        /////// RAHUL //////
     
        cellbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0,cellback.frame.size.width, cellback.frame.size.height-30)];
        cellbutton.backgroundColor=[UIColor clearColor];
        [cellback addSubview:cellbutton];
        cellbutton.tag=indexPath.row;
        [cellbutton addTarget:self action:@selector(expand:) forControlEvents:UIControlEventTouchUpInside];
        cellback.userInteractionEnabled=YES;
     
 }
    else
    {
        cellback=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 84)];
        cellback.image=[UIImage imageNamed:@"row_deal"];
        cellback.userInteractionEnabled=YES;
        [cell addSubview:cellback];
        
        name=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 270, 30)];
        name.backgroundColor=[UIColor clearColor];
        name.userInteractionEnabled=YES;
        name.textColor = [UIColor whiteColor];
        name.text=[[[dealarr objectAtIndex:indexPath.row]objectForKey:@"title"]capitalizedString];
        name.font=[UIFont boldSystemFontOfSize:15];
        [cellback addSubview:name];
        
        sub_title=[[UILabel alloc]initWithFrame:CGRectMake(15, name.frame.origin.y+name.frame.size.height, 270, 15)];
        sub_title.backgroundColor=[UIColor clearColor];
        sub_title.numberOfLines=1;
        sub_title.userInteractionEnabled=YES;
        sub_title.text=[[dealarr objectAtIndex:indexPath.row]objectForKey:@"message"];
        sub_title.font=[UIFont systemFontOfSize:13];
        [cellback addSubview:sub_title];
        
        link=[[UILabel alloc]initWithFrame:CGRectMake(15, sub_title.frame.origin.y+sub_title.frame.size.height, 270, 30)];
        link.backgroundColor=[UIColor clearColor];
        link.userInteractionEnabled=YES;
        link.textColor = [UIColor colorWithRed:(15/255.0f) green:(123/255.0f) blue:(255/255.0f) alpha:1];
        link.text=[[[dealarr objectAtIndex:indexPath.row]objectForKey:@"link"]capitalizedString];
        link.font=[UIFont systemFontOfSize:13];
        [cellback addSubview:link];
        
        
        
        
        /////// RAHUL //////
        
        
        
        
        cellbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0,cellback.frame.size.width, cellback.frame.size.height-30)];
        cellbutton.backgroundColor=[UIColor clearColor];
        [cellback addSubview:cellbutton];
        cellbutton.tag=indexPath.row;
        [cellbutton addTarget:self action:@selector(expand:) forControlEvents:UIControlEventTouchUpInside];
        cellback.userInteractionEnabled=YES;
        
        
        linkbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, cellback.frame.size.height-30,cellback.frame.size.width, 30)];
        linkbutton.backgroundColor=[UIColor clearColor];
        [cellback addSubview:linkbutton];
        linkbutton.tag=indexPath.row;
        [linkbutton addTarget:self action:@selector(link:) forControlEvents:UIControlEventTouchUpInside];
        link.userInteractionEnabled=YES;
    }
 
    BOOL test_presence = [self->expandedCells containsObject:indexPath];
    
    if (test_presence == YES)
    {
                    if ([[NSString stringWithFormat:@"%@",[[dealarr objectAtIndex:indexPath.row]objectForKey:@"link"]] isKindOfClass:[NSNull class]] || [NSString stringWithFormat:@"%@",[[dealarr objectAtIndex:indexPath.row]objectForKey:@"link"]] ==(id)[NSNull null] || [[NSString stringWithFormat:@"%@",[[dealarr objectAtIndex:indexPath.row]objectForKey:@"link"]] isEqualToString:@""])
                    {
                        detailstext=[[UITextView alloc]initWithFrame:CGRectMake(0, 63, cellback.frame.size.width, 100)];
                        detailstext.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:.2];
                        detailstext.delegate=self;
                        detailstext.text=[[dealarr objectAtIndex:indexPath.row]objectForKey:@"message"];
                        detailstext.font=[UIFont systemFontOfSize:13];
                        detailstext.editable=NO;
                        [cell.contentView addSubview:detailstext];
                        [sub_title setHidden:YES];
                        UILabel *name1=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 270, 70)];
                        name1.backgroundColor=[UIColor clearColor];
                        name1.userInteractionEnabled=YES;
                        name1.numberOfLines = 3;
                        name1.textColor = [UIColor whiteColor];
                        name1.text=[[[dealarr objectAtIndex:indexPath.row]objectForKey:@"title"]capitalizedString];
                        name1.font=[UIFont boldSystemFontOfSize:15];
                        [cell.contentView addSubview:name1];
                        [name setHidden:YES];
                    }
                    else{
            detailstext=[[UITextView alloc]initWithFrame:CGRectMake(0, 83, cellback.frame.size.width, 100)];
            detailstext.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:.2];
            detailstext.delegate=self;
            detailstext.text=[[dealarr objectAtIndex:indexPath.row]objectForKey:@"message"];
            detailstext.font=[UIFont systemFontOfSize:13];
            detailstext.editable=NO;
            [cell.contentView addSubview:detailstext];
            [sub_title setHidden:YES];
            
            
            
            UILabel *link1=[[UILabel alloc]initWithFrame:CGRectMake(0, 83+100, cellback.frame.size.width, 50)];
            link1.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:.2];
            link1.userInteractionEnabled=YES;
            link1.numberOfLines = 2;
            link1.textColor = [UIColor colorWithRed:(15/255.0f) green:(123/255.0f) blue:(255/255.0f) alpha:1];
            link1.text=[[[dealarr objectAtIndex:indexPath.row]objectForKey:@"link"]capitalizedString];
            link1.font=[UIFont systemFontOfSize:14];
            [cell.contentView addSubview:link1];
            [link setHidden:YES];
            
            UILabel *name1=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 270, 70)];
            name1.backgroundColor=[UIColor clearColor];
            name1.userInteractionEnabled=YES;
            name1.numberOfLines = 3;
            name1.textColor = [UIColor whiteColor];
            name1.text=[[[dealarr objectAtIndex:indexPath.row]objectForKey:@"title"]capitalizedString];
            name1.font=[UIFont boldSystemFontOfSize:15];
            [cell.contentView addSubview:name1];
            [name setHidden:YES];
            
            linkbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0,cellback.frame.size.width, cellback.frame.size.height)];
            linkbutton.backgroundColor=[UIColor clearColor];
            [link1 addSubview:linkbutton];
            linkbutton.tag=indexPath.row;
            [linkbutton addTarget:self action:@selector(link:) forControlEvents:UIControlEventTouchUpInside];
            link.userInteractionEnabled=YES;
                    }
        }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    cell.tag=indexPath.row;
    return cell;
    
    
    
    
}
-(void)expand:(UIButton *)sender
{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    if ([self->expandedCells containsObject:indexPath])
    {
        [self->expandedCells removeObject:indexPath];
    }
    else
    {
        [self->expandedCells addObject:indexPath];
    }
    [testtable beginUpdates];
    [testtable reloadRowsAtIndexPaths:@[indexPath]
                     withRowAnimation:UITableViewRowAnimationFade];
    
    [testtable endUpdates];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==testtable)
    {
        
        CGFloat kExpandedCellHeight = 235;
       CGFloat kNormalCellHeigh = 85;
        
        if ([self->expandedCells containsObject:indexPath])
        {
            return kExpandedCellHeight;
        }
        else
        {
            if ([[NSString stringWithFormat:@"%@",[[dealarr objectAtIndex:indexPath.row]objectForKey:@"link"]] isKindOfClass:[NSNull class]] || [NSString stringWithFormat:@"%@",[[dealarr objectAtIndex:indexPath.row]objectForKey:@"link"]] ==(id)[NSNull null] || [[NSString stringWithFormat:@"%@",[[dealarr objectAtIndex:indexPath.row]objectForKey:@"link"]] isEqualToString:@""])
            {
                return 65;
            }
            else
            {
            return kNormalCellHeigh;
            }
        }
    }
    return false;
    
}

-(void)link:(UIButton *)sender
{
    whiteview = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
    [whiteview setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:whiteview];
    
    
    Canclebutton = [[UIButton alloc]initWithFrame:CGRectMake(200, 50, 100, 40)];
    [Canclebutton setBackgroundColor:[UIColor clearColor]];
    [Canclebutton setTitle:@"Cancel" forState:UIControlStateNormal];
    [Canclebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Canclebutton.layer.borderWidth = 1.0f;
    Canclebutton.layer.borderColor= [[UIColor whiteColor]CGColor];
    Canclebutton.layer.cornerRadius = 5.0f;
    [Canclebutton addTarget:self action:@selector(Cancel:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Canclebutton];
    
    
    Linkimageview = [[UIImageView alloc]initWithFrame:CGRectMake(30, 150, self.view.frame.size.width-60, 250)];
    [self.view addSubview:Linkimageview];
    Linkimageview.clipsToBounds = YES;
     [Linkimageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[dealarr objectAtIndex:sender.tag]objectForKey:@"link"]]] placeholderImage:[UIImage imageNamed:@"placeholder"] options:0 == 0?SDWebImageRefreshCached : 0];
    
}
-(void)Cancel:(UIButton *)sender
{
    [whiteview removeFromSuperview];
    [Canclebutton removeFromSuperview];
    [Linkimageview removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
