//
//  PPSPersistence.h
//  PPSCache
//
//  Created by ppsheep on 2017/8/15.
//  Copyright © 2017年 ppsheep. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 这个类是用来做存储时的model用
 */
@interface PPSPersistenceItem : NSObject

@property (nonatomic, strong) NSString *key;                // key
@property (nonatomic, strong) NSData *value;                // value
@property (nullable, nonatomic, strong) NSString *filename; // 持久化的文件名 可为空，如果为空，说明是存在SQLite中的
@property (nonatomic) int size;                             // value的大小，字节单位
@property (nonatomic) int modTime;                          // 最后的修改时间
@property (nonatomic) int accessTime;                       // 最后的访问时间

@end

//存储的方式
//一般来说，写入的话，SQLite 会比  file快
//读取的话，这个就需要区分情况了  如果数据 size 大于20kb 那么读取文件会更快，小于20则是读取SQLite更快
//
typedef NS_ENUM(NSUInteger, PPSPersistenceType) {
    PPSPersistenceTypeFile = 0,
    PPSPersistenceTypeSQLite = 1,
    PPSPersistenceTypeMixed = 2,
};


@interface PPSPersistence : NSObject

@property (nonatomic, readonly) NSString *path;
@property (nonatomic, readonly) PPSPersistenceType type;
@property (nonatomic) BOOL errorLogsEnabled;

//设置 不允许直接调用这两个初始化方法，需要调用我们指定的初始化方法
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

- (nullable instancetype)initWithPath:(NSString *)path type:(PPSPersistenceType)type NS_DESIGNATED_INITIALIZER;


@end

NS_ASSUME_NONNULL_END
