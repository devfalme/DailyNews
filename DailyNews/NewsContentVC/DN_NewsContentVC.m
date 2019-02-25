//
//  DN_NewsContentVC.m
//  DailyNews
//
//  Created by devfalme on 2019/1/6.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "DN_NewsContentVC.h"
#import "DN_NewsDetailModel.h"
@interface DN_NewsContentVC ()
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *linkButton;
@property (nonatomic, retain) DN_NewsDetailModel *model;
@end

@implementation DN_NewsContentVC

ROUTER_PATH(@"NewsContentVC")

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"正文";
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[self.model.content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.sourceLabel.text = self.model.source;
    self.titleLabel.text = self.model.title;
    self.dateLabel.text = self.model.pubdate;
    self.contentLabel.attributedText = attrStr;
    [[self.linkButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [self.navigationController pushURL:self.model.link_source animated:YES completion:nil];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
