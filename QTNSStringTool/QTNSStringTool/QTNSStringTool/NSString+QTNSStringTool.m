//
//  NSString+QTNSStringTool.m
//  QTNSStringTool
//
//  Created by MasterBie on 2023/9/15.
//

#import "NSString+QTNSStringTool.h"
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (QTNSStringTool)





#pragma mark - 验证

/// 判断是否包含中文
- (BOOL)containChinese {
    for(int i=0; i< [self length];i++){
        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}



#pragma mark - UI

/// 计算文本高度
/// - Parameters:
///   - width:  文本最大宽度
///   - lineSpacing: 行间距(没有行间距就传0)
///   - font: 文本字体大小
- (CGFloat)getTextHeightWithWidth:(CGFloat)width
                  withLineSpacing:(CGFloat)lineSpacing
                         withFont:(CGFloat)font {
    if (self.length == 0) {
        return 0;
    }
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = lineSpacing;
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:self
                                                                                       attributes:@{NSParagraphStyleAttributeName:paraStyle,NSFontAttributeName:[UIFont systemFontOfSize:font]}];
    
    CGRect rect = [attributeString boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                                options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                context:nil];
    
    if ((rect.size.height - [UIFont systemFontOfSize:font].lineHeight)  <= lineSpacing){
        if ([self containChinese]){
            rect.size.height -= lineSpacing;
        }
    }
    return rect.size.height;
}


#pragma mark - 数据处理

/// 数字金额转化为大写汉字
- (NSString *)convertAmount {
    if ([self doubleValue] == [@"0.00" doubleValue])
    {
        return @"零元整";
    }

    //首先转化成标准格式        “200.23”
    NSString *doubleStr = nil;
    doubleStr = [self notRoundingAfterPoint:2];
    if (![doubleStr containsString:@"."]) {
        doubleStr = [NSString stringWithFormat:@"%@.00", doubleStr];
    }
    NSMutableString *tempStr= nil;
    tempStr = [[NSMutableString alloc] initWithString:doubleStr];
    //位
    NSArray *carryArr1=@[@"元", @"拾", @"佰", @"仟", @"万", @"拾", @"佰", @"仟", @"亿", @"拾", @"佰", @"仟", @"兆", @"拾", @"佰", @"仟" ,@"京",@"十京",@"百京",@"千京垓",@"十垓",@"百垓",@"千垓秭",@"十秭",@"百秭",@"千秭穰",@"十穰",@"百穰",@"千穰"];
    NSArray *carryArr2=@[@"角",@"分"];
    //数字
    NSArray *numArr=@[@"零", @"壹", @"贰", @"叁", @"肆", @"伍", @"陆", @"柒", @"捌", @"玖"];

    NSArray *temarr = [tempStr componentsSeparatedByString:@"."];
    //小数点前的数值字符串
    NSString *firstStr=[NSString stringWithFormat:@"%@",temarr[0]];
    //小数点后的数值字符串
    NSString *secondStr=[NSString stringWithFormat:@"%@",temarr[1]];

    //是否拼接了“零”，做标记
    bool zero=NO;
    //拼接数据的可变字符串
    NSMutableString *endStr= [[NSMutableString alloc] init];

    /**
     *  首先遍历firstStr，从最高位往个位遍历    高位----->个位
     */

    for(int i=(int)firstStr.length;i>0;i--)
    {
        //取最高位数
        NSInteger MyData=[[firstStr substringWithRange:NSMakeRange(firstStr.length-i, 1)]
                          integerValue];

        if ([numArr[MyData] isEqualToString:@"零"])
        {

            if ([carryArr1[i-1] isEqualToString:@"万"]||[carryArr1[i-1] isEqualToString:@"亿"]||[carryArr1[i-1] isEqualToString:@"元"]||[carryArr1[i-1] isEqualToString:@"兆"])
            {
                //去除有“零万”
                if (zero)
                {
                    endStr =[NSMutableString stringWithFormat:@"%@",[endStr substringToIndex:(endStr.length-1)]];
                    [endStr appendString:carryArr1[i-1]];
                    zero=NO;
                }
                else
                {
                    [endStr appendString:carryArr1[i-1]];
                    zero=NO;
                }

                //去除有“亿万”、"兆万"的情况
                if ([carryArr1[i-1] isEqualToString:@"万"]) {
                    if ([[endStr substringWithRange:NSMakeRange(endStr.length-2, 1)] isEqualToString:@"亿"]) {
                        endStr =[NSMutableString stringWithFormat:@"%@",[endStr substringToIndex:endStr.length-1]];
                    }

                    if ([[endStr substringWithRange:NSMakeRange(endStr.length-2, 1)] isEqualToString:@"兆"]) {
                        endStr =[NSMutableString stringWithFormat:@"%@",[endStr substringToIndex:endStr.length-1]];
                    }

                }
                //去除“兆亿”
                if ([carryArr1[i-1] isEqualToString:@"亿"]) {
                    if ([[endStr substringWithRange:NSMakeRange(endStr.length-2, 1)] isEqualToString:@"兆"]) {
                        endStr =[NSMutableString stringWithFormat:@"%@",[endStr substringToIndex:endStr.length-1]];
                    }
                }


            }else{
                if (!zero) {
                    [endStr appendString:numArr[MyData]];
                    zero=YES;
                }

            }

        }else{
            //拼接数字
            [endStr appendString:numArr[MyData]];
            //拼接位
            [endStr appendString:carryArr1[i-1]];
            //不为“零”
            zero=NO;
        }
    }

    /**
     *  再遍历secondStr    角位----->分位
     */

    if ([secondStr isEqualToString:@"00"]) {
        [endStr appendString:@"整"];
    }else{
       //如果最后一位位0就把它去掉
        if (secondStr.length > 1 && [secondStr hasSuffix:@"0"])
        {
            secondStr = [secondStr substringToIndex:(secondStr.length - 1)];
        }

        for(int i=(int)secondStr.length;i>0;i--)
        {
            //取最高位数
            NSInteger MyData=[[secondStr substringWithRange:NSMakeRange(secondStr.length-i, 1)] integerValue];

            [endStr appendString:numArr[MyData]];
            [endStr appendString:carryArr2[secondStr.length-i]];
        }
    }

    //add song
    if ([endStr hasPrefix:@"元"])
    {
        return  (NSString *)[endStr substringFromIndex:1];
    }

    return endStr;
}


