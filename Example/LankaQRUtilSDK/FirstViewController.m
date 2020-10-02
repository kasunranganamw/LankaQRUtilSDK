//
//  FirstViewController.m
//  LankaQRUtilSDK_Example
//
//  Created by Kasun Rangana M W on 10/2/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

#import "FirstViewController.h"
#import "LankaQRUtilSDK-Swift.h"
@import MPQRCoreSDK;

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    LankaQRReader *lqr = [LankaQRReader new];
    PushPaymentData *pushPaymentData = [lqr parseQRWithQrString:@"0002010102112632002816728000581200000000100000055204581253031445502015802LK5909Vits Food6007Colombo61050080062580032537c0a88562e4a599cab63d1992f0dac05181600766683296-000563042AB7"];
    if (pushPaymentData != nil) {
        NSError *error;
        NSString *result = [pushPaymentData generatePushPaymentString:&error];
        if (error == nil) {
            NSLog(@"\n-------------------- RESULT IN OBJ-C EXAMPLE --------------------\n%@", result);
        }
    } else {
        NSLog(@"ERROR");
    }
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
