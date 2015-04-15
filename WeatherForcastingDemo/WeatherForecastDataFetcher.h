//
//  WeatherForecastDataFetcher.h
//  WeatherForcastingDemo
//
//  Created by Shailendra on 09/04/15.
//  Copyright (c) 2015 Redbytes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityModel.h"

@protocol WeatherForecastDataFetcherDelegate <NSObject>

- (void) setCityWeatherInfo:(NSDictionary *) city DayArray:(NSArray *)dayArray;
- (void) errorNotification:(NSString*)errorMsg;

@end

@interface WeatherForecastDataFetcher : NSObject<NSURLConnectionDelegate>
{
    NSURLConnection * connection;
    
}
@property (strong, nonatomic) NSMutableData *responseData;
@property (nonatomic, assign) BOOL isDownloading;
@property (nonatomic, unsafe_unretained) id <WeatherForecastDataFetcherDelegate> delegate;

- (void)getWeatherHistoryForCity:(NSString *)cityName;
@end
