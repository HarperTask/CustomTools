//
//  Json.m
//  
//
//  Created by Admin on 17/4/12.
//
//

#import "Json.h"

@implementation Json

/** JSON -> 字典 */
+ (NSDictionary *)jsonToDictionary:(NSString *)json {
    
    if (!json) {
        
        return nil;
        
    }
    
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    if(error) {
        NSLog(@"json解析失败：%@", error);
        
        return nil;
        
    }
    
    return dic;
    
}


/** 字典 -> JSON */
+ (NSString *)dictionaryToJson:(NSDictionary *)dic {
    
    NSError *error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}




@end
