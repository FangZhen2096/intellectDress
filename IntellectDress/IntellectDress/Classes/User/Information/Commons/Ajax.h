//
//  AJAX.h

//
//  Created by 小强 on 14-11-9.

//

#import <Foundation/Foundation.h>
@interface Ajax : NSObject
-(instancetype)init;
-(void)dicWithUrl:(NSString*)url params:(NSDictionary*)params callback:(void (^)(BOOL isError,NSDictionary* json))callback  post:(BOOL) isPost;
-(void)directRequestWithParams:(NSString*)url params:(NSDictionary*)params calback:(CallBack) callback;
-(void)uploadWithUrl:(NSString*)url data:(NSData*)data name:(NSString*)name callback:(void (^)(BOOL isError,NSDictionary* json))callback params:(NSDictionary*) params mimeType:(NSString*)mimeType;
-(void)uploadImages:(CallBack)callback url:(NSString*)url images:(NSArray*)images params:(NSDictionary*) params;
-(void)soapRequest:(NSString*)urlStr op:(NSString*)op action:(NSString*)action params:(NSString*)params callback:(CallBack)callback;
@end
