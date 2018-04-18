//
//  HDZMineController.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/17.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZMineController.h"
#import "HDZIndividual.h"
#import "HDZIndividualController.h"
@interface HDZMineController ()
@property (weak, nonatomic) IBOutlet UILabel *aotographLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (nonatomic, strong)HDZIndividual *individual;
@end

@implementation HDZMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.individual = [[HDZIndividual alloc] init];
}
//- (IBAction)unwindToMineController:(UIStoryboardSegue*)sender
//{
//    HDZIndividualController *sourceViewController = sender.sourceViewController;
//    self.individual.name = sourceViewController.individual.name;
//    self.nameLabel.text = self.individual.name;
//    self.individual.thumbImage = sourceViewController.individual.thumbImage;
//    self.thumbImageView.image = self.individual.thumbImage;
//    self.individual.autograph = sourceViewController.individual.autograph;
//    self.individual.autograph = self.individual.autograph;
//}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"individualSegue"]) {
        HDZIndividualController *individualController = segue.destinationViewController;
        individualController.individual = self.individual;
    }
}



@end
