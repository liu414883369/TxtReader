//
//  NSString+JJ_Extension.m
//  读取txt文件
//
//  Created by LIUJIANJIAN on 16/5/22.
//  Copyright © 2016年 rdg. All rights reserved.
//

#import "NSString+JJ_Extension.h"
#import "JJItemAttributes.h"

@implementation NSString (JJ_Extension)

- (NSArray<JJItemAttributes *> *)itemAttributes {
    
    NSMutableArray *items = [NSMutableArray array];
    // 获取所有文件名（含隐藏文件）
    NSArray *fileNames = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self error:nil];
    for (NSString *fileName in fileNames) {
        // 忽略隐藏文件@".DS_Store"
        if ([fileName isEqualToString:@".DS_Store"]) continue;
        // 文件路径
        NSString *filePath = [self stringByAppendingPathComponent:fileName];
        // 获取文件属性
        NSDictionary *attributes = [self AttributesOfFilePath:filePath];
        JJItemAttributes *itemAttributes = [[JJItemAttributes alloc] init];
        // 文件路径
        itemAttributes.filePath = filePath;
        // 文件名
        itemAttributes.fileName = fileName;
        // 文件大小 字节
        itemAttributes.fileSize = [self fileLength:[attributes[NSFileSize] longLongValue]];
        // 文件类型
        itemAttributes.fileType = [attributes[NSFileType] isEqualToString:NSFileTypeDirectory] ? JJ_NSFileTypeDirectory : JJ_NSFileTypeRegular;
        // 文件修改日期
        NSDate *date = attributes[NSFileModificationDate];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *str = [dateFormatter stringFromDate:date];
        itemAttributes.fileModificationDate = str;
        [items addObject:itemAttributes];
    }
    return items;
}

- (NSDictionary *)AttributesOfFilePath:(NSString *)filePath {

    NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
//    NSLog(@"dict = %@", dict);
    /*
     NSFileCreationDate = "2016-05-22 00:12:20 +0000";
     NSFileExtensionHidden = 0;
     NSFileGroupOwnerAccountID = 20;
     NSFileGroupOwnerAccountName = staff;
     NSFileModificationDate = "2016-05-22 00:29:29 +0000";
     NSFileOwnerAccountID = 501;
     NSFilePosixPermissions = 493;
     NSFileReferenceCount = 5;
     NSFileSize = 170;
     NSFileSystemFileNumber = 18375060;
     NSFileSystemNumber = 16777220;
     NSFileType = NSFileTypeDirectory;
     
     
     NSFileCreationDate = "2016-05-22 00:29:08 +0000";
     NSFileExtensionHidden = 1;
     NSFileGroupOwnerAccountID = 20;
     NSFileGroupOwnerAccountName = staff;
     NSFileModificationDate = "2016-05-22 00:29:34 +0000";
     NSFileOwnerAccountID = 501;
     NSFilePosixPermissions = 420;
     NSFileReferenceCount = 1;
     NSFileSize = 6148;
     NSFileSystemFileNumber = 18378443;
     NSFileSystemNumber = 16777220;
     NSFileType = NSFileTypeRegular;
     
     */
    return dict;
}
- (NSString *)fileLength:(long long)fileLength {
    NSString *length = nil;
    if (fileLength < 1024) {
        length = [NSString stringWithFormat:@"%lld字节", fileLength];
    } else if (fileLength / 1024 < 1024) {
        length = [NSString stringWithFormat:@"%lldKB", fileLength / 1024];
    } else if (fileLength / 1024 / 1024 < 1024) {
        length = [NSString stringWithFormat:@"%.1fMB", fileLength / 1024.0 / 1024.0];
    } else if (fileLength / 1024 / 1024 / 1024 < 1024) {
        length = [NSString stringWithFormat:@"%f.2GB", fileLength / 1024.0 / 1024.0 / 1024.0];
    }
    return length;
}

@end
