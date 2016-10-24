//
//  AJAX.m

//
//  Created by 小强 on 14-11-9.

//

#import "Ajax.h"
@interface Ajax()
@property AFHTTPSessionManager*manager;
@property NSString* baseUrl;
@end
@implementation Ajax
-(instancetype)init{
    self = [super init];
    if (self) {
        _manager = [AFHTTPSessionManager manager] ;
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return self;
}
-(void)directRequestWithParams:(NSString*)url params:(NSDictionary*)params calback:(CallBack) callback{
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [_manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject==nil) {
            callback(YES,nil);
            return ;
        }
        callback(NO,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callback(YES,nil);
    }];
}
-(void)setHeader:(NSDictionary*)header{
    
}
-(void)dicWithUrl:(NSString*)url params:(NSDictionary*)params callback:(void (^)(BOOL isError,NSDictionary* json))callback  post:(BOOL) isPost{
    
    DLog(@"%@ url=== %@,param==%@",isPost?@"post":@"get",url,params);
    //设置header
    //    NSString* locHeader =[Config get:@"SESSION"] ;
    //    if (locHeader) {
    //    NSDictionary* SESSION = [JSON parse:locHeader] ;
    //        if (SESSION) {
    //            NSString* header = [NSString stringWithFormat:@"%@,%@",SESSION[@"uid"],SESSION[@"sid"]];
    //            [ _manager.requestSerializer setValue:header forHTTPHeaderField:@"USER-TOKEN"];
    //        }
    //    }
    if (isPost) {
        [_manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (responseObject==nil) {
                callback(YES,nil);
                return ;
            }
            NSError *err = nil;
            NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                options:0
                                                                  error:&err];
            if(err){
                callback(YES,nil);
            }else{
                callback(NO
                         ,dic);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
#ifdef  DEBUG
            ALERT(FORMAT(@"%@",error));
#endif
            ALERT(@"网络异常");
            callback(YES,nil);
            return;
        }];
    }else{
        [_manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSError *err = nil;
            NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                options:0
                                                                  error:&err];
            if(err){
                callback(YES,nil);
            }else{
                callback(NO
                         ,dic);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            DLog(@"请求url===%@ \n params%@",url,params);
            callback(YES,nil);
#ifdef  DEBUG
            ALERT(FORMAT(@"%@",error));
#endif
            
            ALERT(@"网络异常");
        }];
        //        [_manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //            NSError *err = nil;
        //            NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:responseObject
        //                                                                options:0
        //                                                                  error:&err];
        //            if(err){
        //                callback(YES,nil);
        //            }else{
        //                callback(NO
        //                         ,dic);
        //            }
        //        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //            ;
        //
        //            DLog(@"请求url===%@ \n params%@",url,params);
        //            callback(YES,nil);
        //#ifdef  DEBUG
        //            ALERT(FORMAT(@"%@",error));
        //#endif
        //
        //            ALERT(@"网络异常");
        //
        //
        //            return;
        //        }];
    }
}

-(void)uploadImages:(CallBack)callback url:(NSString*)url images:(NSArray*)images params:(NSDictionary*) params{
    DLog(@"%@ url=== %@,param==%@",@"post",url,params);
    [_manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSInteger i = 0;  i<images.count;i++) {
            NSData *imageData =UIImageJPEGRepresentation(images[i], 0.5);
            //avatar 是参数名称
            [formData appendPartWithFileData:imageData name:@"avatar" fileName:FORMAT(@"%ld.jpg",(long)i) mimeType:@"image/*"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *err = nil;
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:0
                                                              error:&err];
        if(err){
            callback(YES,nil);
        }else{
            callback(NO
                     ,dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callback(YES,nil);
    }];
}

-(void)uploadWithUrl:(NSString*)url data:(NSData*)data name:(NSString*)name callback:(void (^)(BOOL isError,NSDictionary* json))callback params:(NSDictionary*) params mimeType:(NSString*)mimeType{
    //    DLog(@"url===%@,param==%@",url,params);
    //    [_manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    //        NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    //        NSTimeInterval a = [date timeIntervalSince1970];
    //        NSString *timeString = [NSString stringWithFormat:@"%f", a];
    //        [formData appendPartWithFileData:data name:name fileName:timeString mimeType:mimeType];
    //    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //
    //        callback(NO,responseObject);
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //
    //#ifdef  DEBUG
    //        ALERT(FORMAT(@"%@",error));
    //#endif
    //        ALERT(@"网络异常");
    //
    //        callback(YES,nil);
    //    }];
}

-(void)soapRequest:(NSString*)urlStr op:(NSString*)op action:(NSString*)action params:(NSString*)params callback:(CallBack)callback{
    //
    //    NSMutableString*soapMessage = [[NSMutableString alloc]init];
    //    [ soapMessage appendString:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body>"];
    //    [soapMessage appendFormat:@"<%@ xmlns=\"http://www.wobangli.com/\">",op];
    //    [soapMessage appendString:params];
    //    [soapMessage appendFormat:@"</%@>",op];
    //    [soapMessage appendString:@"</soap:Body></soap:Envelope>"];
    //    NSData *soapData = [soapMessage dataUsingEncoding:NSUTF8StringEncoding];
    //    NSURL *url = [NSURL URLWithString:urlStr];
    //    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    //    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    //
    //    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //    [theRequest addValue: action forHTTPHeaderField:@"SOAPAction"];
    //    [theRequest addValue:@"www.wobangli.com" forHTTPHeaderField:@"Host"];
    //    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    //    [theRequest setHTTPMethod:@"POST"];
    //    [theRequest setHTTPBody:soapData];
    //    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
    //
    //    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    //
    //    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    //
    //        //        if ([responseObject isKindOfClass:[NSXMLParser class]]) {
    //        //            NSXMLParser *parser = (NSXMLParser *)responseObject;
    //        //            NSError*error;
    //        //            NSDictionary* root = [XMLReader dictionaryForNSXMLParser:parser error:&error];
    //        //            if (error) {
    //        //                callback(YES,nil);
    //        //                return ;
    //        //            }
    //        //
    //        //            NSDictionary*Envelope = root[@"s:Envelope"];
    //        //            if (Envelope==nil) {
    //        //                Envelope = root[@"soap:Envelope"];
    //        //            }
    //        //            NSDictionary* Body = Envelope[@"s:Body"];
    //        //            if (Body==nil) {
    //        //                Body =Envelope[@"soap:Body"];
    //        //            }
    //        //            NSDictionary* Response  = Body[FORMAT(@"%@Response",op)];
    //        //            NSDictionary* result = Response[FORMAT(@"%@Result",op)];
    //        //
    //        //            callback(NO,result);
    //        //
    //        //
    //        //        }
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //
    //        callback(YES,nil);
    //
    //    }];
    //    [[NSOperationQueue mainQueue] addOperation:operation];
    
    
}

@end
