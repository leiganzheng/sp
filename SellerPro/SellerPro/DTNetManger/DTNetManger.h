//
//  DTNetManger.h
//  DouTu
//
//  Created by yuepengfei on 17/3/14.
//  Copyright © 2017年 fly. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DTBaseModel;

typedef void(^callBack)(NSError *error, NSArray *response);
typedef void(^detailCallBack) (NSError *error, NSArray *response, DTBaseModel *detailModel);

@interface DTNetManger : NSObject

+(void)getSearchLisWithKeyWord:(NSString*)keyW
                          PageNum:(NSInteger)pageNum
                          pageSize:(NSInteger)pageSize
                          callBack:(callBack)callBack;

@end
