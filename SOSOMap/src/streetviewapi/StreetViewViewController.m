
//
//
//  StreetViewViewController.m
//  SOSOStreetViewMapAPI
//
//  Created by lv wei on 13-3-26.
//  Copyright (c) 2013年 lv wei. All rights reserved.
//

#import "StreetViewViewController.h"
#import <CoreText/CoreText.h>

@interface StreetViewViewController ()
{
    EAGLContext* _context;
    NSMutableArray* myOverlays;
    
    NSArray *_arrShowText;
    NSArray *_arrLongitudeOffset;
    NSArray *_arrLatitudeOffset;
    NSArray *_arrHeight;
    int _index;
    double _x;
    double _y;
    NSTimer* _timer;
    BOOL _bAdded;
}

@property(nonatomic, retain)NSMutableArray* myOverlays;
@property (nonatomic, retain) NSArray *arrShowText;
@property (nonatomic, retain) NSArray *arrLongitudeOffset;
@property (nonatomic, retain) NSArray *arrLatitudeOffset;
@property (nonatomic, retain) NSArray *arrHeight;

- (void)createPoiNameTexutre:(NSString*)name bitmapData:(void**)bitmapData bitmapDataLength:(NSUInteger*)bitmapDataLength bitmapWidth:(NSUInteger*)bitmapWidth bitmapHeight:(NSUInteger*)bitmapHeight;
- (void)testSetPoiOverlay:(double)currX currY:(double)currY index:(int)index;

@end

@implementation StreetViewViewController
@synthesize streetView = _streetView;
@synthesize reverseGeocoder = _reverseGeocoder;
@synthesize myOverlays;
@synthesize arrShowText = _arrShowText;
@synthesize arrLongitudeOffset = _arrLongitudeOffset;
@synthesize arrLatitudeOffset = _arrLatitudeOffset;
@synthesize arrHeight = _arrHeight;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSMutableArray* o = [[NSMutableArray alloc] init];
    self.myOverlays = o;
    [o release];
    
    self.arrShowText = [NSArray arrayWithObjects:@"王艳:你在干嘛呢？", @"妈妈:儿子，回家吃饭了！", @"爸爸:赶紧回来", @"球友：明天去打球哈。", @"球友a：aaa", @"球友b：bbb", @"球友c：ccc", nil];
    
    self.arrLongitudeOffset = [NSArray arrayWithObjects:[NSNumber numberWithDouble:-0.0f],
                               [NSNumber numberWithDouble: 0.0010819158f],
                               [NSNumber numberWithDouble: 0.0005549158f],
                               [NSNumber numberWithDouble:0.00118f],
                               [NSNumber numberWithDouble: -0.00100158f],
                               [NSNumber numberWithDouble:-0.000189663f],
                               [NSNumber numberWithDouble:-0.00087f],
                               nil];
    
    
    // 纬度集合
    self.arrLatitudeOffset = [NSArray arrayWithObjects:[NSNumber numberWithDouble:0.014112999f],
                              [NSNumber numberWithDouble:0.000812999f],
                              [NSNumber numberWithDouble: -0.0008824],
                              [NSNumber numberWithDouble: -0.00020024],
                              [NSNumber numberWithDouble:-0.000302999f],
                              [NSNumber numberWithDouble:-0.00048f],
                              [NSNumber numberWithDouble:0.000582999f],
                              nil];
    
    // 高度
    self.arrHeight = [NSArray arrayWithObjects:[NSNumber numberWithInt:15],
                      [NSNumber numberWithInt:10],
                      [NSNumber numberWithInt:10],
                      [NSNumber numberWithInt:10],
                      
                      [NSNumber numberWithInt:10],
                      [NSNumber numberWithInt:0],
                      [NSNumber numberWithInt:0], nil];
    
    _index = -1;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(streetViewDidEnterBackground:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
}

- (void)streetViewDidEnterBackground:(NSNotification*)notification
{
    NSLog(@"xxx");
    [self testAddOverlay];
}

- (void)dealloc
{
    _reverseGeocoder.delegate = nil;
    _reverseGeocoder.delegate = nil;
    [_reverseGeocoder release];
    
    [_arrShowText release];
    [_arrLongitudeOffset release];
    [_arrLatitudeOffset release];
    [_arrHeight release];
    
    _streetView.delegate = nil;
    [_streetView release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation != UIDeviceOrientationPortraitUpsideDown);
}

