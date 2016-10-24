


//  Created by 小强  on 15/9/17.


#import "Convert.h"
static NSArray *flagIndex;
@implementation Convert

+(void)initialize
{
    /**
     *  初始化索引拼音
     */
    flagIndex = @[@"*",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",
            @"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",
            @"T",@"U",@"V",@"W",@"X",@"Y",@"Z"
            ];
}
+(NSArray *)convertToPinyinWithArray:(NSArray *)array key:(NSString *)key{
    /**
     *  得到所有属性值
     */
    NSMutableArray *propertyValue = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        /**
         *  封装成pinyin对象
         */
        NSString *pv =  [obj valueForKey:key];

        //转换为带声调的拼音
        /**
         *  非常耗时的操作
         */
        //  CFAbsoluteTime start =  CFAbsoluteTimeGetCurrent();
        NSMutableString *str = [pv mutableCopy];
        
        CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
        //    CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
        //    NSLog(@"转换为带声调的拼音 = %f",end - start);
        NSMutableDictionary*item = [obj mutableCopy];
        [propertyValue addObject:item];
    }];
    /**
     *  拼音匹配
     */
    NSMutableArray *ctns = [NSMutableArray array];
     for (int i = 0; i< flagIndex.count;i++) {
         NSMutableDictionary *resultItem =[[NSMutableDictionary alloc] init];
        NSString *flagStr  = flagIndex[i];
         resultItem[@"firstLetter"] = flagStr;
         /**
          *  设置过滤器
          */
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"letter BEGINSWITH[cd] %@",flagStr];
         /**
          *  过滤数组
          */
        NSArray *array = [propertyValue filteredArrayUsingPredicate:pred];
         /**
          *  已经匹配过的移除
          */
         [propertyValue removeObjectsInArray:array];
         
     NSMutableArray *arr = [NSMutableArray array];
     
     [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
          [arr addObject:obj];
     }];
         resultItem[@"firstLetterValues"] = arr;

         /**
          *  排除匹配数量为0的
          */
         if (arr.count != 0) {
             [ctns addObject:resultItem];
         }
     
    }
    return ctns;

}

+(void)convertToPinyinWithArray:(NSArray *)array key:(NSString *)key UsingBlock:(convertResultBlock)resultBlock{
   
    /**
     *  开辟一个串行对列
     */
     const char *queueName = "convertQueue";
    dispatch_async(dispatch_queue_create(queueName, DISPATCH_QUEUE_SERIAL), ^{

        
       NSArray *arr =  [self convertToPinyinWithArray:array key:key];
        //将转好的做文件缓存
//        NSArray*paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//        NSString*path = paths[0];
//        NSString* filePath = [path stringByAppendingString:@"afile"];
//        [arr writeToFile:filePath atomically:YES];
//        NSArray*Arr = [NSArray arrayWithContentsOfFile:filePath];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (resultBlock) {
                resultBlock(arr);
            }
        }) ;
        
    });

}

@end
