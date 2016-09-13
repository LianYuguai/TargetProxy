//
//  TargetProxy.m
//  TargetProxy
//
//  Created by yulong on 16/9/12.
//  Copyright © 2016年 com.YL. All rights reserved.
//

#import "TargetProxy.h"

@implementation TargetProxy
- (id)initWithTarget1:(id)t1 target2:(id)t2 {
    realObject1 = t1;
    realObject2 = t2;
    return self;
}



// The compiler knows the types at the call site but unfortunately doesn't
// leave them around for us to use, so we must poke around and find the types
// so that the invocation can be initialized from the stack frame.

// Here, we ask the two real objects, realObject1 first, for their method
// signatures, since we'll be forwarding the message to one or the other
// of them in -forwardInvocation:.  If realObject1 returns a non-nil
// method signature, we use that, so in effect it has priority.
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sig;
    sig = [realObject1 methodSignatureForSelector:aSelector];
    if (sig)
        return sig;
    sig = [realObject2 methodSignatureForSelector:aSelector];
    return sig;
}

// Invoke the invocation on whichever real object had a signature for it.
- (void)forwardInvocation:(NSInvocation *)invocation {
    id target = [realObject1 methodSignatureForSelector:[invocation selector]] ? realObject1 : realObject2;
    [invocation invokeWithTarget:target];
}

// Override some of NSProxy's implementations to forward them...
- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([realObject1 respondsToSelector:aSelector]) return YES;
    if ([realObject2 respondsToSelector:aSelector]) return YES;
    return NO;
}

@end