- (BOOL)shouldAutorotate {
	return YES;
}


- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}
#pragma mark - reservegeocorderDelegate
- (void)reverseGeocoder:(QReverseGeocoder *)geocoder didFindPlacemark:(QPlaceMark *)placeMark
{
    NSLog(@"reverseGeocoder!");
    [_streetView showStreetView:placeMark];
    _x = placeMark.coordinate.longitude;
    _y = placeMark.coordinate.latitude; 
    _index = -1;
}

- (void)reverseGeocoder:(QReverseGeocoder *)geocoder didFailWithError:(QErrorCode)error
{
    //  NSLog(@"streetView  request fail! = %d",error);
}

- (void)delayAddOverlay {
    int nCount = self.arrShowText.count;
    for (int i=0; i<nCount; i++) {
        _x = self.streetView.streetViewInfo.longitude;
        _y =self.streetView.streetViewInfo.latitude;
        [self testSetPoiOverlay:_x currY:_y index:i];
        _index++;
    }
    _bAdded = YES;
}

- (void)streetView:(QStreetView *)streetview streetViewInfo:(QStreetViewInfo *)streetViewInfo
{
    switch (streetViewInfo.streetViewInfoType) {
        case QStreetViewInfoInit:
        case QStreetViewInfoSceneChange:{
            if (!_bAdded) {
                [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(delayAddOverlay) object:nil];
                [self performSelector:@selector(delayAddOverlay) withObject:nil afterDelay:2.0f];
            }
            
            break;
        }
        default:
            break;
    }
    //NSLog(@"info = %f,%f,%f,%f,%d",streetViewInfo.longitude,streetViewInfo.latitude,streetViewInfo.pitchAngle,streetViewInfo.yawAngle,streetViewInfo.streetViewInfoType);
}

- (void)streetView:(QStreetView *)streetview didSelectStreetViewOverlay:(QStreetViewOverlay*)streetViewOverlay
{
    // NSLog(@"location = (%f,%f)",streetViewOverlay.longitude,streetViewOverlay.latitude);
}
- (void)streetView:(QStreetView *)streetview didSelectStreetViewOverlay:(QStreetViewOverlay *)streetViewOverlay clickPosition:(CGPoint)postion streetViewOverlayFrame:(CGRect)frame
{
    //NSLog(@"overlayframe =%@,location=%@",NSStringFromCGRect(frame),NSStringFromCGPoint(postion));
}

- (void)streetView:(QStreetView *)streetview streetViewShowState:(QStreetViewShowState)streetViewShowState
{
    switch (streetViewShowState) {
        case QStreetViewShowThumbMap: {
            
            break;
        }
        default:
            break;
    }
    //NSLog(@"streetViewShowState = %d",streetViewShowState);
}

- (IBAction)newStreetViewEvent:(id)sender
{
    [_streetView removeStreetViewOverlays:myOverlays];
    [myOverlays removeAllObjects];
    
    if ([_streetView superview] ) {
        [_streetView removeFromSuperview];
    }
    
    [_streetView release];
    _streetView = nil;
    
    _reverseGeocoder.delegate = nil;
    [_reverseGeocoder release];
    _reverseGeocoder = nil;

    CLLocationCoordinate2D l1 = CLLocationCoordinate2DMake(31.219839,121.526017);
//    CLLocationCoordinate2D l1 = CLLocationCoordinate2DMake(39.988917, 116.422806);
    //CLLocationCoordinate2D l1 = CLLocationCoordinate2DMake(22.524896, 113.925659);
    //CLLocationCoordinate2D l1 = CLLocationCoordinate2DMake(0, 113.925659);
    QReverseGeocoder* r = [[QReverseGeocoder alloc] initWithCoordinate:l1];
    r.delegate = self;
    self.reverseGeocoder = r;
    r.radius = 100;
    [r start];
    [r release];
    CGRect rect = self.view.frame;
    int nTop = 40;
    QStreetView* sv = [[QStreetView alloc] initWithFrame:CGRectMake(20, nTop, rect.size.width - 40,
                                                                    rect.size.height - nTop - 10)];
    NSLog(@"frame = %@",NSStringFromCGRect( self.view.frame));
    sv.delegate = self;
    sv.isSupportMotionManager = YES;
    self.streetView = sv;
    
    [self.view addSubview:_streetView];
    [sv release];
    
    
    //_timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(testAddOverlay) userInfo:nil repeats:YES];
    
}

