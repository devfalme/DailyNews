//
//  DN_NewsYearsContentCell.m
//  DailyNews
//
//  Created by devfalme on 2019/1/11.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "DN_NewsYearsContentCell.h"
#import "DN_AnootationModel.h"

@interface DN_NewsYearsContentCell ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *newsLabel;

@end
@implementation DN_NewsYearsContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)model:(DN_NewsYearsModel *)model {
    [self.imageView sd_setImageWithURL:model.cover_landscape placeholderImage:nil options:SDWebImageRetryFailed];
    self.contentLabel.text = model.content;
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(model.latitude, model.longitude);
    DN_AnootationModel *annotation = [DN_AnootationModel coordinate:coordinate titile:@""];
    [_mapView addAnnotation:annotation];
    [_mapView setRegion:MKCoordinateRegionMakeWithDistance(coordinate, 2000, 2000)];
    _mapView.userInteractionEnabled = NO;
    self.newsLabel.hidden = model.news_count;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MapSample"];
    annotationView.canShowCallout = YES;
    return annotationView;
}

@end
