//
//  HDZIndividualController.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/17.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZIndividualController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "HDZNameController.h"
#import "HDZIndividual.h"
#import "HDZAutographController.h"
@interface HDZIndividualController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,HDZNameControllerDelegate,HDZAutographControllerDelegate>
@property (nonatomic, assign)BOOL birthdayPickerVisible;
@end

@implementation HDZIndividualController
#pragma mark Private
- (void)updateBirthdayLabel{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterMediumStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    self.birthdayLabel.text = [formatter stringFromDate:self.individual.birthday];
}
/*
 'Invalid update: invalid number of rows in section 1.  The number of rows contained in an existing section after the update (4) must be equal to the number of rows contained in that section before the update (4), plus or minus the number of rows inserted or deleted from that section (2 inserted, 1 deleted) and plus or minus the number of rows moved into or out of that section (0 moved in, 0 moved out).'
 */
- (void)showBirthdayPicker{
    self.birthdayPickerVisible = YES;
    NSIndexPath *indexPathBirthdayRow = [NSIndexPath indexPathForRow:1 inSection:1];
    NSIndexPath *indexPathBirthdayPicker = [NSIndexPath indexPathForRow:2 inSection:1];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPathBirthdayRow];
    cell.detailTextLabel.textColor = cell.detailTextLabel.tintColor;
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[indexPathBirthdayPicker] withRowAnimation:UITableViewRowAnimationFade];
    //[self.tableView reloadRowsAtIndexPaths:@[indexPathBirthdayRow] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView reloadData];
    [self.tableView endUpdates];
    [self.birthdayPicker setDate:self.individual.birthday];
    
}
- (void)hideBirthdayPicker{
    self.birthdayPickerVisible = NO;
    NSIndexPath *indexPathBirthdayRow = [NSIndexPath indexPathForRow:1 inSection:1];
    NSIndexPath *indexPathBirthdayPicker = [NSIndexPath indexPathForRow:2 inSection:1];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPathBirthdayRow];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    [self.tableView beginUpdates];
    [self.tableView reloadData];
    //[self.tableView reloadRowsAtIndexPaths:@[indexPathBirthdayRow] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView deleteRowsAtIndexPaths:@[indexPathBirthdayPicker] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}
#pragma mark Action
- (IBAction)dateChange:(UIDatePicker *)sender {
    self.individual.birthday = sender.date;
    [self updateBirthdayLabel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.individual = [[HDZIndividual alloc] init];
    self.birthdayPickerVisible = NO;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"nameSegue"]) {
        HDZNameController *nameController = segue.destinationViewController;
        nameController.delegate = self;
        nameController.individual = self.individual;
    }else if ([segue.identifier isEqualToString:@"autographSegue"]){
        HDZAutographController *autographController = segue.destinationViewController;
        autographController.delegate = self;
        autographController.individual = self.individual;
    }
}
#pragma mark data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1 && self.birthdayPickerVisible) {
        return 5;
    }else if (section == 1 && !self.birthdayPickerVisible){
        return 4;
    }else{
        return [super tableView:tableView numberOfRowsInSection:section];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 2 && self.birthdayPickerVisible) {
        return self.birthdayPickerCell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 2 && self.birthdayPickerVisible) {
        return 217;
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self pickPhoto];
    }else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
                break;
            case 1:
                if (self.birthdayPickerVisible) {
                    [self hideBirthdayPicker];
                } else{
                    [self showBirthdayPicker];
                }
                break;
            case 2:
                break;
        }
    }
}


- (void)pickPhoto{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self showPhotoMenu];
    }else{
        [self choosePhotoFromLibrary];
    }
}
- (void)showPhotoMenu{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *alertCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:alertCancel];
    UIAlertAction *alertPhoto = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhotoWidthCamera];
    }];
    [alertController addAction:alertPhoto];
    UIAlertAction *alertLibrary = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self choosePhotoFromLibrary];
    }];
    [alertController addAction:alertLibrary];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)takePhotoWidthCamera{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.view.tintColor = self.view.tintColor;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
- (void) choosePhotoFromLibrary{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.view.tintColor = self.view.tintColor;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
  // MARK:- Image Picker Delegates
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //通过info字典选取选择的照片
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(__bridge NSString*)kUTTypeImage]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        self.thumbImageView.image = image;
    }
    [self.tableView reloadData];
    //关闭UIImagePickerController对象
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark NameController delegate
- (void)nameController:(HDZNameController *)nameController DidFinishEditingItem:(HDZIndividual *)item {
    self.individual.name = item.name;
    self.nameLabel.text = item.name;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)nameControllerDidCancel:(HDZNameController *)nameController {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark AutographController delegate
- (void)autographController:(HDZAutographController *)autographController DidFinishEditingItem:(HDZIndividual *)item {
    self.individual.autograph = item.autograph;
    self.autographLabel.text = item.autograph;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)autographControllerDidCancel:(HDZAutographController *)autographController {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
