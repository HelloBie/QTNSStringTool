//
//  NSString+QTNSStringTool.h
//  QTNSStringTool
//
//  Created by MasterBie on 2023/9/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// NSString 常用工具方法
@interface NSString (QTNSStringTool)

#pragma mark - 验证

/// 判断是否包含中文
- (BOOL)containChinese;


#pragma mark - UI

/// 计算文本高度
/// - Parameters:
///   - width:  文本最大宽度
///   - lineSpacing: 行间距(没有行间距就传0)
///   - font: 文本字体大小
- (CGFloat)getTextHeightWithWidth:(CGFloat)width
                  withLineSpacing:(CGFloat)lineSpacing
                         withFont:(CGFloat)font;


#pragma mark - 数据处理

/// 数字金额转化为大写汉字
- (NSString *)convertAmount;

/// 数字类型字符串转化为保留若干位小数
/// - Parameter position: 需要保留的小数位
- (NSString *)notRoundingAfterPoint:(NSInteger)position;

/// json字符串转化字典或数组
- (id)stringToJSONObject;

/// 字典或数组转化成json字符串
/// - Parameter jsonObject: 需要转化的字典或者数组
+ (NSString *)jsonObjectToString:(id)jsonObject;

/// 生成 32位小写 MD5字符串
- (NSString *)MD5ForLower32Bate;

/// 生成 32位大写 MD5字符串
- (NSString *)MD5ForUpper32Bate;

/// 生成 16位 大写 MD5字符串
- (NSString *)MD5ForUpper16Bate;

/// 生成 16位 小写 MD5字符串
- (NSString *)MD5ForLower16Bate;

#pragma mark - 快速数据获取

/// 获取系统版本号
+ (NSString*)SystemVersion;

@end

NS_ASSUME_NONNULL_END