//
//  JRDeviceType.h
//  RWAssistant
//
//  Created by 姚俊任 on 2016/12/6.
//  Copyright © 2016年 韩鹏帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JRDeviceType : NSObject
/**
 获取设备的类型

 @return 设备类型(NSString)
 */
+ (NSString *)getCurrentDeviceModel;
@end
