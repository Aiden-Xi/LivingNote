#import <UIKit/UIKit.h>

typedef void (^btnOnClick)(UIEvent*touch);

@interface UIButton (TJButtom)

/**
 *  扩展Buttom的点击范围
 *
 *  @param top    top    方向延伸
 *  @param right  right  方向延伸
 *  @param bottom bottom 方向延伸
 *  @param left   left   方向延伸
 */
- (void) setEnlargeEdgeWithTop:(CGFloat)top
                         right:(CGFloat)right
                        bottom:(CGFloat)bottom
                          left:(CGFloat)left;
/**
 *  使用Block语法块,addTarget方法
 *
 *  @param event  events
 *  @param action block action
 */
- (void) addBlockTarget:(UIControlEvents)event
                  block:(btnOnClick)action;
@end
