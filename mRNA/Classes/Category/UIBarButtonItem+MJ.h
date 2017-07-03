#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MJ)
/**
 *  快速创建一个显示图片的item
 *
 *  @param action   监听方法
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;


+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon selectedIcon:(NSString *)selectedIcon target:(id)target action:(SEL)action;

@property(nonatomic,assign)BOOL selected;


@property(nonatomic,strong)UIButton *btn;


@end
