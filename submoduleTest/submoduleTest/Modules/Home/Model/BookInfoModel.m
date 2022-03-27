//
//  BookInfoModel.m
//  MLWX
//
//  Created by mac on 2020/4/2.
//  Copyright © 2020 macbook . All rights reserved.
//

#import "BookInfoModel.h"

#define kSaveBookSheftDataList          @"kSaveBookSheftList" //保存书架列表

@implementation BookInfoModel
//重要(拓展key)
- (void)mj_didConvertToObjectWithKeyValues:(NSDictionary *)keyValues{
    self.bookChapterKey = [NSString stringWithFormat:@"%@",self.ID];
}

+(NSArray *)bg_uniqueKeys{
    return @[@"ID"];
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
        @"ID":@"id"
    };
}

- (void)saveNewBookModelWithModel:(BookInfoModel *)bookModel{
    if ([bookModel isMemberOfClass:[self class]]) {
        NSString *where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"bookChapterKey"),bg_sqlValue(self.bookChapterKey)];
        NSArray *bookArr = [BookInfoModel bg_find:kSaveBookSheftDataList where:where];
//        if (bookArr.count) {
//            self.bookModel = [SaveBookModel updateBookLastModelWithOldModel:bookArr.firstObject newModel:oneModel];
//        }else{
//            // 保存新书
//            self.bookModel = [SaveBookModel saveNewBookModelWithModel:oneModel];
//        }
        bookModel.bg_tableName = kSaveBookSheftDataList;
        NSLog(@"新书保存%@",[bookModel bg_saveOrUpdate]?@"成功":@"失败");
    }else{
        NSLog(@"数据类型错误");
    }
}
@end
