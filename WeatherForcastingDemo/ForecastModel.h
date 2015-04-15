//
//  ForecastModel.h
//  WeatherForcastingDemo
//
//  Created by Shailendra on 09/04/15.
//  Copyright (c) 2015 Redbytes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForecastModel : NSObject
//"forecast":[
//            //    {
//            //        "code":"11",
//            //        "date":"11 Mar 2014",
//            //        "day":"Tue",
//            //        "high":"69",
//            //        "low":"62",
//            //        "text":"Showers"
//

@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSDictionary * date;
@property (nonatomic, strong) NSDictionary * day;
@property (nonatomic, strong) NSString * high;
@property (nonatomic, strong) NSString * low;
@property (nonatomic, strong) NSDictionary * text;



@end
