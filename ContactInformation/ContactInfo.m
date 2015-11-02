//
//  ContactInfo.m
//  
//
//  Created by jason on 15/11/2.
//
//

#import <Foundation/Foundation.h>
#import "ContactInfo.h"

@implementation ContactInfo

- (ContactInfo*) initWithFirstName:(NSString *)firstName andLastName:(NSString *)lastName andPhoneNumber:(NSString *)phoneNumber
{
    if(self=[super init])
    {
        _firstName = firstName;
        _lastName = lastName;
        _phoneNumber = phoneNumber;
    }
    
    return self;
}

+ (ContactInfo*) initWithFirstName:(NSString *)firstName andLastName:(NSString *)lastName andPhoneNumber:(NSString *)phoneNumber
{
    ContactInfo* contact = [[ContactInfo alloc] initWithFirstName:firstName andLastName:lastName andPhoneNumber:phoneNumber];
    
    return contact;
}

- (NSString*) getName
{
    if (_lastName.length == 0) {
        return [NSString stringWithFormat:@"%@", _firstName];
    }
    else if (_firstName.length == 0)
    {
        return [NSString stringWithFormat:@"%@", _lastName];
    }
    else
    {
        return [NSString stringWithFormat:@"%@ %@", _lastName, _firstName];
    }
}
@end

//////////////

@implementation ContactGroup

- (ContactGroup*) initWithGroupName:(NSString *)groupName andGroupDetail:(NSString *)groupDetail andContactInfos:(NSMutableArray *)contactInfos
{
    if (self=[super init]) {
        _groupName = groupName;
        _groupDetail = groupDetail;
        _contactInfos = contactInfos;
    }
    
    return self;
}

+ (ContactGroup*) initWithGroupName:(NSString *)groupName andGroupDetail:(NSString *)groupDetail andContactInfos:(NSMutableArray *)contactInfos
{
    ContactGroup* group = [[ContactGroup alloc] initWithGroupName:groupName andGroupDetail:groupDetail andContactInfos:contactInfos];
    
    return group;
}
@end