- (IBAction)destroyStreetViewEvent:(id)sender
{
    [_streetView removeStreetViewOverlays:myOverlays];
    [myOverlays removeAllObjects];
    
    if ([_streetView superview] ) {
        [_streetView removeFromSuperview];
    }
    
    _streetView.delegate = nil;
    [_streetView release];
    _streetView = nil;
}

- (BOOL)isRetina {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        return [UIScreen mainScreen].scale >= 2.0;
    }
    return NO;
}

- (void)createPoiNameTexutre:(NSString*)name bitmapData:(void**)bitmapData bitmapDataLength:(NSUInteger*)bitmapDataLength
                 bitmapWidth:(NSUInteger*)bitmapWidth bitmapHeight:(NSUInteger*)bitmapHeight
{
    NSString *text = name;
    
    UIImage *uiImage = [UIImage imageNamed:@"marker_centre.png"];
    if (uiImage == nil)
    {
        return;
    }
    
    CGImageRef image = uiImage.CGImage;
    CGFloat imageWidth = CGImageGetWidth(image);
    CGFloat imageHeight = CGImageGetHeight(image);
    
    CGFloat fontSize = 16.0f;
    CGFloat titleHeight = 26.0f;
    CGFloat blank = 3.0f;
    CGFloat enterButtonSize = 12.0f;
    
    if ([self isRetina])
    {
        fontSize *= 2.0f;
        titleHeight *= 2.0f;
        blank *= 2.0f;
        enterButtonSize *= 2.0f;
    }
    
    UIFont *uiFont = [UIFont boldSystemFontOfSize:fontSize];
    CTFontRef ctFont = CTFontCreateWithName((CFStringRef)uiFont.fontName, uiFont.pointSize, NULL);
    
    NSMutableAttributedString* attributedString = [[[NSMutableAttributedString alloc] initWithString:text] autorelease];
    [attributedString addAttribute:(NSString *)kCTFontAttributeName
                             value:(id)ctFont
                             range:NSMakeRange(0, [attributedString length])];
    [attributedString addAttribute:(NSString *)kCTForegroundColorAttributeName
                             value:(id)[UIColor whiteColor].CGColor
                             range:NSMakeRange(0, [attributedString length])];
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedString);
    
    CGSize size = CTFramesetterSuggestFrameSizeWithConstraints(
                                                               framesetter,
                                                               CFRangeMake(0, 0), NULL,
                                                               CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX), NULL);
    size.width = roundf(size.width + 0.5f);
    size.height = roundf(size.height + 0.5f);
    
    int POTWidth = blank + size.width + blank + enterButtonSize + blank;
    int POTHeight = titleHeight + imageHeight + blank;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	int nLen = POTHeight * POTWidth * 4;
    char *data = (char*)calloc(1, nLen);
    CGContextRef bmpContext = CGBitmapContextCreate(data, POTWidth, POTHeight, 8, 4 * POTWidth, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big );
	CGColorSpaceRelease(colorSpace);
    
    {
        UIGraphicsPushContext(bmpContext);
        
        CGContextSaveGState(bmpContext);
        
        CGContextScaleCTM(bmpContext, 1.0, -1.0);
        CGContextTranslateCTM(bmpContext, 0.0, -POTHeight);
        
        CGRect textRect = CGRectMake(0, 0, POTWidth, titleHeight);
        [[[UIImage imageNamed:@"toast-for-sv.png"] stretchableImageWithLeftCapWidth:27 topCapHeight:13] drawInRect:textRect];
        [[UIImage imageNamed:@"bubble_icon_enter.png"] drawInRect:CGRectMake(POTWidth-enterButtonSize-blank, (titleHeight-enterButtonSize)/2.0f, enterButtonSize, enterButtonSize)];
        
        [uiImage drawInRect:CGRectMake((POTWidth - imageWidth)/2.0f, titleHeight + blank, imageWidth, imageHeight)];
        
        CGContextRestoreGState(bmpContext);
        
        UIGraphicsPopContext();
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, nil, CGRectMake(blank, POTHeight-(titleHeight+size.height)/2, size.width, size.height));
        CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
        CTFrameDraw(frame, bmpContext);
        CGPathRelease(path);
        CFRelease(frame);
    }
	CGContextRelease(bmpContext);
    
    CFRelease(framesetter);
    CFRelease(ctFont);
    
    *bitmapData = data;
    *bitmapDataLength = nLen;
    *bitmapWidth = POTWidth;
    *bitmapHeight = POTHeight;
}

