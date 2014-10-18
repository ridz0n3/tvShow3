//
//  TVListTableViewController.m
//  TVShows3
//
//  Created by ME-Tech Mac User 1 on 10/18/14.
//  Copyright (c) 2014 ME-Tech. All rights reserved.
//

#import "TVListTableViewController.h"
#import <SWRevealViewController/SWRevealViewController.h>
#import "TraktAPIClient.h"
#import "TVShowsDescription.h"
#import <AFNetworking/UIKit+AFNetworking.h>

@interface TVListTableViewController ()

@end

@implementation TVListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //_menuBarButtonItem.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _menuBarButtonItem.target = self.revealViewController;
    _menuBarButtonItem.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    _arrData = [[NSMutableArray alloc]initWithCapacity:20];
    [[TraktAPIClient sharedClient] getShowsForUsername:@"wanmuz" date:[NSDate date] Days:3 success:^(NSURLSessionDataTask *sessionTask, id data) {
        
        self.jsonResponse = [NSArray arrayWithArray:data];
        for(NSDictionary* datas in _jsonResponse[0][@"episodes"]){
            NSLog(@"%@", datas);
            TVShowsDescription *shows = [[TVShowsDescription alloc]init];
            
            shows.Names = datas[@"show"][@"title"];
            shows.Episode = datas[@"episode"][@"title"];
            shows.ImageURL = datas[@"episode"][@"images"][@"screen"];
            shows.Description = datas[@"show"][@"overview"];
            
            [_arrData addObject:shows];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *sessionData, NSError *error) {
        
    }];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [_arrData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TVCell" forIndexPath:indexPath];
    TVShowsDescription *shows = _arrData[indexPath.row];
    // Configure the cell...
    // cell.Title = shows.Names;
    cell.textLabel.text = shows.Names;
    cell.detailTextLabel.text = shows.Episode;
    //[cell.imageView setImage
    [cell.imageView setImageWithURL:[NSURL URLWithString:shows.ImageURL] placeholderImage:[UIImage imageNamed:@"placeholder1.jpg"]];

    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
