//
//  DawnAlarm.m
//
//  Created by DawnTeam on 4/12/15.
//  Copyright (c) 2015 Dawnteam. All rights reserved.
//
//  A DawnAlarm has properties name, alarmtime, firstNote, preferences


#import "DawnAlarm.h"
#import "DawnUser.h"

extern DawnUser *currentUser;

@implementation DawnAlarm

// initialize without any knowledge of alarm
- (id)init
{
    self = [super init];
    if (self) {
        self = [self initWithName:@"Default Alarm" andDate:[NSDate date]];
    }
    return self;
}

// initialize with name and Date known
- (id)initWithName:(NSString*) name andDate:(NSDate*) date
{
    self = [super init];
    if (self) {
        _name = name;
        _alarmTime = date;
        _notes = @"";
        _isOn = true;
        _isNew = true;
        _snooze = true;
        // figure out how to copy the User's defualt preferences and save as new preferences
        _prefs = [DawnPreferences new];
        _prefs = [self.prefs initWithName:@"Alarm Default Preferences"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"aName"];
    [aCoder encodeObject:self.alarmTime forKey:@"aTime"];
    [aCoder encodeObject:self.notes forKey:@"aNotes"];
    [aCoder encodeBool:self.isOn forKey: @"aisOn"];
    [aCoder encodeBool:self.isNew forKey: @"aisNew"];
    [aCoder encodeBool:self.snooze forKey: @"asnooze"];
    [aCoder encodeObject:self.prefs forKey:@"aPrefs"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:@"aName"];
        _alarmTime = [aDecoder decodeObjectForKey:@"aTime"];
        _notes = [aDecoder decodeObjectForKey:@"aNotes"];
        _isOn = [aDecoder decodeBoolForKey:@"aisOn"];
        _isNew = [aDecoder decodeBoolForKey:@"aisNew"];
        _snooze = [aDecoder decodeBoolForKey:@"asnooze"];
        _prefs = [aDecoder decodeObjectForKey:@"aPrefs"];
    }
    return self;
}

-(BOOL)isEqual:(id)object {
    DawnAlarm *that = object;
    if (![self.name isEqualToString:that.name]) {
        NSLog(@"Names don't match");
        return FALSE;
    }
    if (![self.alarmTime isEqualToDate:that.alarmTime]) return FALSE;
    if (![self.notes isEqualToString:that.notes]) return FALSE;
    if (self.isOn != that.isOn) return FALSE;
    if (self.isNew != that.isNew) return FALSE;
    else {
        NSLog(@"Names do match, returning true");
        return TRUE;
    }
}

@end
