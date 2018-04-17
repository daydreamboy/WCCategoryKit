//
//  AppTest_Addition.m
//  UIImage+Addition
//
//  Created by wesley chen on 16/4/19.
//
//

#import "AppTest_Addition.h"

#import "UIImage+Addition.h"

@interface AppTest_Addition ()
@property (nonatomic, strong) UIImageView *imageViewCaptcha;
@end

@implementation AppTest_Addition

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self.view addSubview:self.imageViewCaptcha];
    UIImage *image = [UIImage imageWithColor:[UIColor redColor]];
    NSLog(@"%@", image);
}

- (UIImageView *)imageViewCaptcha {
    if (!_imageViewCaptcha) {
        
        CGSize size = CGSizeMake(230, 60);
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((screenSize.width - size.width) / 2.0, (screenSize.height - size.height) / 2.0, size.width, size.height)];
        imageView.backgroundColor = [UIColor lightGrayColor];
        imageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewCaptchaTapped:)];
        [imageView addGestureRecognizer:tapRecognizer];
        
        _imageViewCaptcha = imageView;
    }
    
    return _imageViewCaptcha;
}

- (void)imageViewCaptchaTapped:(UITapGestureRecognizer *)tapRecognizer {
    UIView *tappedView = tapRecognizer.view;
    if (tappedView == self.imageViewCaptcha) {
        [self refreshCaptcha];
    }
}

- (void)refreshCaptcha {
    NSString *name = [NSString stringWithFormat:@"%d.jpeg", arc4random() % 5 + 1];
//    name = @"8";
    UIImage *image = [UIImage imageNamed:name];
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    CGRect frame = self.imageViewCaptcha.frame;
    frame.size.width = image.size.width;
    frame.size.height = image.size.height;
    
    frame.origin.x = (screenSize.width - frame.size.width) / 2.0;
    frame.origin.y = (screenSize.height - frame.size.height) / 2.0;
    
    self.imageViewCaptcha.frame = frame;
    
    self.imageViewCaptcha.image = [UIImage processImage:image];
    
    /*
    self.imageViewCaptcha.image = [UIImage changeWhiteColorTransparent:image];
     */
    
    /*
    self.imageViewCaptcha.image = [UIImage createTintedImageFromImage:image color:[UIColor orangeColor]];
    */
    
    /*
    self.imageViewCaptcha.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.imageViewCaptcha setTintColor:[UIColor redColor]];
     */
    
    /*
    self.imageViewCaptcha.image = [UIImage combineImage:image withBackgroundColor:[UIColor greenColor]];
     */
}

@end
