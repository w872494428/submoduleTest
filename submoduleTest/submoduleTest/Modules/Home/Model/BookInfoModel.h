//
//  BookInfoModel.h
//  MLWX
//
//  Created by mac on 2020/4/2.
//  Copyright © 2020 macbook . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BGFMDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookInfoModel : NSObject

@property (strong, nonatomic) NSString *word;
@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *pic;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *novel_copyright;
@property (strong, nonatomic) NSString *serialize;
@property (strong, nonatomic) NSString *chapter_id;
@property (strong, nonatomic) NSString *hits_month;
@property (strong, nonatomic) NSString *category_name;
@property (strong, nonatomic) NSString *progress;
@property (strong, nonatomic) NSString *chapter_title;
@property (strong, nonatomic) NSString *chapter_no;
@property (strong, nonatomic) NSString *chapter_info;
@property (assign, nonatomic) BOOL shelf_status;

@property (strong, nonatomic) NSString *readIndex; // 阅读书页标记
@property (strong, nonatomic) NSString *chapterNum; // 阅读章节标记
@property (strong, nonatomic) NSArray *markList; 

@property (strong, nonatomic) NSString *bookChapterKey;
@property (assign, nonatomic) NSInteger updataTime;

- (void)saveNewBookModelWithModel:(BookInfoModel *)bookModel;

@end

NS_ASSUME_NONNULL_END
