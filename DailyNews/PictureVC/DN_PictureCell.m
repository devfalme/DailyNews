//
//  DN_PictureCell.m
//  DailyNews
//
//  Created by devfalme on 2019/1/6.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "DN_PictureCell.h"
#import "DN_AnootationModel.h"

@interface DN_PictureCell ()<MKMapViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *publishDate;
@property (weak, nonatomic) IBOutlet UIImageView *up;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@end
@implementation DN_PictureCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)model:(DN_PictureModel *)model save:(void(^)(void))save share:(void(^)(void))share{
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    self.publishDate.text = model.pubdate;
    self.dateLabel.text = model.title;
    [self.image sd_setImageWithURL:model.cover placeholderImage:[UIImage imageNamed:@"PlaceHolder"] options:SDWebImageRetryFailed];
    self.contentLabel.text = model.content;
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(model.latitude, model.longitude);
    DN_AnootationModel *annotation = [DN_AnootationModel coordinate:coordinate titile:@""];
    [_mapView addAnnotation:annotation];
    [_mapView setRegion:MKCoordinateRegionMakeWithDistance(coordinate, 2000, 2000)];
    _mapView.userInteractionEnabled = NO;
    [[[self.saveButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        save();
    }];
    
    [[[self.shareButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        share();
    }];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MapSample"];
    annotationView.canShowCallout = YES;
    return annotationView;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView.contentOffset.y <= 60) {
//        self.up.alpha = (60 - scrollView.contentOffset.y) / 60;
//    }
//}

@end
