//
//  MAApiItemListModel.h
//  TairanTV
//
//  Created by mengai on 2017/5/15.
//  Copyright © 2017年 mengai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAApiItemItemModel : NSObject

@property (nonatomic, copy  ) NSString *itemImageUrl;
@property (nonatomic, assign) NSInteger itemInfoId;
@property (nonatomic, copy  ) NSString *itemName;
@property (nonatomic, assign) NSInteger itemPlayType;
@property (nonatomic, assign) NSInteger itemPrice;
@property (nonatomic, copy  ) NSString *itemThumbUrl;
@property (nonatomic, assign) NSInteger itemTypeId;
@property (nonatomic, copy  ) NSString *imageName;
@property (nonatomic, assign) BOOL contClick;//是否能连击
@property (nonatomic, assign) BOOL isMock;//本地字段,是否是凑数据

@end


@interface MAApiItemListModel : NSObject

@property (nonatomic, strong) NSArray  *itemList; //MAApiItemItemModel
@property (nonatomic, assign) NSInteger itemTypeId;
@property (nonatomic, copy  ) NSString *itemTypeName;

@end

@interface MAApiItemSendSuccessModel : NSObject

@property (nonatomic, copy  ) NSString *itemName;
@property (nonatomic, assign) NSInteger itemInfoId;
@property (nonatomic, assign) long long afterDiamond;
@property (nonatomic, copy  ) NSString *itemImageUrl;
@property (nonatomic, assign) NSInteger itemNum;
@property (nonatomic, copy  ) NSString *createDate;
@property (nonatomic, assign) NSInteger itemPlayType;
@property (nonatomic, copy  ) NSString *fromUserId;
@property (nonatomic, assign) NSInteger itemTypeId;
@property (nonatomic, copy  ) NSString *itemThumbUrl;
@property (nonatomic, assign) NSInteger contClick;//是否是连击
@property (nonatomic, copy  ) NSString *imageName;
@property (nonatomic, assign) NSInteger itemPrice;
@property (nonatomic, copy  ) NSString *ext; //扩展字段

@end



