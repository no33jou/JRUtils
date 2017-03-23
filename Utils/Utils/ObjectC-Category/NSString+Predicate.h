//
//  NSString+Predicate.h
//  YJCatogory
//
//  Created by BeijingHC on 15/7/14.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Predicate)
- (BOOL)isTelephone;

- (BOOL)isUserName;

- (BOOL)isPassword;
- (BOOL)isEmail;
- (BOOL)isUrl;


- (BOOL)isPureIn;


- (BOOL)isPureFloat;


/**
 *  是否数字
 *
 *  @return 是否数字
 */
-(BOOL)isValidNumber;

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

@end
