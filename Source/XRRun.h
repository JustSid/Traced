//
//  XRRun.h
//  Traced
//
//  Created by Sidney Just
//  Copyright (c) 2013 by Sidney Just
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
//  documentation files (the "Software"), to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
//  and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
//  PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
//  FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
//  ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <Foundation/Foundation.h>

@interface XRRun : NSObject
{
	NSUInteger runNumber;
	NSTimeInterval startTime;
	NSTimeInterval endTime;
	
	NSMutableArray *trackSegments;
	NSMutableDictionary *runData;
	
	BOOL dataChanged;
	BOOL fetchedArchInfo;
	BOOL is64BitTarget;
}

@end

@interface XRVideoCardRun : XRRun
{
	NSMutableArray *sampleData;
}

@end

/*
 sampleData contains an array of dictionaries with all the samples of the run
 the content of these dictionaries looks like this:
 
 {
	 "Built-In" = "Built-In";
	 CommandBufferRenderCount = 33;
	 CommandBufferSubmitCount = 0;
	 CommandBufferTransferCount = 0;
	 CoreAnimationFramesPerSecond = 27;
	 "Device Utilization %" = 0;
	 "Renderer Utilization %" = 0;
	 SplitSceneCount = 0;
	 TiledSceneBytes = 1720320;
	 "Tiler Utilization %" = 0;
	 XRVideoCardRunTimeStamp = 1012740;
	 commandGLBytesPerSample = 0;
	 contextGLCount = 3;
	 finishGLWaitTime = 0;
	 gartMapInBytesPerSample = 114753536;
	 gartMapOutBytesPerSample = 32587776;
	 gartUsedBytes = 85909504;
	 hardwareWaitTime = 8402916;
	 recoveryCount = 0;
	 textureCount = "-13887";
 }
 
 */
