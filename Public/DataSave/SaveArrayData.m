//
//  SaveArrayData.m
//  
//
//  Created by ios
//
//

#import "SaveArrayData.h"

@interface SaveArrayData()
@property (nonatomic, strong) NSMutableArray *friendlistArray;
@end

@implementation SaveArrayData

+ (instancetype)shareInstance
{
    static SaveArrayData *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(!instance)
        {
            instance = [[SaveArrayData alloc] init];
        }
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _colorArray = [[NSMutableArray alloc] init];
    }
    return self;
}

//保存的文件路径
- (NSString *)dataPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *libraryPath = [paths objectAtIndex:0];
    NSString *friendPath = [libraryPath stringByAppendingPathComponent:@"friendcolor.plist"];
    
    return friendPath;
}

//保存color数据
- (void)saveColorArray
{
    NSString *path = [self dataPath];
    [NSKeyedArchiver archiveRootObject:self.colorArray toFile:path];
}

//获得color数据
- (void)getColorsArray
{
    NSString *path = [self dataPath];
    self.colorArray = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (self.colorArray == nil) {
        self.colorArray = [NSMutableArray array];
    }
}

//保存的文件路径
- (NSString *)dataMissPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *libraryPath = [paths objectAtIndex:0];
    NSString *friendPath = [libraryPath stringByAppendingPathComponent:@"friendmiss.plist"];
    return friendPath;
} 

- (void)saveMissArray
{
    NSString *path = [self dataMissPath];
    [NSKeyedArchiver archiveRootObject:self.missArray toFile:path];
}

- (void)getMissesArray
{
    NSString *path = [self dataMissPath];
    self.missArray = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (self.missArray == nil) {
        self.missArray = [NSMutableArray array];
    }
}

//保存数据
- (void)saveDataArray:(NSMutableArray *)array
{
    NSString *friendPath = [self dataPath];
    //Load the array
    NSMutableArray *yourArray = [[NSMutableArray alloc] initWithContentsOfFile:friendPath];
    if(yourArray == nil)
    {
        //Array file didn't exist... create a new one
        yourArray = [NSMutableArray arrayWithArray:array];
    }
    //Save the array
    BOOL saveResult = [yourArray writeToFile:friendPath atomically:YES];
    if(saveResult)
    {
        NSLog(@"save success!");
    }
}

//获得保存的文件的失败数据
- (NSMutableArray *)getDataArray
{
    NSString *dataPath = [self dataPath];
    NSArray *itemArray = [NSArray arrayWithContentsOfFile:dataPath];
    return (NSMutableArray *)itemArray;
}

//移除文件
- (void)removeDataArrayFile
{
    NSString *dataPath = [self dataPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExist = [fileManager fileExistsAtPath:dataPath];
    if(fileExist)
    {
        //如果文件存在，删除
        NSError *error;
        BOOL success = [fileManager removeItemAtPath:dataPath error:&error];
        if (success)
        {
        }
        else
        {
            NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
        }
    }
}


- (void)saveFriendlistArray:(NSMutableArray *)array
{
    if(!self.friendlistArray)
    {
        _friendlistArray = [[NSMutableArray alloc] init];
    }
    [self.friendlistArray addObjectsFromArray:array];
}

- (NSMutableArray *)getFriendArray
{
    return self.friendlistArray;
}
@end
