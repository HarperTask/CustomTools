//
//  Json.h
//  
//
//  Created by Admin on 17/4/12.
//
//

#import <Foundation/Foundation.h>

@interface Json : NSObject

/** JSON -> 字典 */
+ (NSDictionary *)jsonToDictionary:(NSString *)json;

/** 字典 -> JSON */
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;


@end
