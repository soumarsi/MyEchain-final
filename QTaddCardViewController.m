//
//  QTaddCardViewController.m
//  MyEchain
//
//  Created by maxcon8 on 22/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "QTaddCardViewController.h"
#import "QTaddScanViewController.h"
#import "UIImageView+WebCache.h"
#import "QTcardarr.h"

@interface QTaddCardViewController ()
{
    QTfooterTab *footerview;
    
}
@end

@implementation QTaddCardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"QTaddCardViewController");
    
	// Do any additional setup after loading the view.
    
    mainview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height )];
    mainview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"1-splashbg-1"]];
    [self.view addSubview:mainview];
    
    
    headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
    headview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar.png"]];
    [mainview addSubview:headview];
    
    
//    headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
//    headview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bottom-bar.png"]];
//    [mainview addSubview:headview];

    
//    UIImageView *headimg=[[UIImageView alloc]initWithFrame:CGRectMake(120, 25, 183/2, 30)];
//    headimg.image=[UIImage imageNamed:@"topbar-logo"];
//    [headview addSubview:headimg];

    UILabel *head_lb=[[UILabel alloc]initWithFrame:CGRectMake(0,30, 320, 29.5f)];
    head_lb.text=@"Available Cards";
    head_lb.textAlignment=NSTextAlignmentCenter;
    head_lb.textColor=[UIColor whiteColor];
    head_lb.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:20];
    [headview addSubview:head_lb];
    
//    UIView *searchback=[[UIView alloc]initWithFrame:CGRectMake(0, headview.frame.origin.y+headview.frame.size.height,[[UIScreen mainScreen]bounds].size.width, 30)];
//   // searchback.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"row.png"]];
//    [mainview addSubview:searchback];
   
    
    UIView *bach_srch=[[UIView alloc]initWithFrame:CGRectMake(0, headview.frame.origin.y+headview.frame.size.height,[[UIScreen mainScreen]bounds].size.width, 30)];
    bach_srch.backgroundColor=[UIColor whiteColor];
    [mainview addSubview:bach_srch];
    
    MySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, headview.frame.origin.y+headview.frame.size.height,[[UIScreen mainScreen]bounds].size.width, 30)];
    [MySearchBar setBackgroundColor:[UIColor clearColor]];
    [MySearchBar setDelegate:self];
   // MySearchBar.barTintColor = [UIColor colorWithRed:(141/255.0f) green:(171/255.0f) blue:(217/255.0f) alpha:1];
MySearchBar.barTintColor = [UIColor whiteColor];
    //    [userSearch sizeToFit];
    [mainview addSubview:MySearchBar];
    
