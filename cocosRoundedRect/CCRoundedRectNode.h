/*
 *  CCRoundedRectNode.h
 *
 *  Created by Gururaj T on 10/06/13.
 *  Copyright gururaj.tallur@gmail.com 2013. All rights reserved.
 */


#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CCRoundedRectNode : CCSprite {
    CGSize size;
    float radius;
    
    ccColor4F borderColor;
    ccColor4F fillColor;
    float lineWidth;
    
    NSUInteger cornerSegments;
}

-(id) initWithRectSize:(CGSize)sz;

@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) float radius;
@property (nonatomic,assign) ccColor4F borderColor;
@property (nonatomic,assign) ccColor4F fillColor;
@property (nonatomic,assign) float borderWidth;
@property (nonatomic,assign) NSUInteger cornerSegments;

@end