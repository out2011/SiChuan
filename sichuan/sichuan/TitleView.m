//
//  TitleView.m
//  sichuan
//
//  Created by Lu.L on 16/1/25.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "TitleView.h"
#import "UIColor+SCColor.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width

@interface TitleView()

@property(nonatomic, weak) UIButton *button;

@end

@implementation TitleView

+ (TitleView *)headWithTableView:(UITableView *)tableView {
    
    static NSString *identifier = @"titleSection";
    TitleView *head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    
    if (!head) {
        head = [[TitleView alloc] initWithReuseIdentifier:identifier];
    }
    return head;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(8, 49, kScreenW - 8, 1)];
        view.backgroundColor = [UIColor colorWithRGB:0xE0E0E0];
        [self addSubview:view];
        
        // 添加button
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        //设置背景图片
        [button setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 设置按钮的内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        // 设置button的内边距
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0);
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0);
        
        // 设置按钮内部的imageView的内容模式为居中
        button.imageView.contentMode = UIViewContentModeCenter;
        // 超出边框的内容不需要裁剪
        button.imageView.clipsToBounds = NO;
        
        // 点击事件
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:button];
        self.button = button;
    }
    
    return self;
}

- (void)setInfo:(FoldInfo *)info {
    
    _info = info;
    
    [self.button setTitle:info.title forState:UIControlStateNormal];
}

/**
 *  当一个控件的frame发生改变的时候就会调用
 *
 *  一般在这里布局内部的子控件(设置子控件的frame)
 */
- (void)layoutSubviews
{
    /**
     * 一定不要忘记写这句
     */
    [super layoutSubviews];
    
    self.button.frame = self.bounds;
}

-(void)buttonClick:(UIButton *)sender
{
    
    // 1.修改组模型的标记(状态取反)
    self.info.isFold = !self.info.isFold;
    
    // 2.刷新表格
    
    if ([self.delegate respondsToSelector:@selector(headViewDidClickButtn:)])
    {
        [self.delegate headViewDidClickButtn:self];
    }
}
@end
