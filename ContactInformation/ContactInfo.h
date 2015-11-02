//
//  ContactInfo.h
//  ContactInformation
//
//  Created by jason on 15/11/2.
//  Copyright (c) 2015年 JasonAi. All rights reserved.
//

#ifndef ContactInformation_ContactInfo_h
#define ContactInformation_ContactInfo_h

#import <Foundation/Foundation.h>

@interface ContactInfo : NSObject

#pragma mark 姓
@property (nonatomic, copy) NSString* firstName;

#pragma mark 名
@property (nonatomic, copy) NSString* lastName;

#pragma mark 手机号
@property (nonatomic, copy) NSString* phoneNumber;

#pragma mark 获取姓＋名
- (NSString*)getName;

- (ContactInfo*) initWithFirstName:(NSString*) firstName andLastName:(NSString*) lastName andPhoneNumber:(NSString*) phoneNumber;

+ (ContactInfo*) initWithFirstName:(NSString*) firstName andLastName:(NSString*) lastName andPhoneNumber:(NSString*) phoneNumber;
@end

////////////////

@interface ContactGroup : NSObject

@property (nonatomic, copy) NSString* groupName;

@property (nonatomic, copy) NSString* groupDetail;

@property (nonatomic, strong) NSMutableArray* contactInfos;

- (ContactGroup*) initWithGroupName:(NSString*) groupName andGroupDetail:(NSString*) groupDetail andContactInfos:(NSMutableArray*) contactInfos;

+ (ContactGroup*) initWithGroupName:(NSString*) groupName andGroupDetail:(NSString*) groupDetail andContactInfos:(NSMutableArray*) contactInfos;

@end

#endif
