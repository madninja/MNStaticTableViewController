//
//  MNStaticTableViewController.m
//  MNStaticTableViewController
//
//  Created by Marc Nijdam on 2/13/13.
//  Copyright (c) 2013 imadjine, LLC. All rights reserved.
//

#import "MNStaticTableViewController.h"


@interface MNStaticTableViewController()
@property (strong,nonatomic) NSArray *tableViewProviders;
@end

@implementation MNStaticTableViewController

- (id)initWithTableViewProviders:(NSArray *)providers
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (!self) return nil;

    _tableViewProviders = [NSArray arrayWithArray:providers];
    
    return self;
}

#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableViewProviders.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MNStaticTableViewProvider *provider = self.tableViewProviders[section];
    return [provider tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MNStaticTableViewProvider *provider = self.tableViewProviders[indexPath.section];
    return [provider tableView:tableView cellForRowAtIndexPath:indexPath];
    
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MNStaticTableViewProvider *provider = self.tableViewProviders[section];
    return [provider tableView:tableView viewForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    MNStaticTableViewProvider *provider = self.tableViewProviders[section];
    return [provider tableView:tableView heightForHeaderInSection:section];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MNStaticTableViewProvider *provider = self.tableViewProviders[indexPath.section];
    [provider tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MNStaticTableViewProvider *provider = self.tableViewProviders[indexPath.section];
    return [provider tableView:tableView willSelectRowAtIndexPath:indexPath];
}

@end

#pragma mark -

@implementation MNStaticTableViewProvider

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)reuseIdentifier
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
        cell.textLabel.textColor = RGBX(0x313131);
        cell.textLabel.highlightedTextColor = cell.textLabel.textColor;
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:cell.bounds];
        backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        backgroundView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
        cell.selectedBackgroundView = backgroundView;
    }
    return cell;
}

- (UIView *)headerViewWithTitle:(NSString *)title
{
    CGRect viewRect = CGRectMake(0, 0, 100, 16);
    UIView *view = [[UIView alloc] initWithFrame:viewRect];
    view.backgroundColor = RGBX(0x313131);
    view.autoresizesSubviews = YES;
    
    CGRect labelRect = CGRectInset(viewRect, 10, 0);
    UILabel *label = [[UILabel alloc] initWithFrame:labelRect];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:10];
    label.textColor = RGBX(0xD1D1D1);
    label.text = [title uppercaseString];
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}

- (void)clearSelectedIndexPathInTableView:(UITableView *)tableView animated:(BOOL)animated
{
    NSIndexPath *selectedIndexPath = tableView.indexPathForSelectedRow;
    if (selectedIndexPath) {
        [tableView deselectRowAtIndexPath:selectedIndexPath animated:animated];
    }
}

@end

