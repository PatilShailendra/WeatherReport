//
//  DetailViewController.m
//  WeatherForcastingDemo
//
//  Created by Shailendra on 09/04/15.
//  Copyright (c) 2015 Redbytes. All rights reserved.

#import "DetailViewController.h"

@interface DetailViewController ()
{
    
    UIView *sectionHeaderView;
    UILabel *headerLabel;
    NSMutableDictionary *temprature;
    NSMutableArray *whether,*otherInfoArray;
    
   
}

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark-ViewLifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Weather Around";
    
    whether = [[NSMutableArray alloc]init];
    temprature = [[NSMutableDictionary alloc]init];
    otherInfoArray = [[NSMutableArray alloc]init];
    
    

    // Do any additional setup after loading the view from its nib.
    
    if (_dataArr) {
        
            [detailTableView reloadData];
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [temprature removeAllObjects];
    [whether removeAllObjects];
    [otherInfoArray removeAllObjects];
    
    
    [temprature addEntriesFromDictionary:[self.DayArray valueForKey:@"temp"]];
    [whether addObjectsFromArray:[self.DayArray  valueForKey:@"weather"]];
    
    [otherInfoArray addObject:[self.city  valueForKey:@"id"]];
    [otherInfoArray addObject:[self.city  valueForKey:@"name"]];
    [otherInfoArray addObject:[self.DayArray  valueForKey:@"pressure"]];
    [otherInfoArray addObject:[self.DayArray  valueForKey:@"humidity"]];
    [otherInfoArray addObject:[self.DayArray  valueForKey:@"speed"]];
    [otherInfoArray addObject:[self.DayArray  valueForKey:@"deg"]];
    [otherInfoArray addObject:[self.DayArray  valueForKey:@"clouds"]];
    //[otherInfoArray addObject:[self.DayArray  valueForKey:@"rain"]];
    
    
}