//    //setting textcolor to searchbar
//    UITextField *searchField = [MySearchBar valueForKey:@"_searchField"];
//    searchField.textColor = [UIColor blackColor];
//    [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
//    
//    [[UISearchBar appearance] setSearchFieldBackgroundImage:[UIImage imageNamed:@""]forState:UIControlStateNormal];
//    
//    //hides search icon from left of bar
//    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setLeftViewMode:UITextFieldViewModeNever];
//    
    @try {
        
    indexes = [NSMutableArray arrayWithObjects:@"7",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
    
    testtable=[[UITableView alloc]initWithFrame:CGRectMake(0, MySearchBar.frame.origin.y+MySearchBar.frame.size.height, 320,390+30) style:UITableViewStylePlain];
    testtable.backgroundColor=[UIColor clearColor];
    [testtable.layer setBorderColor:[[UIColor blackColor] CGColor]];
    testtable.separatorStyle = UITableViewCellSeparatorStyleNone;
    testtable.showsVerticalScrollIndicator = NO;
    testtable.tag = 1;
    testtable.delegate=self;
    testtable.dataSource=self;
    
    [mainview addSubview:testtable];
    
    
//    imgspin = [[UIImageView alloc] initWithFrame:CGRectMake(110, 180, 100, 100)];
//    [imgspin setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.56]];
//    // imgspin.backgroundColor=[UIColor blackColor];
//    [imgspin setUserInteractionEnabled:NO];
//    imgspin.clipsToBounds=YES;
//    imgspin.layer.cornerRadius=20;
//    [[imgspin layer] setZPosition:2];
//    [mainview addSubview:imgspin];
//    
//
//    //start loader animation
//    
//    spinnern = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    spinnern.hidesWhenStopped = YES;
//    spinnern.backgroundColor=[UIColor clearColor];
//    
//    spinnern.frame=CGRectMake(25,25,50,50);
//    [imgspin addSubview: spinnern];
//     [spinnern startAnimating];
//        
//        
//        UILabel *loadlb=[[UILabel alloc]initWithFrame:CGRectMake(0, 75, 100, 20)];
//        loadlb.text=@"syncing on...";
//        loadlb.textAlignment=NSTextAlignmentCenter;
//        loadlb.font=[UIFont systemFontOfSize:13];
//        loadlb.textColor=[UIColor whiteColor];
//        [imgspin addSubview:loadlb];
        
        
        
        
        
        nodata = [[UILabel alloc] initWithFrame:CGRectMake(0, 250, 320, 40)];
        
        nodata.backgroundColor=[UIColor clearColor];
        
        nodata.textAlignment=NSTextAlignmentCenter;
        
        nodata.textColor=[UIColor blackColor];
        
        nodata.text = @"No result found";
        
        nodata.font = [UIFont systemFontOfSize:20];
        [self.view addSubview:nodata];
        [nodata setHidden:YES];

    //=======footerview
        
        
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"inhome"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    
    footerview = [[QTfooterTab alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-98/2, 320.0f,98/2)];
    [footerview.card setSelected:YES];
    [footerview.card_bg setHidden:NO];
    footerview.card_bg.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"select-bottombg"]];
    [self.view addSubview:footerview];
    }
    @catch (NSException *exception) {
        NSLog(@"the exception is%@ ",exception.reason);
    }
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
    locktxt.delegate=self;
    //passwrdtxt.text=@"123456";
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
    
    
   
    
    
    
}


