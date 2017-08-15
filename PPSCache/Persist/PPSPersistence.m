//
//  PPSPersistence.m
//  PPSCache
//
//  Created by ppsheep on 2017/8/15.
//  Copyright © 2017年 ppsheep. All rights reserved.
//

#import "PPSPersistence.h"
#import <UIKit/UIKit.h>
#import <time.h>

#if __has_include(<sqlite3.h>)
#import <sqlite3.h>
#else
#import "sqlite3.h"
#endif

static const int kPathLengthMax = PATH_MAX - 64;//iOS中允许的最长路径名长度为PATH_MAX，因为我们还需要添加一些自己的文件名，所以还需要减去一点长度
static NSString *const kDataDirectoryName = @"data";//存放文件的文件夹
static NSString *const kTrashDirectoryName = @"trash";//存放未使用的文件的文件夹
static NSString *const kDBFileName = @"manifest.sqlite";//数据库名称
static NSString *const kDBShmFileName = @"manifest.sqlite-shm";
static NSString *const kDBWalFileName = @"manifest.sqlite-wal";

@implementation PPSPersistenceItem
@end

@implementation PPSPersistence {
    dispatch_queue_t _trashQueue;
    
    NSString *_path;    //存放路径
    NSString *_dbPath;
    NSString *_dataPath;
    NSString *_trashPath;
    
    sqlite3 *_db;
    CFMutableDictionaryRef _dbStmtCache;
    NSTimeInterval _dbLastOpenErrorTime;
    NSUInteger _dbOpenErrorCount;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"PPSPersistence init error" reason:@"Please use the designated initializer and pass the 'path' and 'type'." userInfo:nil];
    return [self initWithPath:@"" type:PPSPersistenceTypeFile];
}

- (instancetype)initWithPath:(NSString *)path type:(PPSPersistenceType)type {
    
    //判断当前的地址是否正确
    if (path.length == 0 || path.length > kPathLengthMax) {
        NSLog(@"PPSPersistence init error: invalid path: [%@].", path);
        return nil;
    }
    
    //判断存储类型是否正确
    if (type > PPSPersistenceTypeMixed) {
        NSLog(@"错误的存储类型: %lu",(unsigned long)type);
        return nil;
    }
    
    //初始化参数
    _path = [path copy];
    _type = type;
    _dataPath = [path stringByAppendingPathComponent:kDataDirectoryName];//存放文件的文件夹路径
    _trashPath = [path stringByAppendingPathComponent:kTrashDirectoryName];//存放未使用的文件的文件夹路径
    _trashQueue = dispatch_queue_create("com.ppsheep.cache.disk.trash", DISPATCH_QUEUE_SERIAL);//创建线程，默默清除未使用文件夹中的文件
    _dbPath = [path stringByAppendingPathComponent:kDBFileName];
    _errorLogsEnabled = YES;
    NSError *error = nil;
    //创建文件夹
    if (![[NSFileManager defaultManager] createDirectoryAtPath:path
                                   withIntermediateDirectories:YES
                                                    attributes:nil
                                                         error:&error] ||
        ![[NSFileManager defaultManager] createDirectoryAtPath:_dataPath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:&error] ||
        ![[NSFileManager defaultManager] createDirectoryAtPath:_trashPath
                                   withIntermediateDirectories:YES
                                                    attributes:nil
                                                         error:&error]) {
            NSLog(@"PPSPersistence init error:%@", error);
            return nil;
    }
    
    //初始化数据库
    
    
    
    return nil;
}

@end

