- (IBAction)addStreetViewOverlayEvent:(id)sender {
    int nCount = self.arrShowText.count;
    if (_index < (nCount - 1)) {
        _index++;
        [self testSetPoiOverlay:_x currY:_y index:_index];
    }
    
}

- (IBAction)removeStreetViewOverlayEvent:(id)sender {
    if (_index >= 0 && _index < myOverlays.count) {
        [self.streetView removeStreetViewOverlay:[myOverlays objectAtIndex:_index]];
        [myOverlays removeObjectAtIndex:_index];
        _index--;
    }
    
}
//设置周边标记
- (void)testSetPoiOverlay:(double)currX currY:(double)currY index:(int)index{
    
    QStreetViewOverlay* overlay = [[QStreetViewOverlay alloc] init];
    overlay.supportScaleEffect = YES;
    void* pBitmapData = NULL;
    NSUInteger bitmapDataLength = 0;
    NSUInteger bitmapWidth = 0;
    NSUInteger bitmapHeight = 0;
    
    [self createPoiNameTexutre:[self.arrShowText objectAtIndex:index] bitmapData:&pBitmapData
              bitmapDataLength:&bitmapDataLength bitmapWidth:&bitmapWidth
                  bitmapHeight:&bitmapHeight];
    
    QVisibleLevel visibleLevel = QVisibleLevelFirst;
    double fOffset = [[self.arrLongitudeOffset objectAtIndex:index] doubleValue];
    double fOutX = currX + fOffset;
    fOffset = [[self.arrLatitudeOffset objectAtIndex:index] doubleValue];
    double fOutY = currY + fOffset;
    int nHeight = [[self.arrHeight objectAtIndex:index] intValue];
    overlay.longitude = fOutX;
    overlay.latitude = fOutY;
    overlay.height = nHeight;
    overlay.visibleLevel = visibleLevel;
    //考虑到内存占用，使用浅拷贝的方式
    [overlay setBitmapDataWithNoCopy:pBitmapData bitmapDataLength:bitmapDataLength bitmapWidth:bitmapWidth bitmapHeight:bitmapHeight];
    [_streetView addStreetViewOverlay:overlay];
    [myOverlays addObject:overlay];
    
    if (pBitmapData) {
        free(pBitmapData);
        pBitmapData = NULL;
    }
    //重置Overlay中的BITMAP相关数据
    [overlay releaseBitmapData:NO];
    [overlay release];
    
}

- (void)testAddOverlay{
    
    QStreetViewOverlay* overlay = [[QStreetViewOverlay alloc] init];
    overlay.supportScaleEffect = NO;
    void* pBitmapData = NULL;
    NSUInteger bitmapDataLength = 0;
    NSUInteger bitmapWidth = 0;
    NSUInteger bitmapHeight = 0;
    
    [self createPoiNameTexutre:@"abc" bitmapData:&pBitmapData
              bitmapDataLength:&bitmapDataLength bitmapWidth:&bitmapWidth
                  bitmapHeight:&bitmapHeight];
    CLLocationCoordinate2D l1 = CLLocationCoordinate2DMake(39.988917, 116.422806);
    QVisibleLevel visibleLevel = QVisibleLevelFirst;
    double fOffset = 0;
    double fOutX = l1.longitude + fOffset;
    fOffset = 0;
    double fOutY =l1.latitude;
    int nHeight = 0;
    overlay.longitude = fOutX;
    overlay.latitude = fOutY;
    overlay.height = nHeight;
    overlay.visibleLevel = visibleLevel;
    //考虑到内存占用，使用浅拷贝的方式
    [overlay setBitmapDataWithNoCopy:pBitmapData bitmapDataLength:bitmapDataLength bitmapWidth:bitmapWidth bitmapHeight:bitmapHeight];
    [_streetView addStreetViewOverlay:overlay];
    [myOverlays addObject:overlay];
    NSLog(@"addoverlay");
    if (pBitmapData) {
        free(pBitmapData);
        pBitmapData = NULL;
    }
    //重置Overlay中的BITMAP相关数据
    [overlay releaseBitmapData:NO];
    [overlay release];
    
}


@end

