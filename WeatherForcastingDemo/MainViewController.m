//
//  ViewController.m
//  WeatherForcastingDemo
//
//  Created by Shailendra on 09/04/15.
//  Copyright (c) 2015 Redbytes. All rights reserved.//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"






#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define WAAppDelegate  ((AppDelegate *)[[UIApplication sharedApplication] delegate])
@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    AppDelegate * app;
    IBOutlet UITableView * cityWeatherListView;
    IBOutlet UITextField * citynameTextFiel;
    IBOutlet UIButton * getWeathetbtn;
    IBOutlet UIButton * locatebtn;
    NSArray *dayArray1;
    NSDictionary *city1;

}
- (IBAction)GetWeatherButtonAction:(id)sender;
- (IBAction)locateMeButtonAction:(id)sender;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    
    return self;
}
#pragma mark-View LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    app = WAAppDelegate;
    [self configureUI];
    //[self configureCurrentUserLocation];
   
    weatherDF = [[WeatherForecastDataFetcher alloc] init];
    [weatherDF setDelegate:self];
//    [self getWeatherforCitys:@[@"Pune",@"Delhi",@"Goa"]];

    
}

#pragma mark-Custom Design On controls
- (void)configureUI
{
    self.title = @"Weather Around";
    
    [cityWeatherListView.layer setBorderColor:[UIColor grayColor].CGColor];
    [cityWeatherListView.layer setBorderWidth:1];
    [cityWeatherListView.layer setCornerRadius:8];

    [getWeathetbtn.layer setBorderColor:[UIColor grayColor].CGColor];
    [getWeathetbtn.layer setBorderWidth:1];
    [getWeathetbtn.layer setCornerRadius:4];
    [locatebtn.layer setBorderColor:[UIColor grayColor].CGColor];
    [locatebtn.layer setBorderWidth:0.5];
    [locatebtn.layer setCornerRadius:4];

}

#pragma mark- UserLocation

-(void)configureCurrentUserLocation
{
    
    
    
    locationMgr = [[CLLocationManager alloc] init];
    //[tkLocationManager disallowDeferredLocationUpdates];
    [locationMgr setDelegate:self];
    locationMgr.distanceFilter = kCLDistanceFilterNone;
    locationMgr.desiredAccuracy = kCLLocationAccuracyBest;
    locationMgr.distanceFilter=10.0;
    
    if([CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied){
        [WAAppDelegate showHUDActivityIndicator:@"Identifying Your location"];
        
        [locationMgr startUpdatingLocation];
    }
    else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Location Services are unavailable" message:@"Location cannot be determined" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
       // NSArray * cityArr = [[Utility sharedInstance] getCityDataFromPlist:City_Plist];
        
    }
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0")) {
        
        
        location = [locations lastObject];
        
        NSLog(@"STOP UPDATE: Update");
        
        CLGeocoder *clGeocoder = [[CLGeocoder alloc]init];
        [clGeocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            
            CLPlacemark *placeMark = [placemarks lastObject];
            
            //  NSDictionary * addressDict = [placeMark addressDictionary];
            
            for(CLPlacemark *placemark in placemarks){
                NSLog(@"location //// %@",[placemark location]);
                NSLog(@"locality  %@",[placemark locality]); }
            
            CLLocation *loc = [placeMark location];
            
            CLLocationCoordinate2D cor2D = [loc coordinate];
            
            
            [SVGeocoder reverseGeocode:cor2D completion:^(NSArray *placemarks, NSHTTPURLResponse *urlResponse, NSError *error) {
                if([placemarks count] > 6){
                    [locationMgr stopUpdatingLocation];
                    [WAAppDelegate hideHUDActivityIndicator];
                    NSDictionary *addDict = [placemarks objectAtIndex:5];
                    NSString *address = [addDict valueForKey:@"formattedAddress"];
                    NSArray *arr = [address componentsSeparatedByString:@","];
                    NSString *city = [arr objectAtIndex:0];
                    NSLog(@"The City is : %@ ", city);
                    
                    if (city) {
                        
                        [self getWeatherforCitys:@[city]];
                        
                        NSString * msg = [NSString stringWithFormat:@"Your location is identified as %@",city];
                        
                        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:msg message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                        [alert show];
                       
                    }
                    
                    if ([arr objectAtIndex:0] != nil) {
                 
                    }
                    
                }
                
                
            }];
        }];
        [locationMgr stopUpdatingLocation];
        
    }

}

#pragma mark - UItextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [citynameTextFiel resignFirstResponder];
    
    return YES;
}


#pragma mark - Button Action

- (IBAction)locateMeButtonAction:(id)sender
{
    [self configureCurrentUserLocation];
}


- (IBAction)GetWeatherButtonAction:(id)sender
{
    if (([citynameTextFiel.text isEqualToString:@""])) {
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Please enter city names" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }
    
    
    [self getWeatherforCitys:citynameTextFiel.text];
    [citynameTextFiel resignFirstResponder];
    
    [app showHUDActivityIndicator:@"Fetching data..."];
}

#pragma mark - Fetch City info
- (void) getWeatherforCitys : (NSString *) cityArr
{
    if (cityInfoArr) {
        cityInfoArr = nil;
    }
    cityInfoArr = [[NSMutableArray alloc] init];
    
    if (![cityArr isEqualToString:@""] ) {
        [weatherDF setIsDownloading:YES];
        
        
            [weatherDF getWeatherHistoryForCity:cityArr];
        
        
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"No City Name Entered" message:@"Please enter city name" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
        [app hideHUDActivityIndicator];
        
        [app hideHUDActivityIndicator];

        [app hideHUDActivityIndicator];


    }
    
    
    
}


#pragma mark - WeatherForecastDataFetcherDelegate

- (void) setCityWeatherInfo:(NSDictionary *)city DayArray:(NSArray *)dayArray
{
    dayArray1 = dayArray;
    city1=city;
    [cityWeatherListView reloadData];
    
    [app hideHUDActivityIndicator];

    
}

- (void) errorNotification:(NSString *)errorMsg
{
    [app hideHUDActivityIndicator];

}

#pragma mark - CityWetherList TableView Delegates


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [dayArray1 count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"WListCustomCell";
    //3
    WeatherListCustomCell *cell = (WeatherListCustomCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        NSArray *nibbb=[[NSBundle mainBundle] loadNibNamed:@"WeatherListCustomCell" owner:self options:nil];
        cell=(WeatherListCustomCell *) [nibbb objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    int i =(int) indexPath.row+1;
    
    cell.cityNameLbl.text = [NSString stringWithFormat:@"Day %d",i];
    
    
    
    
   
    
    return cell;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController * detailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DetailViewController"];
    
    detailVC.city=city1;
    detailVC.DayArray =[dayArray1 objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
 
    return 1;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
