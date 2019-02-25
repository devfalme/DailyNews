//
//  DN_NewsYearsHeaderView.m
//  DailyNews
//
//  Created by devfalme on 2019/1/11.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "DN_NewsYearsHeaderView.h"
@interface DN_NewsYearsHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end
@implementation DN_NewsYearsHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)title:(NSString *)title {
    self.titleLabel.text = [NSString stringWithFormat:@"%@年度資訊", title];
    self.subTitleLabel.text = [NSString stringWithFormat:@"Best of %@", title];
}

@end
