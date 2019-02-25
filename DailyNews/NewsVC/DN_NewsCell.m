//
//  DN_NewsCell.m
//  DailyNews
//
//  Created by devfalme on 2019/1/6.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "DN_NewsCell.h"
#import "DN_AnootationModel.h"
@interface DN_NewsCell ()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *topicLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end
@implementation DN_NewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)model:(DN_NewsModel *)model action:(void(^)(void))action {
    self.dateLabel.text = model.date;
    [self.imageView sd_setImageWithURL:model.thumbImage placeholderImage:[UIImage imageNamed:@"PlaceHolder"] options:SDWebImageRetryFailed];
    self.titleLabel.text = model.title;
    [self.topicLabel setTitle:model.topic forState:UIControlStateDisabled];
    self.contentLabel.text = model.content;
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(model.latitude, model.longitude);
    DN_AnootationModel *annotation = [DN_AnootationModel coordinate:coordinate titile:@""];
    [_mapView addAnnotation:annotation];
    [_mapView setRegion:MKCoordinateRegionMakeWithDistance(coordinate, 2000, 2000)];
    _mapView.userInteractionEnabled = NO;
    [[[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        action();
    }];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MapSample"];
    annotationView.canShowCallout = YES;
    return annotationView;
}
@end
