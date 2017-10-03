//
//  AppTest_Link.m
//  UILabel+Addition
//
//  Created by wesley chen on 16/4/13.
//
//

#import "AppTest_Link.h"

#import "UILabel+Link.h"

@interface AppTest_Link ()
@property (nonatomic, strong) UILabel *labelContract;
@end

@implementation AppTest_Link

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.labelContract];
}

#pragma mark - Getter

- (UILabel *)labelContract {
    if (!_labelContract) {
        NSString *plainString = @"输入验证码表示同意《法律声明及隐私政策》";
        NSRange clickableRange = [plainString rangeOfString:@"《法律声明及隐私政策》"];
        
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]
                                                 initWithString:plainString
                                                 attributes:@{ NSForegroundColorAttributeName: [UIColor lightGrayColor] }];
        [attrString addAttributes:@{ NSForegroundColorAttributeName: [UIColor orangeColor] }
                            range:clickableRange];
        
        CGFloat height = 15.0;
        CGFloat spaceT = 10;
        
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        
        CGFloat width = 150;
        
        UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame) + spaceT, width, height)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:11];
//        label.textAlignment = NSTextAlignmentCenter;
        label.attributedText = attrString;
        label.userInteractionEnabled = YES;
        label.clickableTextRanges = @[ [NSValue valueWithRange:clickableRange] ];
        label.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
        label.layer.borderColor = [UIColor greenColor].CGColor;
        label.numberOfLines = 0;
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelContractLinkTapped:)];
        [label addGestureRecognizer:tapRecognizer];
        
        CGRect textRect = [label.attributedText boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:nil];
        
        CGRect frame = label.frame;
        frame.size.height = ceil(textRect.size.height);
        label.frame = frame;
        
        _labelContract = label;
    }
    
    return _labelContract;
}

- (void)labelContractLinkTapped:(UITapGestureRecognizer *)tapRecognizer {
    UILabel *label = (UILabel *)tapRecognizer.view;
    NSRange range = NSMakeRange(0, 0);
    BOOL tappedOnLink = [label isTappedOnClickableTextWithTapGesture:tapRecognizer atRange:nil];
    
    NSLog(@"range: %@", NSStringFromRange(range));
    
    if (tappedOnLink) {
        NSLog(@"hit the link");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"you tapped on the link" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else {
        NSLog(@"not hit");
    }
}

@end
