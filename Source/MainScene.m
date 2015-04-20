#import "MainScene.h"
#import "AppDelegate.h"

@implementation MainScene

+(id) scene
{
    // 'scene' is an autorelease object.
    CCScene *scene = [CCScene node];
    
    MainScene *layer = [MainScene node];
    [scene addChild: layer];
    // return the scene
    return scene;
}

-(id)init
{
    if( (self=[super init] )) {
        NSLog(@"has variable %u", UIAppDelegate.hasVariable);
        
        self.userInteractionEnabled = YES;
        
        [self drawMenu];
    };
    
    return self;
}

- (void)resetGame
{
    NSString *mapName = @"baseTile.tmx";
    
    [self loadMap:mapName];
}

- (void)loadMap: (NSString*)mapName
{
    NSLog(@"Loading map %@", mapName);

    CCTiledMap *tileMap = [CCTiledMap tiledMapWithFile:mapName];
    CCTiledMapLayer *layer = [tileMap layerNamed:@"Background"];
    layer.visible = NO;
    [self addChild:layer];
    
    CCTiledMapObjectGroup *objectGroup = [tileMap objectGroupNamed:@"Objects"];
    NSAssert(objectGroup != nil, @"tile map has no object layer");
}

- (void)drawMenu
{
    [self removeAllChildrenWithCleanup:YES];
    
    CCButton* item1 = [CCButton buttonWithTitle:@"Item1"];
    item1.block = ^(id sender)
    {
        // Item 1 chosen
    };
    
    CCButton* item2 = [CCButton buttonWithTitle:@"Item2"];
    item2.block = ^(id sender)
    {
        // Item 2 chosen
    };
    
    CCButton* item3 = [CCButton buttonWithTitle:@"Item3"];
    item3.block = ^(id sender)
    {
        // Item 2 chosen
    };
    
    NSArray* menuItems = @[item1, item2, item3];
    
    // Use 	CCLayoutBox to replicate the menu layout feature
    CCLayoutBox* menuBox = [[CCLayoutBox alloc] init];
    
    // Have to set up direction and spacing before adding children
    menuBox.direction = CCLayoutBoxDirectionHorizontal;
    menuBox.spacing = 50.0f;
    
    menuBox.position = ccp([CCDirector sharedDirector].viewSize.width/2, 100);
    menuBox.anchorPoint = ccp(0.5f, 0.5f);
    
    menuBox.cascadeColorEnabled = YES;
    menuBox.cascadeOpacityEnabled = YES;
    
    // No direct way of adding an array of items (and also need to flip the cascade flags on them all...)
    for (CCNode* item in menuItems)
    {
        item.cascadeColorEnabled = item.cascadeOpacityEnabled = YES;
        [menuBox addChild:item];
    }
    
    // Have to do this *after* all children are added and have the cascade flags set
    menuBox.opacity = 0.0f;
    
    [menuBox runAction:[CCActionFadeIn actionWithDuration:2.0f]];
    
    NSLog(@"Menu size: %.1f, %.1f", menuBox.contentSize.width, menuBox.contentSize.height);
    
    // Add the menu to this layer
    [self addChild:menuBox];
}

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    CGPoint touchLocation = [touch locationInNode:self];
    NSLog(@"%f, %f", touchLocation.x, touchLocation.y);
}

- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInNode:self];
    NSLog(@"%f, %f", touchLocation.x, touchLocation.y);
    
    UIAppDelegate.startGame;
}

@end