#pragma mark-UITableView delegate and datasourse methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(section==0)
    {
        return otherInfoArray.count;
        
    }
    if(section==1)
    {
        return temprature.count;
        
    }if(section==2)
    {
        return whether.count;
        
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier =@"Cell1";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section==0)
    {
        if (indexPath.row==0)
        {
            UIFont *myFont = [ UIFont fontWithName:@"Arial" size: 15.0 ];
            cell.textLabel.font  = myFont;
            cell.textLabel.text=[NSString stringWithFormat:@"Id:            %@",[otherInfoArray objectAtIndex:indexPath.row] ];
            
        }
        if (indexPath.row==1)
        {
            UIFont *myFont = [ UIFont fontWithName:@"Arial" size: 15.0 ];
            cell.textLabel.font  = myFont;
            cell.textLabel.text=[NSString stringWithFormat:@"Name:          %@",[otherInfoArray objectAtIndex:indexPath.row] ];
        }

        if (indexPath.row==2)
        {
            UIFont *myFont = [ UIFont fontWithName:@"Arial" size: 15.0 ];
            cell.textLabel.font  = myFont;
            cell.textLabel.text=[NSString stringWithFormat:@"pressure:      %@",[otherInfoArray objectAtIndex:indexPath.row] ];
        }

        
        if (indexPath.row==3)
        {
            UIFont *myFont = [ UIFont fontWithName:@"Arial" size: 15.0 ];
            cell.textLabel.font  = myFont;
            cell.textLabel.text=[NSString stringWithFormat:@"humidity:      %@",[otherInfoArray objectAtIndex:indexPath.row] ];
        }

        if (indexPath.row==4)
        {
            UIFont *myFont = [ UIFont fontWithName:@"Arial" size: 15.0 ];
            cell.textLabel.font  = myFont;
            cell.textLabel.text=[NSString stringWithFormat:@"speed:         %@",[otherInfoArray objectAtIndex:indexPath.row] ];
        }
        if (indexPath.row==5)
        {
            UIFont *myFont = [ UIFont fontWithName:@"Arial" size: 15.0 ];
            cell.textLabel.font  = myFont;
            cell.textLabel.text=[NSString stringWithFormat:@"deg:           %@",[otherInfoArray objectAtIndex:indexPath.row] ];
        }
        if (indexPath.row==6)
        {
            UIFont *myFont = [ UIFont fontWithName:@"Arial" size: 15.0 ];
            cell.textLabel.font  = myFont;
            cell.textLabel.text=[NSString stringWithFormat:@"clouds:        %@",[otherInfoArray objectAtIndex:indexPath.row] ];
        }



        
    }
    else if (indexPath.section==1)
    {
        UIFont *myFont = [ UIFont fontWithName: @"Arial" size: 15.0 ];
        cell.textLabel.font  = myFont;
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        if (indexPath.row==0)
        {
            cell.textLabel.text=[NSString stringWithFormat:@"Day:           %@",[temprature valueForKey:@"day"] ];
        }
        if (indexPath.row==1)
        {
            cell.textLabel.text=[NSString stringWithFormat:@"Eve:           %@",[temprature valueForKey:@"eve"] ];
        }
        if (indexPath.row==2)
        {
            cell.textLabel.text=[NSString stringWithFormat:@"Max:           %@",[temprature valueForKey:@"max"] ];
        }
        if (indexPath.row==3)
        {
            cell.textLabel.text=[NSString stringWithFormat:@"Min:           %@",[temprature valueForKey:@"min"] ];
        }
        if (indexPath.row==4)
        {
            cell.textLabel.text=[NSString stringWithFormat:@"Morn:          %@",[temprature valueForKey:@"morn"] ];
        }
        if (indexPath.row==5)
        {
            cell.textLabel.text=[NSString stringWithFormat:@"Night:         %@",[temprature valueForKey:@"night"] ];
        }
      
        
        
    }
    else if (indexPath.section==2)
    {
        UIFont *myFont = [ UIFont fontWithName: @"Arial" size: 15.0 ];
         cell.textLabel.font  = myFont;
         cell.selectionStyle= UITableViewCellSelectionStyleNone;

         cell.textLabel.text=[NSString stringWithFormat:@"Description:      %@",[[whether objectAtIndex:0] valueForKey:@"description"]];
        
    }
    // Configure the cell...
    
    return cell;

    
    
    
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIFont *myFont = [ UIFont fontWithName: @"Arial" size: 15.0 ];
    headerLabel.font  = myFont;
    switch (section)
    {
        case 0:
          
            sectionHeaderView = [[UIView alloc] initWithFrame:
                                 CGRectMake(0, 0, tableView.frame.size.width, 50.0)];
            sectionHeaderView.backgroundColor = [UIColor colorWithRed:239/255.0f green:239/255.0f blue:239/255.0f alpha:1.0f];
            
            headerLabel = [[UILabel alloc] initWithFrame:
                           CGRectMake(0, 20, sectionHeaderView.frame.size.width, 25.0)];
            
            headerLabel.backgroundColor = [UIColor clearColor];
            headerLabel.textAlignment = NSTextAlignmentCenter;
            [headerLabel setFont:[UIFont fontWithName:@"Verdana" size:15.0]];
            [sectionHeaderView addSubview:headerLabel];
            
              headerLabel.text = @"Genral";
            return sectionHeaderView;

            break;
        case 1:
            sectionHeaderView = [[UIView alloc] initWithFrame:
                                 CGRectMake(0, 0, tableView.frame.size.width, 50.0)];
            sectionHeaderView.backgroundColor = [UIColor colorWithRed:239/255.0f green:239/255.0f blue:239/255.0f alpha:1.0f];
            
            headerLabel = [[UILabel alloc] initWithFrame:
                           CGRectMake(0, 20, sectionHeaderView.frame.size.width, 25.0)];
            
            headerLabel.backgroundColor = [UIColor clearColor];
            headerLabel.textAlignment = NSTextAlignmentCenter;
            [headerLabel setFont:[UIFont fontWithName:@"Verdana" size:15.0]];
            [sectionHeaderView addSubview:headerLabel];
            
            headerLabel.text = @"Temprature";
            return sectionHeaderView;
            
            break;
        case 2:
            sectionHeaderView = [[UIView alloc] initWithFrame:
                                 CGRectMake(0, 0, tableView.frame.size.width, 50.0)];
            sectionHeaderView.backgroundColor = [UIColor colorWithRed:239/255.0f green:239/255.0f blue:239/255.0f alpha:1.0f];
            
            headerLabel = [[UILabel alloc] initWithFrame:
                           CGRectMake(0, 20, sectionHeaderView.frame.size.width, 25.0)];
            
            headerLabel.backgroundColor = [UIColor clearColor];
            headerLabel.textAlignment = NSTextAlignmentCenter;
            [headerLabel setFont:[UIFont fontWithName:@"Verdana" size:15.0]];
            [sectionHeaderView addSubview:headerLabel];
            headerLabel.text = @"Weather";
            return sectionHeaderView;
            
            break;
        default:
            break;
    }
    
    return sectionHeaderView;
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *) indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 50;
    }
    
    return 35;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
