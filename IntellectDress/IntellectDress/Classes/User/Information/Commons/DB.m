//
//  DB.m
//  DBKit
//
//  Created by 小强 on 16/3/9.
//  Copyright © 2016年 geluya. All rights reserved.


#define FMDBQuickCheck(SomeBool) { if (!(SomeBool)) { NSLog(@"Failure on line %d", __LINE__); abort(); } }


#import "DB.h"
#import "FMDB.h"
@interface DB()
@property (nonatomic)FMDatabase*db;
@end
@implementation DB
-(instancetype)init{
    self = [super init];
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSMutableString *cachesDir = [[paths objectAtIndex:0] mutableCopy];;
        [cachesDir appendString:@"/app.db"];
        _db = [FMDatabase databaseWithPath:cachesDir];
    }
    return  self;
    
}
-(instancetype)initWithDBPath:(NSString*)dbPath{
    self = [super init];
    if (self) {
        _db = [FMDatabase databaseWithPath:dbPath];
    }
    return  self;
}
-(BOOL)addTable:(NSString*)sql{
    if ( [_db open]) {
        FMDBQuickCheck(sql);
        [_db executeUpdate:sql];
    }else{
        return  NO;
    }
    [_db close];
    return YES;
}
-(void)query:(NSString*)sql callback:(void(^)(NSMutableArray*result)) callback{
    [_db open];
    FMDBQuickCheck(sql);
    FMResultSet *rs = [_db executeQuery:sql];
    NSMutableArray*queryResult = [[NSMutableArray alloc] init];
    while ([rs next]) {
        NSDictionary*item= [rs resultDictionary];
        [queryResult addObject:item];
    }
    callback(queryResult);
    [rs close];
    [_db close];
}
-(BOOL)idu:(NSString*)sql{
    if ([_db open]) {
        FMDBQuickCheck(sql);
        BOOL result= [_db executeUpdate:sql];
        [_db close];
        return result;
    }else{
        return  NO;
    }
    return NO;
}
@end
