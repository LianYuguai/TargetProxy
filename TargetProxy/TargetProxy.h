//
//  TargetProxy.h
//  TargetProxy
//
//  Created by yulong on 16/9/12.
//  Copyright © 2016年 com.YL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TargetProxy : NSProxy{
    id realObject1;
    id realObject2;
}
- (id)initWithTarget1:(id)t1 target2:(id)t2;

@end
