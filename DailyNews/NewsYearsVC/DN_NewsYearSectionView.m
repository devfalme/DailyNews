//
//  DN_NewsYearSectionView.m
//  DailyNews
//
//  Created by devfalme on 2019/1/11.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "DN_NewsYearSectionView.h"
@interface DN_NewsYearSectionView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation DN_NewsYearSectionView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)title:(NSString *)title {
    self.titleLabel.text = title;
}

@end