/// 数字类型字符串转化为保留若干位小数
/// - Parameter position: 需要保留的小数位
- (NSString *)notRoundingAfterPoint:(NSInteger)position {
    NSDecimalNumber * price = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *roundedOunces;
    roundedOunces = [price decimalNumberByRoundingAccordingToBehavior:roundingBehavior];

    return [NSString stringWithFormat:@"%@",roundedOunces];
}


/// json字符串转化字典或数组
- (id)stringToJSONObject {
    if (self == nil) {
        return nil;
    }
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        return nil;
    }
    
    return dic;
}

/// 字典或数组转化成json字符串
/// - Parameter jsonObject: 需要转化的字典或者数组
+ (NSString *)jsonObjectToString:(id)jsonObject {
    
    NSError *parseError;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&parseError];
    
    NSString * str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if(parseError) {
        return nil;
    }
    return str;
}

/// 生成 32位小写 MD5字符串
- (NSString *)MD5ForLower32Bate {
    
    //要进行UTF8的转码
    const char* input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}


/// 生成 32位大写 MD5字符串
- (NSString *)MD5ForUpper32Bate {
    
    //要进行UTF8的转码
    const char* input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    
    return digest;
}

/// 生成 16位 大写 MD5字符串
- (NSString *)MD5ForUpper16Bate {
    
    NSString *md5Str = [self MD5ForUpper32Bate];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}


/// 生成 16位 小写 MD5字符串
- (NSString *)MD5ForLower16Bate {
    
    NSString *md5Str = [self MD5ForLower32Bate];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}

#pragma mark - 快速数据获取

/// 获取系统版本号
+ (NSString*)SystemVersion {
    NSString * str = [NSString stringWithFormat:@"%.2f",[[[UIDevice currentDevice] systemVersion] floatValue]];
    return str;
}
@end
