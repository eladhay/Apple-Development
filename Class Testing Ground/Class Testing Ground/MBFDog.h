//
//  MBFDog.h
//  Class Testing Ground
//
//  Created by Elad Hayun on 7/18/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBFDog : NSObject{
    NSString *_name;
}

-(void)setName:(NSString *)name;
-(NSString *)name;

//@property (strong, nonatomic) NSString *name;

@end