-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
   
    [[NSUserDefaults standardUserDefaults]setObject:@"cardlist" forKey:@"cur_page"];
    
        //to stop sliding view
    
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled=NO;
        }
    
    
    
    
    con_array=[[NSMutableArray alloc]init];
    filtered_arr=[[NSMutableArray alloc]init];
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.plist"]; //3
    
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    
    
    if (![fileManager fileExistsAtPath: path]) //4
        
    {
        
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"]; //5
        
        
        
        [fileManager copyItemAtPath:bundle toPath: path error:&error]; //6
        
    }
        
    //if (firsttym) {
        [self readdata];
        
    //}
    
    
    
    [self performSelectorInBackground:@selector(urlfetch) withObject:nil];
  

    
}
-(void)urlfetch
{
    
    QTcardarr *obj=[QTcardarr getInstance];
//    NSLog(@"object array--->%@",obj.card_arr) ;

   con_array=[[NSMutableArray alloc]init];
//    NSString *urlString1;
//    
//    NSError *error=nil;
//    
//    urlString1 =[NSString stringWithFormat:@"%@company_list.php",APPS_DOMAIN_URL];  //
//    
//   NSLog(@"eta holo category:  %@",urlString1);
//    
//    NSURL *requestURL1 = [NSURL URLWithString:urlString1];
//    
//    NSData *signeddataURL1 =  [NSData dataWithContentsOfURL:requestURL1 options:NSDataReadingUncached error:&error];
//    
//    
//    search_arr=[[NSMutableArray alloc]init];
//    
//    con_array = [NSJSONSerialization
//                                    
//                                    JSONObjectWithData:signeddataURL1
//                                    
//                                    
//                                    
//                                    options:kNilOptions
//                                    
//                                    error:&error];
    
    con_array=obj.card_arr;
    
    
        
    
 add_contacts_dict =[[NSMutableDictionary alloc]init];

    
    
    for (int ij =0; ij< [con_array count]; ij++)
    {
        if ([[[con_array objectAtIndex:ij] objectForKey:@"name"] length]>0) {
           
            if (![[[[con_array objectAtIndex:ij] objectForKey:@"name"] substringToIndex:1]isEqualToString:@" "]) {
                //NSLog(@"con_array name==%@",[[con_array objectAtIndex:ij] objectForKey:@"name"]);

                [search_arr addObject:[[con_array objectAtIndex:ij] objectForKey:@"name"]];
                
                /////////////////////////////////////////////////
                
                
                NSString *newString = [[[[con_array objectAtIndex:ij] objectForKey:@"name"] substringToIndex:1] lowercaseString];
               // NSLog(@"newString====%@",newString);
                NSCharacterSet *strCharSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_"];//1234567890_"];
                
                strCharSet = [strCharSet invertedSet];
                //And you can then use a string method to find if your string contains anything in the inverted set:
                
                NSRange r = [newString rangeOfCharacterFromSet:strCharSet];
                if (r.location != NSNotFound) {
                    //            //NSLog(@"the string contains illegal characters");
                }
                else
                {
                    if (add_contacts_dict[newString])
                    {
                        //            //NSLog(@"Exists %@",[add_contacts_dict objectForKey:newString]);
                        NSMutableArray *checkarr =[[NSMutableArray alloc]init];
                        for (NSDictionary *check in [add_contacts_dict objectForKey:newString] )
                        {
                            [checkarr addObject:check];
                        }
                        [checkarr addObject:[con_array objectAtIndex:ij]];
                        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
                        NSArray *sortedArray=[checkarr sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
                        
                        //            //NSLog(@"checkarray exists: %@",checkarr1);
                        [add_contacts_dict removeObjectForKey:newString];
                        [add_contacts_dict setObject:sortedArray forKey:newString];
                    }
                    else
                    {
                        NSMutableArray *checkarr1 =[[NSMutableArray alloc]init];
                        [checkarr1 addObject:[con_array objectAtIndex:ij]];
                        //            [add_contacts_dict setObject:[con_array objectAtIndex:ij] forKey:newString];
                        [add_contacts_dict setObject:checkarr1 forKey:newString];
                        
                    }//end else
                    
                }//end else not illigal character
                
               ////////////////////////////////////////////
                
            }//end if first character space

            else
            {
            //cut first white space here
                               //NSLog(@"con_array name==%@",[[con_array objectAtIndex:ij] objectForKey:@"name"]);
            
            
            }
            

        }//end if blank character
        
       
    }//end for
    
    //NSLog(@"dict final: %@",add_contacts_dict);
    final_con_array= [[NSMutableArray alloc]init];
    for (NSDictionary *dict in add_contacts_dict)
        [final_con_array addObject:dict];
    
    
    NSLog(@"search_arr==%@",search_arr);
    NSLog(@"search_arr count===%lu",(unsigned long)search_arr.count);
    
    [imgspin setHidden:YES];
    [spinnern stopAnimating];
   // [self writedata];
    [testtable reloadData];

}
-(void)readdata
{

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.plist"]; //3
    
    NSMutableArray *savedStock = [[NSMutableArray alloc] initWithContentsOfFile: path];
    
    con_array = [savedStock mutableCopy];
   // NSLog(@"con_array==%@",con_array);


}
-(void)writedata
{

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    
    
    
    NSMutableArray *data ;
    
   // if (loadfromwebagain == 0)
        
        data = [con_array mutableCopy];
    
  //  else
        
   //     data= [new_con_array mutableCopy];
    
    
    
    //here add elements to data file and write data to file
    
    
    
    [data writeToFile: path atomically:YES];


}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
           dictkeysarr = [[add_contacts_dict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        NSString *sectionTitle = [dictkeysarr objectAtIndex:section];
        NSMutableArray *sectioncontacts = [[NSMutableArray alloc]init];
        for (NSArray *di in [add_contacts_dict objectForKey:sectionTitle])
        {
            [sectioncontacts addObject:di];
        }
        return [sectioncontacts count];
    

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  
    return [final_con_array count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *tblHeaderV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 35)];
    //tblHeaderV.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bar1.png"]];
    tblHeaderV.backgroundColor =[UIColor colorWithRed:(151.0f/255.0f) green:(179.0f/255.0f) blue:(219/255.0f) alpha:1];
    
    UILabel *headlb=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 300, 35)];
     if (MySearchBar.text.length == 0)
    headlb.text=[NSString stringWithFormat:@"%@",[indexes objectAtIndex:section]];

   else
    headlb.text=[NSString stringWithFormat:@"%@",[[final_con_array objectAtIndex:0]uppercaseString]];
    
    headlb.textColor=[UIColor whiteColor];
    [tblHeaderV addSubview:headlb];
    
    
    
    
    return tblHeaderV;
    
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.backgroundColor =[UIColor clearColor];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    
    UIImageView *cellback=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 82/2)];
    cellback.image=[UIImage imageNamed:@"row"];
    [cell addSubview:cellback];
    
    NSString *sectionTitle = [dictkeysarr objectAtIndex:indexPath.section];
    sectionContactsArray = [add_contacts_dict objectForKey:sectionTitle];
    filtered_arr=[sectionContactsArray mutableCopy];
   // NSLog(@"sectionContactsArray======%@",[[sectionContactsArray objectAtIndex:indexPath.row]objectForKey:@"name"]);
    

    
    UIImageView *cmpny_img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 41)];
     [cmpny_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[sectionContactsArray objectAtIndex:indexPath.row]objectForKey:@"photo"]]] placeholderImage:[UIImage imageNamed:@"newplaceholder"] options:0 == 0?SDWebImageRefreshCached : 0];
    //cmpny_img.image=[UIImage imageNamed:@"logo-1.png"];
    [cellback addSubview:cmpny_img];
    
    UILabel *crdname=[[UILabel alloc]initWithFrame:CGRectMake(60, 0, 270, 40)];
   crdname.text=[[sectionContactsArray objectAtIndex:indexPath.row]objectForKey:@"name"];
    crdname.font=[UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:16];
    //crdname.text=[search_arr objectAtIndex:indexPath.row];
    [cellback addSubview:crdname];
    

    cell.backgroundColor=[UIColor clearColor];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 43;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView

