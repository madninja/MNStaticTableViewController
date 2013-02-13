//
//  MNRootViewController.m
//  MNStaticTableViewControllerDemo
//
//  Created by Marc Nijdam on 2/13/13.
//  Copyright (c) 2013 imadjine, LLC. All rights reserved.
//

#import "MNRootViewController.h"

@interface ProfileMenuProvider : MNStaticTableViewProvider
@end

@interface ViewMenuProvider : MNStaticTableViewProvider
@end

@interface SettingsMenuProvider : MNStaticTableViewProvider
@end

@interface MNRootViewController ()

@end

@implementation MNRootViewController

- (id)init
{
    ProfileMenuProvider *profileProvider = [[ProfileMenuProvider alloc] init];
    SettingsMenuProvider *settingsProvider = [[SettingsMenuProvider alloc] init];
    ViewMenuProvider *viewProvider = [[ViewMenuProvider alloc] init];
    
    self = [super initWithTableViewProviders:@[profileProvider, viewProvider, settingsProvider]];
    if (!self) return nil;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBX(0xD1D1D1);
    self.tableView.separatorColor = [RGBX(0x313131) colorWithAlphaComponent:0.2];
}

@end

#pragma mark -

@implementation ProfileMenuProvider

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kProfileMenuCell = @"kProfileMenuCell";
    UITableViewCell *cell = [self tableView:tableView dequeueReusableCellWithIdentifier:kProfileMenuCell];
    
    cell.textLabel.text = NSLocalizedString(@"My Profile", nil);
    cell.imageView.image = [UIImage imageNamed:@"111-user"];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end

#pragma mark -

@implementation ViewMenuProvider

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kProfileMenuCell = @"kViewMenuCell";
    UITableViewCell *cell = [self tableView:tableView dequeueReusableCellWithIdentifier:kProfileMenuCell];
    
    NSString *textTemplate = NSLocalizedString(@"View Option %u", nil);
    cell.textLabel.text = [NSString stringWithFormat:textTemplate, indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self headerViewWithTitle:NSLocalizedString(@"VIEWS", nil)];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end

#pragma mark -

@implementation SettingsMenuProvider
{
    BOOL _isSignedIn;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kSettingsMenuCell = @"kSettingsMenuCell";
    UITableViewCell *cell = [self tableView:tableView dequeueReusableCellWithIdentifier:kSettingsMenuCell];
    
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = NSLocalizedString(@"About", nil);
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 1:
            if (_isSignedIn) {
                cell.textLabel.text = NSLocalizedString(@"Sign Out", nil);
            } else {
                cell.textLabel.text = NSLocalizedString(@"Sign In", nil);
            }
            cell.accessoryType = UITableViewCellAccessoryNone;
            break;
            
        default:
            break;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self headerViewWithTitle:NSLocalizedString(@"SETTINGS", nil)];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _isSignedIn = !_isSignedIn;
    [self clearSelectedIndexPathInTableView:tableView animated:YES];
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end

