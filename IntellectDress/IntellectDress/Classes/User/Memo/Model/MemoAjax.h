//
//  MemoAjax.h
//  IntellectDress
//
//  Created by zerom on 16/10/19.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemoAjax : NSObject
+ (void)MemoListWithSuccess:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;
+ (void)MemoDetailsWithBid:(NSString *)bid Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;
+ (void)DelMemoDetailsWithBid:(NSString *)bid Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;
+ (void)addNewMemoDetailsWithStart:(NSString *)start end:(NSString *)end info:(NSString *)info mark:(NSString *)mark  Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;
+ (void)SaveMemoDetailsWithBid:(NSString *)bid Info:(NSString *)info mark:(NSString *)mark  Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;
+ (void)DelsMemoDetailsWithBid:(NSString *)bids Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;

@end
