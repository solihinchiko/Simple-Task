//
//  TaskViewController.m
//  SimpleTask
//
//  Created by Solihin Chiko on 3/31/17.
//  Copyright © 2017 Solihin Chiko. All rights reserved.
//

#import "TaskViewController.h"
#import "EditViewController.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
// model
#import "TaskModel.h"
// cell
#import "CustomTableViewCell.h"

static NSString *const identifier = @"CustomTableViewCell";

@interface TaskViewController ()

@end

@implementation TaskViewController {
    NSMutableArray *array;
    NSMutableArray *tempArray;
    NSUserDefaults *defaults;
    BOOL isEdit;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD dismiss];

}

- (void)viewWillAppear:(BOOL)animated {
    [self setSetting];
    isEdit = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Setting
- (void)setSetting {

    self.title = @"Task";
    
    // array
    array = [[NSMutableArray alloc] init];
    
    defaults = [NSUserDefaults standardUserDefaults];
    NSArray *arrayTask = [defaults objectForKey:@"TASK"];
    if (arrayTask.count > 0) {
        for (NSDictionary *dict in arrayTask) {
            TaskModel *model = [TaskModel getTaskFromDictionary:dict];
            [array addObject:model];
        }
    }
    
    tempArray = [[NSMutableArray alloc] init];
    [tempArray addObjectsFromArray:arrayTask];
    
    [self.tableView reloadData];
    
    [self addNavButton];
    
}

- (void)addNavButton {
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    // left
    UIBarButtonItem *editButton =  self.editButtonItem;
    
    // button
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItems = @[leftButton, editButton];
    
    // right
    UIBarButtonItem *plusButton =  [[UIBarButtonItem alloc] initWithTitle:@" + " style:UIBarButtonItemStylePlain target:self action:@selector(didTapPlusButton)];
    self.navigationItem.rightBarButtonItem = plusButton;
    
    
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [self didTapEditButton];
    [super setEditing:editing animated:animated];
}

#pragma mark - IBAction

- (void)didTapEditButton {
    if (!isEdit) {
        self.tableView.editing = YES;
        isEdit = YES;
    } else {
        self.tableView.editing = NO;
        isEdit = NO;
        
        [defaults removeObjectForKey:@"TASK"];
        [defaults setObject:tempArray forKey:@"TASK"];
        [defaults synchronize];

    }
}

- (void)didTapPlusButton {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    EditViewController *controller = (EditViewController *) [storyboard instantiateViewControllerWithIdentifier:@"EditViewController"];
    controller.stringTitle = @"New Task";
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Function

#pragma mark - Tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    TaskModel *model = [array objectAtIndex:indexPath.row];
    [cell configureCell:model];
    
    
    return cell;
}

#pragma mark - Tableview delegate
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    TaskModel *model = [array objectAtIndex:sourceIndexPath.row];
    [array removeObjectAtIndex:sourceIndexPath.row];
    [array insertObject:model atIndex:destinationIndexPath.row];
    
    [tempArray removeObjectAtIndex:sourceIndexPath.row];
    NSDictionary *task = @{
                           @"title":model.title,
                           @"detail":model.detail,
                           @"dueDate":model.dueDate
                           };
    [tempArray insertObject:task atIndex:destinationIndexPath.row];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [array removeObjectAtIndex:indexPath.row];
        [tempArray removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TaskModel *task = [array objectAtIndex:indexPath.row];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    EditViewController *controller = (EditViewController *) [storyboard instantiateViewControllerWithIdentifier:@"EditViewController"];
    controller.task = task;
    controller.index = (int)indexPath.row;
    controller.stringTitle = @"Edit Task";
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Delegate Left
- (void)goToLoginViewController {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate goToLoginController];

}

@end
