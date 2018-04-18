//
//  HDZAutographController.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/17.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZAutographController.h"
#import "HDZIndividual.h"
@interface HDZAutographController ()
@property (weak, nonatomic) IBOutlet UITextView *autographTextField;
@end

@implementation HDZAutographController
-(void)viewWillAppear:(BOOL)animated{
    [self.autographTextField becomeFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.autographTextField.text = self.individual.autograph;
    
}
- (IBAction)save:(UIBarButtonItem *)sender {
    if (self.individual) {
        self.individual.autograph = self.autographTextField.text;
    }else{
        self.individual = [[HDZIndividual alloc] init];
        self.individual.autograph = self.autographTextField.text;
    }
    if ([self.delegate respondsToSelector:@selector(autographController:DidFinishEditingItem:)]) {
        [self.delegate autographController:self DidFinishEditingItem:self.individual];
    }
    
}

- (IBAction)cancel:(id)sender {
    if ([self.delegate respondsToSelector:@selector(autographControllerDidCancel:)]) {
        [self.delegate autographControllerDidCancel:self];
    }
}


@end
