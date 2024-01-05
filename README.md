# QTNSStringTool
NSNSString扩展,封装常用方法
支持cocoapods : pod 'QTNSStringTool'
#pragma mark - 验证

/// 判断是否包含中文
- (BOOL)qt_containChinese;

/// 简单判断是否是手机号
- (BOOL)qt_isPhoneNumber;

/// 判断是否是身份证号
- (BOOL)qt_isIDCardNumber;

/// 判断是否是电子邮箱
- (BOOL)qt_isEmailAddress;

/// 判断字符串是否为空,长度为0或者对象类型不为NSString及其子类时返回YES
+ (BOOL)qt_stringIsNull:(NSString *)string;

/// /否为纯数字
/// - Parameter allowPoint: YES:判断条件包含小数(12.34返回值为YES),  NO:不能包含小数·(12.34返回NO)
- (BOOL)isNumberStringWithAllowPoint:(BOOL)allowPoint;

/// 判断字符串是否为固定位数的纯数字(如 4位纯数字,11为纯数字)
/// - Parameters:
///   - length: 位数
- (BOOL)iSNumberStringWithLength:(NSUInteger)length;

#pragma mark - UI

/// 计算文本高度
/// - Parameters:
///   - width:  文本最大宽度
///   - lineSpacing: 行间距(没有行间距就传0)
///   - font: 文本字体大小
- (CGFloat)qt_getTextHeightWithWidth:(CGFloat)width
                  withLineSpacing:(CGFloat)lineSpacing
                         withFont:(CGFloat)font;


#pragma mark - 数据处理

/// 数字金额转化为大写汉字
- (NSString *)qt_convertAmount;

/// 数字类型字符串转化为保留若干位小数
/// - Parameter position: 需要保留的小数位
- (NSString *)qt_notRoundingAfterPoint:(NSInteger)position;

/// json字符串转化字典或数组
- (id)qt_stringToJSONObject;

/// 字典或数组转化成json字符串
/// - Parameter jsonObject: 需要转化的字典或者数组
+ (NSString *)qt_jsonObjectToString:(id)jsonObject;

/// 生成 32位小写 MD5字符串
- (NSString *)qt_MD5ForLower32Bate;

/// 生成 32位大写 MD5字符串
- (NSString *)qt_MD5ForUpper32Bate;

/// 生成 16位 大写 MD5字符串
- (NSString *)qt_MD5ForUpper16Bate;

/// 生成 16位 小写 MD5字符串
- (NSString *)qt_MD5ForLower16Bate;

#pragma mark - 快速数据获取

/// 获取系统版本号
+ (NSString*)qt_systemVersion;

/// 获取当前时间
+ (NSString *)qt_getCurrentTimes;

/// 获取当前日期
+ (NSString *)qt_getCurrentDate;

/// 以特定格式返回当前时间
/// - Parameter dateFormat:时间格式 dateFormat 例如@"yyyy-MM-dd"
+ (NSString *)qt_getCurrentTimeWithTimeFormatterString:(NSString *)dateFormat;

/// 以自身作为formatter格式返回当前时间
- (NSString *)qt_formatterGetCurrentDate;

/// 根据hex字符串获取颜色,自身不符合hex标准时返回白色
- (UIColor *)qt_hexGetColor;

/// 获取时间戳(秒)
+ (NSString *)qt_getTimeIntervalSince1970Second;

/// 获取时间戳(毫秒)
+ (NSString *)qt_getTimeIntervalSince1970SecondMillisecond;

/// 获取沙盒主目录路径
+ (NSString *)qt_getSanboxHomePath;

/// 获取Documents沙盒路径
+ (NSString *)qt_getSanboxDocumentsPath;

/// 获取Library沙盒路径
+ (NSString *)qt_getSanboxLibraryPath;

/// 获取Caches沙盒路径
+ (NSString *)qt_getSanboxCachesPath;

/// 获取tmp沙盒路径
+ (NSString *)qt_getSanboxcTmpPath;