{
    
    if (filter==0)
        
        return indexes;
    
    else
        
        return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"cardadd"];
    
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"scantap"];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"edit_card"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    NSString *sectionTitle = [dictkeysarr objectAtIndex:indexPath.section];
   sectionContactsArray = [add_contacts_dict objectForKey:sectionTitle];
    
    NSString *cmpny_name=[[sectionContactsArray objectAtIndex:indexPath.row]objectForKey:@"name"];
    NSString *cmpny_id=[[sectionContactsArray objectAtIndex:indexPath.row]objectForKey:@"id"];
    
    NSString *cmpny_img=[[sectionContactsArray objectAtIndex:indexPath.row]objectForKey:@"photo"];
    
    NSLog(@"imgghhjjk==%@",cmpny_img);
    
   
    
    QTScanCodeViewController *cardpg=[[QTScanCodeViewController alloc]init];
    
    
    
    cardpg.cmp_name=cmpny_name;
    cardpg.cmp_id=cmpny_id;
    cardpg.cmp_image=cmpny_img;
    [self.navigationController pushViewController:cardpg animated:NO];
  
    
//   QTaddScanViewController *cardpg=[[QTaddScanViewController alloc]init];
//    cardpg.company_name=cmpny_name;
//    cardpg.company_id=cmpny_id;
//    [self.navigationController pushViewController:cardpg animated:NO];
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [MySearchBar resignFirstResponder];
    [MySearchBar setShowsCancelButton:NO];
    
    NSLog(@"CancelButtonClicked");
    
     [nodata setHidden:YES];
    [testtable reloadData];
     [testtable setHidden:NO];
    
    
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  
    [MySearchBar resignFirstResponder];
    [MySearchBar setShowsCancelButton:NO];
    
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    [MySearchBar resignFirstResponder];
    [MySearchBar setShowsCancelButton:NO];
    
    NSLog(@"searchBarTextDidEndEditing");
    
    [nodata setHidden:YES];
    [testtable reloadData];
    [testtable setHidden:NO];
    

}
//textfield delegate method
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
[textField resignFirstResponder];
    return YES;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    
    return YES;
}
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//    
//    
//    
//    if(searchBar.text.length > 0) {
//        NSLog(@"searchbar is");
//        [searchBar setShowsCancelButton:YES];
//        
//        NSPredicate *pred = [NSPredicate predicateWithFormat:@"name beginswith[c] %@", searchBar.text];
//        
//        sectionContactsArray = [[filtered_arr filteredArrayUsingPredicate:pred] mutableCopy];
//        NSLog(@"the cout after sorting=%lu",(unsigned long)sectionContactsArray.count);
//        [testtable reloadData];
//    }
//    else {
//        NSLog(@"searchbar is NOT");
//        
//        sectionContactsArray = [filtered_arr copy];
//        [testtable reloadData];
//        
//    }
//    
//    [testtable setHidden:NO];
//    
//    
//    
//    
//    
//    
//    
//    
//}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    result=[[NSArray alloc]init];
    [searchBar setShowsCancelButton:YES];
    
    pred = [NSPredicate predicateWithFormat:@"name beginswith[cd] %@", MySearchBar.text];
    
    result=[con_array filteredArrayUsingPredicate:pred];
     //NSLog(@"result........%@",result);
    
       ////////////////////////////
    if (MySearchBar.text.length == 0)
    {
    
        add_contacts_dict =[[NSMutableDictionary alloc]init];
        for (int ij =0; ij< [con_array count]; ij++)
        {
            if ([[[con_array objectAtIndex:ij] objectForKey:@"name"] length]>0) {
                
                if (![[[[con_array objectAtIndex:ij] objectForKey:@"name"] substringToIndex:1]isEqualToString:@" "]) {
                    //  NSLog(@"result name==%@",[[result objectAtIndex:ij] objectForKey:@"name"]);
                    
                    
                    
                    /////////////////////////////////////////////////
                    
                    
                    NSString *newString = [[[[con_array objectAtIndex:ij] objectForKey:@"name"] substringToIndex:1] lowercaseString];
                    // NSLog(@"newString====%@",newString);
                    NSCharacterSet *strCharSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_"];//1234567890_"];
                    
                    strCharSet = [strCharSet invertedSet];
                    //And you can then use a string method to find if your string contains anything in the inverted set:
                    
                    NSRange r = [newString rangeOfCharacterFromSet:strCharSet];
                    if (r.location != NSNotFound) {
                        //            //NSLog(@"the string contains illegal characters");
                    }
                    else
                    {
                        if (add_contacts_dict[newString])
                        {
                            //            //NSLog(@"Exists %@",[add_contacts_dict objectForKey:newString]);
                            NSMutableArray *checkarr =[[NSMutableArray alloc]init];
                            for (NSDictionary *check in [add_contacts_dict objectForKey:newString] )
                            {
                                [checkarr addObject:check];
                            }
                            [checkarr addObject:[con_array objectAtIndex:ij]];
                            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
                            NSArray *sortedArray=[checkarr sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
                            
                            //            //NSLog(@"checkarray exists: %@",checkarr1);
                            [add_contacts_dict removeObjectForKey:newString];
                            [add_contacts_dict setObject:sortedArray forKey:newString];
                        }
                        else
                        {
                            NSMutableArray *checkarr1 =[[NSMutableArray alloc]init];
                            [checkarr1 addObject:[con_array objectAtIndex:ij]];
                            //            [add_contacts_dict setObject:[con_array objectAtIndex:ij] forKey:newString];
                            [add_contacts_dict setObject:checkarr1 forKey:newString];
                            
                        }//end else
                        
                    }//end else not illigal character
                    
                    ////////////////////////////////////////////
                    
                }//end if first character space
                
                else
                {
                    //cut first white space here
                    //NSLog(@"con_array name==%@",[[con_array objectAtIndex:ij] objectForKey:@"name"]);
                    
                    
                }
                
                
            }//end if blank character
            
            
        }//end for
        
        //NSLog(@"dict final: %@",add_contacts_dict);
        final_con_array= [[NSMutableArray alloc]init];
        for (NSDictionary *dict in add_contacts_dict)
            [final_con_array addObject:dict];
        
        NSLog(@"final_con_array==%@",final_con_array);
        ///////////////////////////
        [nodata setHidden:YES];
        [testtable setHidden:NO];
        [testtable reloadData];
    
    }
    else
    {
      
        if (result.count==0) {
            NSLog(@"no data");
            [testtable setHidden:YES];
            [nodata setHidden:NO];
        }
      else
      {
          [testtable setHidden:NO];
          [nodata setHidden:YES];
     add_contacts_dict =[[NSMutableDictionary alloc]init];
    for (int ij =0; ij< [result count]; ij++)
    {
        if ([[[result objectAtIndex:ij] objectForKey:@"name"] length]>0) {
            
            if (![[[[result objectAtIndex:ij] objectForKey:@"name"] substringToIndex:1]isEqualToString:@" "]) {
              //  NSLog(@"result name==%@",[[result objectAtIndex:ij] objectForKey:@"name"]);
                
                
                
                /////////////////////////////////////////////////
                
                
                NSString *newString = [[[[result objectAtIndex:ij] objectForKey:@"name"] substringToIndex:1] lowercaseString];
                // NSLog(@"newString====%@",newString);
                NSCharacterSet *strCharSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_"];//1234567890_"];
                
                strCharSet = [strCharSet invertedSet];
                //And you can then use a string method to find if your string contains anything in the inverted set:
                
                NSRange r = [newString rangeOfCharacterFromSet:strCharSet];
                if (r.location != NSNotFound) {
                    //            //NSLog(@"the string contains illegal characters");
                }
                else
                {
                    if (add_contacts_dict[newString])
                    {
                        //            //NSLog(@"Exists %@",[add_contacts_dict objectForKey:newString]);
                        NSMutableArray *checkarr =[[NSMutableArray alloc]init];
                        for (NSDictionary *check in [add_contacts_dict objectForKey:newString] )
                        {
                            [checkarr addObject:check];
                        }
                        [checkarr addObject:[result objectAtIndex:ij]];
                        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
                        NSArray *sortedArray=[checkarr sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
                        
                        //            //NSLog(@"checkarray exists: %@",checkarr1);
                        [add_contacts_dict removeObjectForKey:newString];
                        [add_contacts_dict setObject:sortedArray forKey:newString];
                    }
                    else
                    {
                        NSMutableArray *checkarr1 =[[NSMutableArray alloc]init];
                        [checkarr1 addObject:[result objectAtIndex:ij]];
                        //            [add_contacts_dict setObject:[con_array objectAtIndex:ij] forKey:newString];
                        [add_contacts_dict setObject:checkarr1 forKey:newString];
                        
                    }//end else
                    
                }//end else not illigal character
                
                ////////////////////////////////////////////
                
            }//end if first character space
            
            else
            {
                //cut first white space here
                //NSLog(@"con_array name==%@",[[con_array objectAtIndex:ij] objectForKey:@"name"]);
                
                
            }
            
            
        }//end if blank character
        
        
    }//end for
    
    //NSLog(@"dict final: %@",add_contacts_dict);
    final_con_array= [[NSMutableArray alloc]init];
    for (NSDictionary *dict in add_contacts_dict)
        [final_con_array addObject:dict];
    
    NSLog(@"final_con_array==%@",final_con_array);
    ///////////////////////////
    [testtable reloadData];
    }
    }
    
    //   [testtable setHidden:NO];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lock_popup) name:@"lockview" object:nil];
}
-(void)lock_popup
{

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
//        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"card_count"]==0) {
//            QTHomeViewController *home=[[QTHomeViewController alloc]init];
//            [self.navigationController pushViewController:home animated:NO];
//        }
//        else
//        {
//            
//            QTCardHomeViewController *home=[[QTCardHomeViewController alloc]init];
//            [self.navigationController pushViewController:home animated:NO];
//            
//            
//            
//        }
        
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
