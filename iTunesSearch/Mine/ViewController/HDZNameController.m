//
//  HDZNameController.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/17.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZNameController.h"
#import "HDZIndividual.h"
@interface HDZNameController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@end

@implementation HDZNameController
-(void)viewWillAppear:(BOOL)animated{
    [self.nameTextField becomeFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTextField.text = self.individual.name;

}
- (IBAction)save:(UIBarButtonItem *)sender {
    NSLog(@"save");
    if (self.individual) {
        self.individual.name = self.nameTextField.text;
    }else{
        self.individual = [[HDZIndividual alloc] init];
        self.individual.name = self.nameTextField.text;
    }
    if ([self.delegate respondsToSelector:@selector(nameController:DidFinishEditingItem:)]) {
        [self.delegate nameController:self DidFinishEditingItem:self.individual];
    }
    
}

- (IBAction)cancel:(id)sender {
        NSLog(@"cancel");
    if ([self.delegate respondsToSelector:@selector(nameControllerDidCancel:)]) {
        [self.delegate nameControllerDidCancel:self];
    }
}

@end
