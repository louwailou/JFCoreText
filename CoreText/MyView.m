//
//  MyView.m
//  CoreText
//
//  Created by vtion on 14/11/25.
//  Copyright (c) 2014年 vtion. All rights reserved.
//

#import "MyView.h"
#import <CoreText/CoreText.h>
@implementation MyView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    NSString *src = @"其实流程是这样的:1、生成要绘制的NSAttributedString对象。 2、生成一个CTFramesetterRef对象，然后创建一个CGPath对象，这个Path对象用于表示可绘制区域坐标值、长宽。 3、使用上面生成的setter和path生成一个CTFrameRef对象，这个对象包含了这两个对象的信息（字体信息、坐标信息），它就可以使用CTFrameDraw方法绘制了。";
    NSMutableAttributedString * mabstring = [[NSMutableAttributedString alloc]initWithString:src];
    
    long slen = [mabstring length];
    
    // 设置文字的属性
    NSMutableDictionary* attriDic=[[NSMutableDictionary alloc]initWithCapacity:0];
    [attriDic setObject:(id)[UIColor blueColor].CGColor forKey:(id)kCTForegroundColorAttributeName];
    CTFontRef font=CTFontCreateWithName((CFStringRef)[UIFont systemFontOfSize:12].fontName, 20, NULL);
    [attriDic setObject:(__bridge id)font forKey:(id)kCTFontAttributeName];
    
    [attriDic setObject:(id)[NSNumber numberWithInt:kCTUnderlineStyleDouble] forKey:(id)kCTUnderlineStyleAttributeName];
    // 设置文字对齐方式
    CTTextAlignment alignText=kCTJustifiedTextAlignment;
    CTParagraphStyleSetting alignStyle;
    alignStyle.spec=kCTParagraphStyleSpecifierAlignment;
    alignStyle.valueSize=sizeof(alignText);
    alignStyle.value=&alignText;
    
    // 首行缩进
    CGFloat firstLineIndent =23;
    CTParagraphStyleSetting lineIndet;
    lineIndet.spec=kCTParagraphStyleSpecifierFirstLineHeadIndent;
    lineIndet.valueSize=sizeof(float);
    lineIndet.value=&firstLineIndent;
    //换行模式
    CTParagraphStyleSetting lineBreakMode;
    CTLineBreakMode lineBreak = kCTLineBreakByWordWrapping;//kCTLineBreakByCharWrapping;//换行模式
    lineBreakMode.spec = kCTParagraphStyleSpecifierLineBreakMode;
    lineBreakMode.value = &lineBreak;
    lineBreakMode.valueSize = sizeof(CTLineBreakMode);
    // 行间距
    CGFloat _linespace = 25.0f;
    CTParagraphStyleSetting lineSpaceSetting;
    lineSpaceSetting.spec = kCTParagraphStyleSpecifierLineSpacing;
    lineSpaceSetting.value = &_linespace;
    lineSpaceSetting.valueSize = sizeof(float);
    //组合设置
    CTParagraphStyleSetting settings[] = {alignStyle,lineIndet,lineBreakMode,lineSpaceSetting
    };
    
    //通过设置项产生段落样式对象
    CTParagraphStyleRef style = CTParagraphStyleCreate(settings, 4);
    
    // build attributes
   
    [attriDic setObject:(__bridge id)style forKey:(id)kCTParagraphStyleAttributeName];
    
    [mabstring addAttributes:attriDic range:NSMakeRange(0, slen-1)];

    ////////////////////////////////////////////////////////////////
    
    
    // 调整坐标
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1., -1.);
    
    //  创建frameSetter
    CTFramesetterRef frameSetter=CTFramesetterCreateWithAttributedString((CFAttributedStringRef)mabstring);
    CFRange range=CFRangeMake(0, mabstring.length);
    
    // 创建path
    CGMutablePathRef path=CGPathCreateMutable();
    // 该方法不能少 x=10 x就向右偏移10
    CGPathAddRect(path, NULL, CGRectMake(0, 0,rect.size.width, rect.size.height));
    
    // 创建frame
    CTFrameRef frame=CTFramesetterCreateFrame(frameSetter, range, path, NULL);
   
    CTFrameDraw(frame, context);
    CGContextRestoreGState(context);
    
    
    CGContextAddRect(context, rect);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextStrokePath(context);
    CGPathRelease(path);
    CFRelease(frameSetter);
    CFRelease(frame);
}
*/
-(void)drawRect:(CGRect)rect{

    NSString * str=[NSString stringWithFormat:@"sunasdfasdf孙啊济南发生地方"];
    NSMutableAttributedString * attr=[[NSMutableAttributedString alloc]initWithString:str];
    long length=attr.length;
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    

    CTFramesetterRef frameSetter=   CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attr);
    
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathAddRect(path, NULL, rect);
    
    
    
    CTFrameRef frame=CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    //  获取line
    CFArrayRef arr=CTFrameGetLines(frame);
    NSLog(@"lines=%li",CFArrayGetCount(arr));
    CFIndex count=CFArrayGetCount(arr);
    
    for (int i=0; i< count ; i++) {
        CTLineRef line=CFArrayGetValueAtIndex(arr, 0);
        
        if (i==0) {
            NSAttributedString *truncatedString = [[NSAttributedString alloc]initWithString:@"\u2026"];
            CTLineRef token = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)truncatedString);
            
            CTLineTruncationType ltt = kCTLineTruncationStart;//kCTLineTruncationEnd;
            
            CTLineRef newline = CTLineCreateTruncatedLine(line, self.bounds.size.width-200, ltt, token);
            CGContextSetTextPosition(context, 30, 50);
            CTLineDraw(newline, context);// 使用这一行的话 坐标原点在左下角 就会在在左下角绘画 替代了CTFrameDraw()

        }
        // 获取run
        CFArrayRef runs=CTLineGetGlyphRuns(line);
        NSLog(@"run s= %li",CFArrayGetCount(runs));
        CFIndex runCount=CFArrayGetCount(runs);
        for (int j=0 ; j<runCount; j++) {
            CTRunRef run=CFArrayGetValueAtIndex(runs, j);
            
        }
    }
   // CTFrameDraw(frame, context);
    
    CGContextAddRect(context, rect);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextStrokePath(context);
    
    
}

@end
