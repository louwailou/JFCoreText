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
/*
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
*/
/*
// 转换当前的text matrix 就可以正确绘画
-(void)drawRect:(CGRect)rect{
    NSString *src = @"其实流程是这样的： 1、生成要绘制的NSAttributedString对象。 ";
    
    NSMutableAttributedString * mabstring = [[NSMutableAttributedString alloc]initWithString:src];
    
    long slen = [mabstring length];
    
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)mabstring);
    
    CGMutablePathRef Path = CGPathCreateMutable();
    
    //坐标点在左下角
    CGPathAddRect(Path, NULL ,CGRectMake(10 , 10 ,self.bounds.size.width-20 , self.bounds.size.height-20));
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    
    
    //得到frame中的行数组
    CFArrayRef rows = CTFrameGetLines(frame);
    
    if (rows) {
        const CFIndex numberOfLines = CFArrayGetCount(rows);
        const CGFloat fontLineHeight = [UIFont systemFontOfSize:20].lineHeight;
        CGFloat textOffset = 0;
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSaveGState(ctx);
        NSLog(@"rect =%@",NSStringFromCGRect(rect));
        // 这次只调整当前的text matrix 就可以
 
        CGContextTranslateCTM(ctx, rect.origin.x, rect.origin.y+[UIFont systemFontOfSize:20].ascender);
        // saveContext 对当前的text matrix没有效果
        CGContextSetTextMatrix(ctx, CGAffineTransformMakeScale(1,-1));
 
        
        
        for (CFIndex lineNumber=0; lineNumber<numberOfLines; lineNumber++) {
            CTLineRef line = CFArrayGetValueAtIndex(rows, lineNumber);
            float flush;
            switch (0) {
                case NSTextAlignmentCenter: flush = 0.5;    break; //1
                case NSTextAlignmentRight:  flush = 1;      break; //2
                case NSTextAlignmentLeft:  //0
                default:                    flush = 0;      break;
            }
            
            CFIndex index= CTLineGetStringIndexForPosition( line, CGPointMake(10, 0));
            NSLog(@"index= %li",index);
            
            CGFloat penOffset = CTLineGetPenOffsetForFlush(line, flush, rect.size.width);
            NSLog(@"penOffset = %f",penOffset);
            CGContextSetTextPosition(ctx, penOffset, textOffset);//在偏移量x,y上打印
            CTLineDraw(line, ctx);//draw 行文字
            textOffset += fontLineHeight;
        }
        
        CGContextRestoreGState(ctx);
        
    }
}
*/
/*
 // 使用CTLineRef 获取行高等信息
-(void)drawRect:(CGRect)rect
{
    NSString *src = @"其实流程是这样的： 1、生成要绘制的NSAttributedString对象。 ";
    
    NSMutableAttributedString * mabstring = [[NSMutableAttributedString alloc]initWithString:src];
    
    NSMutableDictionary* attriDic=[[NSMutableDictionary alloc]initWithCapacity:0];
    [attriDic setObject:(id)[UIColor blueColor].CGColor forKey:(id)kCTForegroundColorAttributeName];
    UIFont * font_=[UIFont systemFontOfSize:20];
    CTFontRef font=CTFontCreateWithName((CFStringRef)font_.fontName, 20, NULL);
    [attriDic setObject:(__bridge id)font forKey:(id)kCTFontAttributeName];
    
    NSLog(@"font lineheight =%f",font_.lineHeight);// 行高
    // begin 不准确
    NSLog(@"font ascending =%f",font_.ascender);
    NSLog(@"desc =%f",font_.descender);
    NSLog(@"leading =%f",font_.leading);
    NSLog(@"capHeight =%f",font_.capHeight);
    NSLog(@"xHeight =%f",font_.xHeight);
    // end
    // leading+ascender+|descender|=lineHeight
    [mabstring addAttributes:attriDic range: NSMakeRange(0, mabstring.length)];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(ctx , CGAffineTransformIdentity);
    
    //CGContextSaveGState(ctx);
    
    //x，y轴方向移动
    CGContextTranslateCTM(ctx , 0 ,self.bounds.size.height);
    
    //缩放x，y轴方向缩放，－1.0为反向1.0倍,坐标系转换,沿x轴翻转180度
    CGContextScaleCTM(ctx, 1.0 ,-1.0);
    
    // layout master
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(
                                                                           (CFAttributedStringRef)mabstring);
    CGMutablePathRef Path = CGPathCreateMutable();
    
    //坐标点在左下角
    CGPathAddRect(Path, NULL ,CGRectMake(0 , 0 ,self.bounds.size.width , self.bounds.size.height));
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    
    CFArrayRef Lines = CTFrameGetLines(frame);
    
    CFIndex linecount = CFArrayGetCount(Lines);
    
    CGPoint origins[linecount];
    CTFrameGetLineOrigins(frame,
                          CFRangeMake(0, 0), origins);
    NSInteger lineIndex = 0;
    
    for (id oneLine in (__bridge NSArray *)Lines)
    {
        // bounds 觉得不包含行间距
        CGRect lineBounds = CTLineGetImageBounds((CTLineRef)oneLine, ctx);
        NSLog(@"lineBounds =%@",NSStringFromCGRect(lineBounds));
        CGFloat asc,des,lead;
        double lineWidth = CTLineGetTypographicBounds((CTLineRef)oneLine, &asc, &des, &lead);
        // 计算准确
        NSLog(@"ascent = %f,descent = %f,leading = %f,lineWidth = %f",asc,des,lead,lineWidth);
        lineBounds.origin.x += origins[lineIndex].x;
        lineBounds.origin.y += origins[lineIndex].y;
        
        lineIndex++;
        //画长方形
        
        //设置颜色，仅填充4条边
        CGContextSetStrokeColorWithColor(ctx, [[UIColor redColor] CGColor]);
        //设置线宽为1
        CGContextSetLineWidth(ctx, 1.0);
        //设置长方形4个顶点
        CGPoint poins[] = {CGPointMake(lineBounds.origin.x, lineBounds.origin.y),CGPointMake(lineBounds.origin.x+lineBounds.size.width, lineBounds.origin.y),CGPointMake(lineBounds.origin.x+lineBounds.size.width, lineBounds.origin.y+lineBounds.size.height),CGPointMake(lineBounds.origin.x, lineBounds.origin.y+lineBounds.size.height)};
        CGContextAddLines(ctx,poins,4);
        CGContextClosePath(ctx);
        CGContextStrokePath(ctx);
        
    }
    
    
    
    CTFrameDraw(frame,ctx);
    
    CGPathRelease(Path);
    CFRelease(framesetter);
}
 */
