//
//  BlueToothManager.m
//  JusAuto
//
//  Created by ju on 2017/2/27.
//  Copyright © 2017年 ju. All rights reserved.
//

#import "BlueToothManager.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface BlueToothManager ()
@property (nonatomic, strong) CBCentralManager *bluetoothManager;
@property (nonatomic, assign) BOOL bluetoothOpened;
@end

@implementation BlueToothManager
+ (instancetype)sharedInstance
{
    static BlueToothManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(!instance)
        {
            instance = [[BlueToothManager alloc] init];
        }
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _bluetoothManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil]; 
        self.bluetoothOpened = NO;
    }
    return self;
}

#pragma mark - CLLocationManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) {
            
        case CBCentralManagerStatePoweredOff:
            {
                self.bluetoothOpened = NO;
            }
            break;
        case CBCentralManagerStatePoweredOn:
            {
                self.bluetoothOpened = YES;
            }
            break;
        case CBCentralManagerStateResetting:
            break;
        case CBCentralManagerStateUnauthorized:
            break;
        case CBCentralManagerStateUnknown:
            break;
        case CBCentralManagerStateUnsupported:
            
            break;
        default:
            break;
    }
}

//连接到Peripherals-成功
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@">>>连接到名称为（%@）的设备-成功",peripheral.name);
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(blueToothConnected:)])
    {
        [self.delegate blueToothConnected:YES];
    }
}

//连接到Peripherals-失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@">>>连接到名称为（%@）的设备-失败,原因:%@",[peripheral name],[error localizedDescription]);
}

//Peripherals断开连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@">>>外设连接断开连接 %@: %@\n", [peripheral name], [error localizedDescription]);
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(blueToothDisConnected:)])
    {
        [self.delegate blueToothDisConnected:YES];
    }
    
}

- (BOOL)blueToothOpened
{
    return self.bluetoothOpened;
}
@end
