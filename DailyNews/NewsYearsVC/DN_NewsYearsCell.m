//
//  DN_NewsYearsCell.m
//  DailyNews
//
//  Created by devfalme on 2019/1/11.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "DN_NewsYearsCell.h"
@interface DN_NewsYearsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
@implementation DN_NewsYearsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)model:(DN_NewsYearsModel *)model {
    [self.imageView sd_setImageWithURL:model.cover_thumb placeholderImage:nil options:SDWebImageRetryFailed];
}

@end