void RunDelegateDeallocCallback( void* refCon ){
    
}

CGFloat RunDelegateGetAscentCallback( void *refCon ){
    NSString *imageName = (__bridge NSString *)refCon;
    return [UIImage imageNamed:imageName].size.height;
}

CGFloat RunDelegateGetDescentCallback(void *refCon){
    return 120;
}

CGFloat RunDelegateGetWidthCallback(void *refCon){
    NSString *imageName = (__bridge NSString *)refCon;
    return [UIImage imageNamed:imageName].size.width;
}
-(void)drawRect:(CGRect)rect{
    CGContextRef context=UIGraphicsGetCurrentContext();
//    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
//    CGContextTranslateCTM(context, 0, rect.size.height);
//    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);//设置字形变换矩阵为CGAffineTransformIdentity，也就是说每一个字形都不做图形变换
    
    CGAffineTransform flipVertical = CGAffineTransformMake(1,0,0,-1,0,self.bounds.size.height);
    CGContextConcatCTM(context, flipVertical);//将当前context的坐标系进行flip
    NSLog(@"bh=%f",self.bounds.size.height);
    
    NSMutableAttributedString * string=[[NSMutableAttributedString alloc]initWithString:@" 插入一张图片的xcga sdfad方法真多发点啊的事发生的发生打发似的阿萨德发阿萨德发是短发撒旦发射点法阿萨德发阿萨德发阿萨德发送到发射点法阿萨德发阿萨德发是短发撒旦发射发射点法是短发 阿萨德发阿萨德发"];
    
    
     /*******************************/
    CTRunDelegateCallbacks imagesCallBacks;
    imagesCallBacks.version=kCTRunDelegateCurrentVersion;
    imagesCallBacks.getWidth=RunDelegateGetWidthCallback;
    imagesCallBacks.getDescent=RunDelegateGetDescentCallback;
    imagesCallBacks.getAscent=RunDelegateGetAscentCallback;
    imagesCallBacks.dealloc=RunDelegateDeallocCallback;
    
    NSString * imageName=@"imageName.png";
    CTRunDelegateRef runDelegate=CTRunDelegateCreate(&imagesCallBacks, (__bridge void *)(imageName));
    NSMutableAttributedString *imageAttributedString = [[NSMutableAttributedString alloc] initWithString:@" "];//空格用于给图片留位置
    
    [imageAttributedString addAttribute:(id)kCTRunDelegateAttributeName value:(__bridge id)runDelegate range:NSMakeRange(0, 1)];
    CFRelease(runDelegate);
    
    // 自定义一个attribute 表示image的占位符
    [imageAttributedString addAttribute:@"imageName" value:imageName range:NSMakeRange(0, 1)];
    
    [string insertAttributedString:imageAttributedString atIndex:4];
      /*******************************/
    
    
    
    
    CTParagraphStyleSetting lineBreakMode;
    CTLineBreakMode lineBreak = kCTLineBreakByCharWrapping;
    lineBreakMode.spec = kCTParagraphStyleSpecifierLineBreakMode;
    lineBreakMode.value = &lineBreak;
    lineBreakMode.valueSize = sizeof(CTLineBreakMode);
    
    CTParagraphStyleSetting settings[] = {
        lineBreakMode
    };
    
    CTParagraphStyleRef style = CTParagraphStyleCreate(settings, 1);
    
    
    // build attributes
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithObject:(__bridge id  )style forKey:(id)kCTParagraphStyleAttributeName ];
    
    // set attributes to attributed string
    [string addAttributes:attributes range:NSMakeRange(0, [string length])];
    
    
    
    CTFramesetterRef ctFramesetter = CTFramesetterCreateWithAttributedString((CFMutableAttributedStringRef)string);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect bounds = CGRectMake(0.0, 0.0, self.bounds.size.width, self.bounds.size.height);
    CGPathAddRect(path, NULL, bounds);
    
    CTFrameRef ctFrame = CTFramesetterCreateFrame(ctFramesetter,CFRangeMake(0, 0), path, NULL);
    CTFrameDraw(ctFrame, context);
    // get rows from frame
    CFArrayRef lines = CTFrameGetLines(ctFrame);
    CGPoint lineOrigins[CFArrayGetCount(lines)];
    CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), lineOrigins);
    
    NSLog(@"line count = %ld",CFArrayGetCount(lines));
    for (int i = 0; i < CFArrayGetCount(lines); i++) {
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CGFloat lineAscent;
        CGFloat lineDescent;
        CGFloat lineLeading;
        CTLineGetTypographicBounds(line, &lineAscent, &lineDescent, &lineLeading);
        NSLog(@"ascent = %f,descent = %f,leading = %f",lineAscent,lineDescent,lineLeading);
        
        CFArrayRef runs = CTLineGetGlyphRuns(line);
        NSLog(@"run count = %ld",CFArrayGetCount(runs));
        for (int j = 0; j < CFArrayGetCount(runs); j++) {
            CGFloat runAscent;
            CGFloat runDescent;
            CGPoint lineOrigin = lineOrigins[i];
            CTRunRef run = CFArrayGetValueAtIndex(runs, j);
            NSDictionary* attributes = (NSDictionary*)CTRunGetAttributes(run);
            CGRect runRect;
            runRect.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0,0), &runAscent, &runDescent, NULL);
            NSLog(@"width = %f",runRect.size.width);
            
            runRect=CGRectMake(lineOrigin.x + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL), lineOrigin.y - runDescent, runRect.size.width, runAscent + runDescent);
            
            NSString *imageName = [attributes objectForKey:@"imageName"];
            //图片渲染逻辑
            if (imageName) {
                UIImage *image = [UIImage imageNamed:imageName];
                if (image) {
                    CGRect imageDrawRect;
                    imageDrawRect.size = image.size;
                    imageDrawRect.origin.x = runRect.origin.x + lineOrigin.x;
                    imageDrawRect.origin.y = lineOrigin.y;
                    CGContextDrawImage(context, imageDrawRect, image.CGImage);
                }
            }
        }
    }
    
    CFRelease(ctFrame);
    CFRelease(path);
    CFRelease(ctFramesetter);
}

@end
