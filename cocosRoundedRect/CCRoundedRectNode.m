/*
 *  CCRoundedRectNode.m
 *
 *  Created by Gururaj T on 10/06/13.
 *  Copyright gururaj.tallur@gmail.com 2013. All rights reserved.
 */



#import "CCRoundedRectNode.h"
#import "CCDrawingPrimitives.h"
#import "CCDrawNode.h"

@implementation CCRoundedRectNode

@synthesize size, radius, borderWidth, cornerSegments, borderColor, fillColor;

#define kappa 0.552228474

-(id) initWithRectSize:(CGSize)sz  {
    
    if((self=[super init]))
    {
        size = sz;
        radius = 10;
        borderWidth = 20;
        cornerSegments = 20;
        borderColor = ccc4f(0,0,0,0);
        fillColor = ccc4f(0,0,0,90);
        
    }
    return self;
}

void appendCubicBezier(int startPoint, CGPoint* vertices, CGPoint origin, CGPoint control1, CGPoint control2, CGPoint destination, NSUInteger segments)
{
	//ccVertex2F vertices[segments + 1];
	
	float t = 0;
	for(NSUInteger i = 0; i < segments; i++)
	{
		GLfloat x = powf(1 - t, 3) * origin.x + 3.0f * powf(1 - t, 2) * t * control1.x + 3.0f * (1 - t) * t * t * control2.x + t * t * t * destination.x;
		GLfloat y = powf(1 - t, 3) * origin.y + 3.0f * powf(1 - t, 2) * t * control1.y + 3.0f * (1 - t) * t * t * control2.y + t * t * t * destination.y;
        vertices[startPoint+i] = CGPointMake(x * CC_CONTENT_SCALE_FACTOR(), y * CC_CONTENT_SCALE_FACTOR() );
		//vertices[startPoint+i] = (ccVertex2F) {x * CC_CONTENT_SCALE_FACTOR(), y * CC_CONTENT_SCALE_FACTOR() };
		t += 1.0f / segments;
	}
}

 
-(void) draw {
	CGPoint vertices[16];
    
    vertices[0] = ccp(0,radius);
    vertices[1] = ccp(0,radius*(1-kappa));
    vertices[2] = ccp(radius*(1-kappa),0);
    vertices[3] = ccp(radius,0);
    
    vertices[4] = ccp(size.width-radius,0);
    vertices[5] = ccp(size.width-radius*(1-kappa),0);
    vertices[6] = ccp(size.width,radius*(1-kappa));
    vertices[7] = ccp(size.width,radius);
    
    vertices[8] = ccp(size.width,size.height - radius);
    vertices[9] = ccp(size.width,size.height - radius*(1-kappa));
    vertices[10] = ccp(size.width-radius*(1-kappa),size.height);
    vertices[11] = ccp(size.width-radius,size.height);
    
    vertices[12] = ccp(radius,size.height);
    vertices[13] = ccp(radius*(1-kappa),size.height);                   
    vertices[14] = ccp(0,size.height-radius*(1-kappa));                   
    vertices[15] = ccp(0,size.height-radius);    
    
    CGPoint polyVertices[4*cornerSegments+1];
    appendCubicBezier(0*cornerSegments,polyVertices,vertices[0], vertices[1], vertices[2], vertices[3], cornerSegments);
    appendCubicBezier(1*cornerSegments,polyVertices,vertices[4], vertices[5], vertices[6], vertices[7], cornerSegments);
    appendCubicBezier(2*cornerSegments,polyVertices,vertices[8], vertices[9], vertices[10], vertices[11], cornerSegments);
    appendCubicBezier(3*cornerSegments,polyVertices,vertices[12], vertices[13], vertices[14], vertices[15], cornerSegments);
    polyVertices[4*cornerSegments] = vertices[0];
    
    CCNode *node=[self getChildByTag:13435];
    
    if(!node)
    {
        CCDrawNode *draw = [[[CCDrawNode alloc] init] autorelease];
        
        [draw drawPolyWithVerts:polyVertices count:4*cornerSegments fillColor:ccc4f(fillColor.r, fillColor.g, fillColor.b, fillColor.a) borderWidth:2.0 borderColor:ccc4f(1.0, 0.5, 0.5, 0.8)];
        
        [self addChild:draw z:0 tag:13435];
    }
}

@end