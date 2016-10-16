//
//  ViewController.m
//  GRmapview
//
//  Created by Student P_08 on 12/10/16.
//  Copyright © 2016 Gunjan Rane. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self startLocation];
    UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handlelongpress:)];
    
    longpress.minimumPressDuration=2;
    //[self.mapview addGestureRecognizer:longpress];
    [self.myMapView addGestureRecognizer:longpress];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)handlelongpress:(UILongPressGestureRecognizer *)gesture{
    CLLocationCoordinate2D pressedcoordinate;
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        CGPoint pressLocation = [gesture locationInView:gesture.view];
        
        pressedcoordinate = [self.myMapView convertPoint:pressLocation toCoordinateFromView:gesture.view];
        MKPointAnnotation *myannotation = [[MKPointAnnotation alloc]init];
        myannotation.coordinate = pressedcoordinate;
        
        CLGeocoder *geocoder =[[CLGeocoder alloc]init];
        
        CLLocation *Location =[[CLLocation alloc]initWithLatitude:pressedcoordinate.latitude longitude:pressedcoordinate.longitude];
        
        
       [geocoder reverseGeocodeLocation:Location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
           
           if (placemarks.count >0)
           {
               CLPlacemark *myplacemark = placemarks.lastObject;
               
               NSString *title = [myplacemark.subThoroughfare stringByAppendingString:myplacemark.subThoroughfare];
               
               NSString *subTitle =myplacemark.locality;
               
               myannotation.title = title;
               
               myannotation.subtitle = subTitle;
               
               [self.myMapView addAnnotation:myannotation];
               
               
               
               
           }
           
           else{
               
               myannotation.title = @"unkown place";
               [self.myMapView addAnnotation:myannotation];
           }
        }
        
        
        
        ];
    
    
    }
    else if(gesture.state == UIGestureRecognizerStateEnded){
        
    }
        }
        
//
//            CLPlacemark *myplacemar;
//            
//            NSString *title = [myplacemarks.subThoroughfare stringByAppendingString:myplacemarks.thoroughfare]
//            
    
-(void)startLocation{
    
    
    locationmanager = [[CLLocationManager alloc]init];
    
    locationmanager.delegate = self;
    
    [locationmanager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    [locationmanager requestWhenInUseAuthorization];
    
    [locationmanager startUpdatingLocation];
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{

    CLLocation *currentLocation = [locations lastObject];
    
    NSLog(@"latitude : %f",currentLocation.coordinate.latitude);
    NSLog(@"longitude : %f",currentLocation.coordinate.longitude);
    NSLog(@"altitude : %f",currentLocation.altitude);
    NSLog(@"speed : %f",currentLocation.speed);

    MKCoordinateSpan mySpan = MKCoordinateSpanMake(0.001,0.001);
    
    MKCoordinateRegion myregion = MKCoordinateRegionMake(currentLocation.coordinate, mySpan);
    
    [self.myMapView setRegion:myregion animated:YES];
    _latitudeLable.text = [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
    _longitudeLable.text = [NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
    _altitudeLable.text = [NSString stringWithFormat:@"%f",currentLocation.altitude];
    _speedLable.text = [NSString stringWithFormat:@"%f",currentLocation.speed];
    

    
    
    
    if (currentLocation != nil) {
        [locationmanager stopUpdatingLocation];
    }
    
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%@",error.localizedDescription);
}
        
- (IBAction)mapChangeAction:(id)sender {
    
    if(segmentControl.selectedSegmentIndex == 0){
        [self.myMapView setMapType:MKMapTypeStandard];
    }
    else if (segmentControl.selectedSegmentIndex == 1){
        [self.myMapView setMapType:MKMapTypeSatellite];
        
    }
    else if (segmentControl.selectedSegmentIndex == 2){
        [self.myMapView setMapType:MKMapTypeHybrid];
    }
}

- (IBAction)startDetectionAction:(id)sender {
    
    [self startLocation];
    
}
@end
