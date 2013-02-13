//
//  MNStaticTableViewController.h
//  MNStaticTableViewController
//
//  Created by Marc Nijdam on 2/13/13.
//  Copyright (c) 2013 imadjine, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

/** The `MNStaticTableViewProvider` is the base class for providing sections of cells to a static table view.
 
   Instances of MNStaticTableViewController typically use subclasses of this class to implement sections of the tableview. Each subclass can override any part of the defined methods or implemented protocols to override the default behavior. 
 
   The default look and feel implemented in the base class can be seen in the provided demo application 
 */
@interface MNStaticTableViewProvider : NSObject <UITableViewDataSource, UITableViewDelegate>

/** Can be called by subclasses to get a default look and feel for all the cells in the table. If the default look doesn't work, override this method to return a different configured cell
 
 @param tableView the tableview to dequeue a cell from
 @param reuseIdentifier the reuse identifier for the given cell. May be nil
 @return a configured tableview cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)reuseIdentifier;

/** Can be called by subclasses to get a default looking headerview. If the specific section does not want a headerview return nil from the implemenentation **and** return 0 from `tableView:heightForHeaderInSection:`
 
  @param title the title for the header view
  @return a configured default look headerview for the given section
 */
- (UIView *)headerViewWithTitle:(NSString *)title;

/** A utility method for subclasses to call if they want the selection for the tableview cleared regardless of whether the selection is currently set. Since this controller is often used for menus, being able to clear a selection is often used in `tableView:didSelectRowAtIndexPath:`
 
  @param tableView the tableview to clear the current selected index path from
  @param animated whether to animate the clearing
 */
- (void)clearSelectedIndexPathInTableView:(UITableView *)tableView animated:(BOOL)animated;
@end

/** The `MNStaticTableViewController` is a utility tableview controller that implements a simple approach to creating a tableview with sections and cells in each section. This is commonly used in (side-panel) menus. Rather than encoding all of this in a single large UITableViewController subclass you provide a list of instances of `MNStaticTableViewProvider` subclasses which are like mini `UITableViewController`s. This focuses the logic on each section of the table while allowing for a common loook and feel for each header and cell. 
 
    A demonstration of this controller can be found in the supplied demo application
 */
@interface MNStaticTableViewController : UITableViewController

/** Initializes the receiver with a given list of tableview section providers. The order of the list defines the order of the sections in the tableview
 
  @param providers the array of section providers
  @return an initialized tableviewcontrolller
 */
- (id)initWithTableViewProviders:(NSArray *)providers;

/** The list of `MNStaticTableViewProvider`s for each section of the table
 */
@property(nonatomic,readonly)NSArray *tableViewProviders;

@end
