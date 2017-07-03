#import "UIBarButtonItem+MJ.h"

@implementation UIBarButtonItem (MJ)
static bool _selected;

//static int _btn;



+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    button.frame = (CGRect){CGPointZero, button.currentBackgroundImage.size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon selectedIcon:(NSString *)selectedIcon target:(id)target action:(SEL)action{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selectedIcon] forState:UIControlStateSelected];
    button.frame = (CGRect){CGPointZero, button.currentBackgroundImage.size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}




//get方法
- (BOOL)selected {
    NSNumber *t= objc_getAssociatedObject(self, &_selected);
    return [t intValue];
}

//set方法
- (void)setCustomTag:(BOOL)selected{
    NSNumber *t = @(selected);
    objc_setAssociatedObject(self, &_selected, t, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}



- (UIButton *)btn{

    return  objc_getAssociatedObject(self, @selector(btn));
}

- (void)setBtn:(UIButton *)btn{
   objc_setAssociatedObject(self, @selector(btn),btn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


/*
 - (NSObject *)property {
 return objc_getAssociatedObject(self, @selector(property));
 }
 
 - (void)setProperty:(NSObject *)value {
 objc_setAssociatedObject(self, @selector(property), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
 }

 */

@end
