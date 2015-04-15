//
//  WeatherForecastDataFetcher.m
//  WeatherForcastingDemo
//
//  Created by Shailendra on 09/04/15.
//  Copyright (c) 2015 Redbytes. All rights reserved.
//

#import "WeatherForecastDataFetcher.h"
#import "AppDelegate.h"

#define YQLQUERY_PREFIX @"http://query.yahooapis.com/v1/public/yql?q="
#define YQLQUERY_SUFFIX @"&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="




#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define WAAppDelegate  ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@implementation WeatherForecastDataFetcher



// Request API Method
- (void)getWeatherHistoryForCity:(NSString *)cityName
{

    NSString * statement = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?q=%@&cnt=14&APPID=1cf95d62d6f39aa8123fa7534bea494a",cityName];
    
    

    self.responseData = [NSMutableData data];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:statement]];
    id connec= [[NSURLConnection alloc] initWithRequest:request delegate:self];
    connec = nil;

}


#pragma - mark  NSURl Connection Delegates

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if (_isDownloading) {
        [_responseData appendData:data];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	self.responseData = nil;
    
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Connection Error!" message:@"Network Failed To Respond" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [alertView show];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if (_isDownloading) {
        @try {
        NSDictionary *JsonDict = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableContainers error:nil];
            
           // CityModel * cityM = [[CityModel alloc] init];
            
                  
            NSDictionary * city = [JsonDict  valueForKey:@"city"];
            NSArray * resultsArray = [JsonDict  valueForKey:@"list"];
           
            
            
            if (city.count>0 && resultsArray.count>0) {
                
                if ([_delegate respondsToSelector:@selector(setCityWeatherInfo:DayArray:)]) {
                    
                    [_delegate setCityWeatherInfo:city DayArray:resultsArray];
                }
                
            }

            
        }
            @catch (NSException* e)
        {
                
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Connection Error!" message:@"Network Failed To Respond" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [alertView show];
//                if ([cartDelegate respondsToSelector:@selector(cartEmptyErroMsg:)]) {
//                    [cartDelegate cartEmptyErroMsg:@"error"];
//                }
            }
            
        }
}


@end
