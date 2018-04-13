//
//  HDZDetailViewController.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/3.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZDetailViewController.h"
#import "HDZDimmingPresentationController.h"
#import "HDZSearchResult.h"
#import "UIImageView+HDZDownloadImage.h"
#import "HDZBounceAnimationController.h"
#import "HDZSlideOutAnimationController.h"
typedef NS_ENUM(NSInteger, AnimationStyle) {
    slide,//默认从0开始
    fade,
};
@interface HDZDetailViewController ()<UIViewControllerTransitioningDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIView *popupView;
@property (weak, nonatomic) IBOutlet UIImageView *artworkImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *genereLabel;
@property (weak, nonatomic) IBOutlet UILabel *kindLabel;
@property (weak, nonatomic) IBOutlet UIButton *priceButton;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, assign) AnimationStyle dismissStyle;
@end

@implementation HDZDetailViewController
-(void)updateUI{
    self.nameLabel.text = self.searchResult.name;
    if (self.searchResult.artistName == nil) {
        self.artistNameLabel.text = @"Unknow";
    }else {
        self.artistNameLabel.text = self.searchResult.artistName;
    }
    self.kindLabel.text = self.searchResult.type;
    self.genereLabel.text = self.searchResult.genre;
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    numberFormatter.currencyCode = self.searchResult.currency;
    NSNumber *number = [NSNumber numberWithInteger:self.searchResult.price];
    NSString *priceText = [numberFormatter stringFromNumber:number];
    if (self.searchResult.price == 0){
        priceText = @"Free";
    }
    [self.priceButton setTitle:priceText forState:UIControlStateNormal];
    NSURL *largeURL = [NSURL URLWithString:self.searchResult.imageLarge];
    if (largeURL) {
        self.downloadTask = [self.artworkImageView loadImageWithURL:largeURL];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.tintColor = [[UIColor alloc] initWithRed:20/255 green:160/255 blue:160/255 alpha:1];
    self.popupView.layer.cornerRadius = 10;
    UIGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close:)];
    gestureRecognizer.cancelsTouchesInView = NO;
    gestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:gestureRecognizer];
    if (self.searchResult) {
        [self updateUI];
    }
    self.view.backgroundColor = [UIColor clearColor];
    
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
        
    }
    return self;
}
-(void)dealloc{
    [self.downloadTask cancel];
}
//MARK:UIViewControllerTransitioningDelegate
//当现实新试图控制器时，系统调用这个方法返回自定义的presentationController来管理视图层级
-(UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    HDZDimmingPresentationController *dimmingController = [[HDZDimmingPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    return dimmingController;
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    HDZBounceAnimationController *bounceAnimationController = [[HDZBounceAnimationController alloc] init];
    return (id<UIViewControllerAnimatedTransitioning>)bounceAnimationController;
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    HDZSlideOutAnimationController *SlideOutAnimationController = [[HDZSlideOutAnimationController alloc] init];
    return (id<UIViewControllerAnimatedTransitioning>)SlideOutAnimationController;
}
//MARK:UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(nonnull UITouch *)touch{
    return touch.view == self.view;
}
//MARK:Action
- (IBAction)close:(id)sender {
    self.dismissStyle = slide;
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)openInStore:(id)sender {
    NSURL *url = [NSURL URLWithString:self.searchResult.storeURL];
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}


@end
