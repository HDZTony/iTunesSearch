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

@end

@implementation HDZIndividualController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.individual = [[HDZIndividual alloc] init];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self pickPhoto];
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
