//
//  DetailViewController.h
//  WeatherForcastingDemo
//
//  Created by Shailendra on 09/04/15.
//  Copyright (c) 2015 Redbytes. All rights reserved.
#import <UIKit/UIKit.h>
#import "CityModel.h"
#import "ForecastModel.h"

@interface DetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView * detailTableView;
}
@property (nonatomic,strong) CityModel *dataArr;
@property (nonatomic,strong) NSDictionary *city;
@property (nonatomic,strong) NSMutableArray *DayArray;

@end
