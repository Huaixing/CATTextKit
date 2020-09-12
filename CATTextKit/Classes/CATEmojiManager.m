//
//  CATEmojiManager.m
//  CATTextKit
//
//  Created by Shihuaixing on 2020/9/9.
//

#import "CATEmojiManager.h"
#import "CATEmojiModel.h"

/// 创建静态对象 防止外部访问
static CATEmojiManager *_instance;

@interface CATEmojiManager ()<NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableArray *emojiList;
// 用来记录当前xml解析的节点名称
@property (nonatomic, copy) NSString *currentElementName;

@end

@implementation CATEmojiManager

#pragma mark - Init
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    // 可以使用一次性代码
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}

/// 为了使实例易于外界访问 我们一般提供一个类方法
/// 类方法命名规范 share类名|default类名|类名
+ (instancetype)manager {
    // 最好用self 用Tools他的子类调用时会出现错误
    return [[self alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupParseConfig];
    }
    return self;
}

/// 为了严谨，也要重写copyWithZone 和 mutableCopyWithZone
- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

#pragma mark - Private

- (void)setupParseConfig {

    NSString *xmlFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"emoji" ofType:@"xml"];
    NSData *xmlData = [NSData dataWithContentsOfFile:xmlFilePath];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:xmlData];
    xmlParser.delegate = self;
    //  开始解析
    [xmlParser parse];
}

#pragma mark - Public
- (NSArray<CATEmojiModel *> *)emojiModels {
    if (_emojiList == nil) {
        _emojiList = [[NSMutableArray alloc] init];
    }
    return _emojiList;
}

#pragma mark - NSXMLParserDelegate
/// 开始
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    self.emojiList = [NSMutableArray array];
}

/// 获取节点头
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    
    self.currentElementName = elementName;
    if ([elementName isEqualToString:@"emoji"]) {
        CATEmojiModel *model = [[CATEmojiModel alloc] init];
        [self.emojiList addObject:model];
    }
    
}

/// 获取节点的值 (这个方法在获取到节点头和节点尾后，会分别调用一次)
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if (_currentElementName != nil) {
        CATEmojiModel *lastModel = [self.emojiList lastObject];
        [lastModel setValue:string forKey:_currentElementName];
    }
}

/// 获取节点尾
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    _currentElementName = nil;
    
}

/// 结束
- (void)parserDidEndDocument:(NSXMLParser *)parser {

}

@end
