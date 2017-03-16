//
//  SaveArrayData.h
//  
//
//  Created by ios on 16/6/15.
//  
//

#import <Foundation/Foundation.h>

@interface SaveArrayData : NSObject
@property (nonatomic, strong) NSMutableArray *colorArray;
@property (nonatomic, strong) NSMutableArray *missArray;

//监控设置按钮
@property (nonatomic, assign) BOOL isShowView;

+ (instancetype)shareInstance;

- (void)saveDataArray:(NSMutableArray *)array;
- (NSMutableArray *)getDataArray;

- (void)removeDataArrayFile;

- (void)saveFriendlistArray:(NSMutableArray *)array;
- (NSMutableArray *)getFriendArray;

- (void)saveColorArray;
- (void)getColorsArray;

- (void)saveMissArray;
- (void)getMissesArray;
@end
