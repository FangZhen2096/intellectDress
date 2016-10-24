//
//  DB.h
//
//  Created by 小强 on 16/3/9.
//  Copyright © 2016年 geluya. All rights reserved.
//

//基于FMDB  添加libsqlite3.tbd
//NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//NSMutableString *cachesDir = [[paths objectAtIndex:0] mutableCopy];;
//[cachesDir appendString:@"/a.db"];
//DB*db = [[DB alloc] initWithDBPath:cachesDir];
//[db addTable:@"CREATE TABLE PersonList (Name text, Age integer, Sex integer, Phone text, Address text, Photo blob)"];
//BOOL add=    [db idu:@"INSERT INTO PersonList (Name, Age, Sex, Phone, Address, Photo) VALUES (1,1,1,1,1,1)"];
//BOOL delete=  [db idu:@"delete from  PersonList"];
//[db query:@"select * from PersonList" callback:^(NSMutableArray *result) {
//    NSLog(@"%@",result);
//}];
#import <Foundation/Foundation.h>
@interface DB : NSObject
-(instancetype)initWithDBPath:(NSString*)dbPath;
-(BOOL)addTable:(NSString*)sql;
-(void)query:(NSString*)sql callback:(void(^)(NSMutableArray*result)) callback;
-(BOOL)idu:(NSString*)sql;


@end
