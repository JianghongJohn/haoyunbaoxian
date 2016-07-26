//
//  NSString+ToJson.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/22.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "NSDictionary+ToJson.h"

@implementation NSDictionary (ToJson)
+(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
@end
