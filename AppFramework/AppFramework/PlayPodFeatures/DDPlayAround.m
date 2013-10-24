//
//  DDPlayAround.m
//  AppFramework
//
//  Created by Dong Yiming on 10/24/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import "DDPlayAround.h"

#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@implementation DDPlayAround

+(void)play
{
    [self testCocoaLumberJack];
    [self testFMDB];
}

+(void)testCocoaLumberJack
{
    // init loggers and add them
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    
    [DDLog addLogger:fileLogger];
    
    //usage
    DDLogError(@"Broken sprocket detected!");
    NSString *filePath = @"Usr/Dong";
    NSUInteger fileSize = 19999;
    DDLogVerbose(@"User selected file:%@ withSize:%u", filePath, fileSize);
    
    
    // And then enable colors
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    // Check out default colors:
    // Error : Red
    // Warn  : Orange
    
    DDLogError(@"Paper jam");                              // Red
    DDLogWarn(@"Toner is low");                            // Orange
    DDLogInfo(@"Warming up printer (pre-customization)");  // Default (black)
    DDLogVerbose(@"Intializing protcol x26");              // Default (black)
    
    // Now let's do some customization:
    // Info  : Pink
    
#if TARGET_OS_IPHONE
    UIColor *pink = [UIColor colorWithRed:(255/255.0) green:(58/255.0) blue:(159/255.0) alpha:1.0];
#else
    NSColor *pink = [NSColor colorWithCalibratedRed:(255/255.0) green:(58/255.0) blue:(159/255.0) alpha:1.0];
#endif
    
    [[DDTTYLogger sharedInstance] setForegroundColor:pink backgroundColor:nil forFlag:LOG_FLAG_INFO];
    
    DDLogInfo(@"Warming up printer (post-customization)"); // Pink !
}


+(void)testFMDB
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self dbPath]])
    {
        FMDatabase *db = [FMDatabase databaseWithPath:[self dbPath]];
        if (db.open)
        {
            NSString * sql = @"CREATE TABLE 'User' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , 'name' VARCHAR(30), 'password' VARCHAR(30))";
            BOOL res = [db executeUpdate:sql];
            if (!res) {
                DDLogError(@"error when creating db table");
            } else {
                DDLogInfo(@"succ to creating db table");
            }
            
            [db close];
        }
        else
        {
            DDLogError(@"error when open db");
        }
    }
    
    [self testDeleteAll];
    [self testInsert];
    [self testQueryData];

    [self testDeleteAll];
    [self testQueryData];
    
    [self testDbQueue];
}

+(NSString *)dbPath
{
    NSString *dbPath = nil;
    if (dbPath == nil)
    {
        NSString * doc = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;;
        dbPath = [doc stringByAppendingPathComponent:@"user.sqlite"];
    }
    
    return dbPath;
}

+(void)testInsert
{
    DDLogInfo(@"Test Insert");
    
    static int count = 0;
    FMDatabase *db = [FMDatabase databaseWithPath:[self dbPath]];
    if (db.open)
    {
        NSString * sql = @"insert into user (name, password) values(?, ?) ";
        NSString * name = [NSString stringWithFormat:@"tangqiao%d", count++];
        [db executeUpdate:sql, name, @"boy"];
        [db close];
    }
}

+(void)testQueryData
{
    DDLogInfo(@"Test Query");
    
    FMDatabase *db = [FMDatabase databaseWithPath:[self dbPath]];
    if (db.open)
    {
        NSString * sql = @"select * from user";
        FMResultSet * rs = [db executeQuery:sql];
        
        BOOL hasRecord = NO;
        while (rs.next)
        {
            hasRecord = YES;
            int userId = [rs intForColumn:@"id"];
            NSString * name = [rs stringForColumn:@"name"];
            NSString * pass = [rs stringForColumn:@"password"];
            DDLogVerbose(@"user id = %d, name = %@, pass = %@", userId, name, pass);
        }
        
        if (!hasRecord)
        {
            DDLogWarn(@"No user records.");
        }
        
        [db close];
    }
}

+(void)testDeleteAll
{
    DDLogInfo(@"Test Delete All");
    
    FMDatabase *db = [FMDatabase databaseWithPath:[self dbPath]];
    if (db.open)
    {
        NSString * sql = @"delete from user";
        [db executeUpdate:sql];
        
        [db close];
    }
}

+(void)testDbQueue
{
    DDLogInfo(@"Test DBQueue");
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[self dbPath]];
    dispatch_queue_t q1 = dispatch_queue_create("queue1", NULL);
    dispatch_queue_t q2 = dispatch_queue_create("queue2", NULL);
    
    dispatch_async(q1, ^{
        
        [queue inDatabase:^(FMDatabase *db) {
            for (int i = 1; i < 10; ++i)
            {
                NSString * sql = @"insert into user (name, password) values(?, ?) ";
                NSString * name = [NSString stringWithFormat:@"queue111 %d", i];
                [db executeUpdate:sql, name, @"boy"];
            }
        }];
        
        [self testQueryData];
    });
    
    dispatch_async(q2, ^{
        [queue inDatabase:^(FMDatabase *db) {
             for (int i = 1; i < 10; ++i)
             {
                 NSString * sql = @"insert into user (name, password) values(?, ?) ";
                 NSString * name = [NSString stringWithFormat:@"queue222 %d", i];
                 [db executeUpdate:sql, name, @"boy"];
             }
         }];
        
        [self testQueryData];
    });
}



@end
