//
//  ViewController.h
//  WeatherForcastingDemo
//
//  Created by Shailendra on 09/04/15.
//  Copyright (c) 2015 Redbytes. All rights reserved.//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SVGeocoder.h"
#import "SVPlacemark.h"
#import "Defines.h"
#import "WeatherForecastDataFetcher.h"
#import "DetailViewController.h"
#import "WeatherListCustomCell.h"

@interface MainViewController : UIViewController<CLLocationManagerDelegate,WeatherForecastDataFetcherDelegate,WeatherListCustomCellDelegate,UITableViewDataSource,UITableViewDelegate>
{
    CLGeocoder        * geocoder;
    CLLocationManager * locationMgr;
    CLLocation *location;
    WeatherForecastDataFetcher * weatherDF;
    NSMutableArray * cityInfoArr;
}
@end
