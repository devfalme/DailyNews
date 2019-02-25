//
//  DN_NewsDetailCell.m
//  DailyNews
//
//  Created by devfalme on 2019/1/6.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "DN_NewsDetailCell.h"
@interface DN_NewsDetailCell ()

@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;



@end
@implementation DN_NewsDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)model:(DN_NewsDetailModel *)model {
    self.sourceLabel.text = model.source;
    [self.sourceLabel sizeToFit];
    self.titleLabel.text = model.title;
    [self.titleLabel sizeToFit];
    self.dateLabel.text = model.pubdate;
    [self.dateLabel sizeToFit];
}
@end
