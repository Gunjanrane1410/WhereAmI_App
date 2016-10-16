//
//  ViewController.h
//  GRmapview
//
//  Created by Student P_08 on 12/10/16.
//  Copyright © 2016 Gunjan Rane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>

{
    
    CLLocationManager *locationmanager;
    UISegmentedControl *segmentControl;

}
@property (strong, nonatomic) IBOutlet MKMapView *myMapView;
- (IBAction)mapChangeAction:(id)sender;

- (IBAction)startDetectionAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *latitudeLable;
@property (strong, nonatomic) IBOutlet UILabel *longitudeLable;
@property (strong, nonatomic) IBOutlet UILabel *altitudeLable;

@property (strong, nonatomic) IBOutlet UILabel *speedLable;
@end

