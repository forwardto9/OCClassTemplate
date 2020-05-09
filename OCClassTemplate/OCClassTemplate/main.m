//
//  main.m
//  OCClassTemplate
//
//  Created by uweiyuan on 2020/5/9.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>



@protocol Template1Delegate <NSObject>
@optional
- (void)doSomething;

@end

@protocol Template2Delegate <NSObject>
@optional
- (void)doSomething;
@end

//@interface Class1T : NSObject<Template1Delegate>
//
//@end
//
//@implementation Class1T
//
//- (void)doSomething {
//    NSLog(@"do T1");
//}
//
//@end
//
//@interface Class2T : NSObject<Template2Delegate>
//
//@end
//
//@implementation Class2T
//
//- (void)doSomething {
//    NSLog(@"do T2");
//}
//
//@end

//@interface ClassTemplate : NSObject<Template1Delegate, Template2Delegate>
//
//@end
//@implementation ClassTemplate
//
//- (instancetype)init {
//    if ([[self class] conformsToProtocol:@protocol(Template1Delegate)]) {
//        object_setClass(self, [Class1T class]);
//    }
//
//    if ([[self class] conformsToProtocol:@protocol(Template2Delegate)]) {
//        object_setClass(self, [Class2T class]);
//    }
//
//    return self;
//}
//
//@end

@protocol ClassTemplateDelegate <NSObject>

- (void)doSomething;

@end

@interface Class1T : NSObject<ClassTemplateDelegate>
@end

@implementation Class1T

- (void)doSomething {
    NSLog(@"do T1");
}

@end

@interface Class2T : NSObject<ClassTemplateDelegate>
@end

@implementation Class2T

- (void)doSomething {
    NSLog(@"do T2");
}

@end


@interface ClassTemplate < __covariant T: id<ClassTemplateDelegate> > : NSObject
- (void)doSomething:(T)t;
@end
@implementation ClassTemplate
- (void)doSomething:(id<ClassTemplateDelegate>)t {
    [t doSomething];
}
@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        //        ClassTemplate <Template1Delegate> * c1 = [[ClassTemplate alloc] init];
        //        [c1 doSomething];
        //
        //        ClassTemplate <Template2Delegate> * c2 = [[ClassTemplate alloc] init];
        //        [c2 doSomething];
        
        
        
        ClassTemplate *c1 = [[ClassTemplate alloc] init];
        [c1 doSomething:[Class1T new]];
        ClassTemplate *c2 = [[ClassTemplate alloc] init];
        [c2 doSomething:[Class2T new]];
    }
    return 0;
}
