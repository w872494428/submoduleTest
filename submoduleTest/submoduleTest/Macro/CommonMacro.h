//
//  CommonMacro.h
//  MTReader
//
//  Created by mitu on 2021/7/27.
//

#ifndef CommonMacro_h
#define CommonMacro_h

// 字符串是否为空
#define kADSYStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || ![str isKindOfClass:[NSString class]] || [str length] < 1 ? YES : NO)
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
// 数组是否为空
#define kADSYArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || ![array isKindOfClass:[NSArray class]] || array.count == 0)
// 字典是否为空
#define kADSYDictIsEmpty(dict) (dict == nil || [dict isKindOfClass:[NSNull class]] || ![dict isKindOfClass:[NSDictionary class]] || dict.allKeys.count == 0)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys.count == 0)
// 对象是否为空
#define kADSYObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [_object isKindOfClass:[NSData class]] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [_object isKindOfClass:[NSArray class]] && [(NSArray *)_object count] == 0))


#endif /* CommonMacro_h */
