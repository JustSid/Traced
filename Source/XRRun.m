//
//  XRRun.m
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

#import "XRRun.h"

#define kXRVideoCardRunTilerUtilizationKey @"Tiler Utilization %"
#define kXRVideoCardRunDeviceUtilizationKey @"Device Utilization %"
#define kXRVideoCardRunRendererUtilizationKey @"Renderer Utilization %"
#define kXRVideoCardRunFPSKey @"CoreAnimationFramesPerSecond"
#define kXRVideoCardRunTimestampKey @"XRVideoCardRunTimeStamp"

@implementation XRRun

- (id)initWithCoder:(NSCoder *)decoder
{
	if((self = [super init]))
	{
		startTime = [[decoder decodeObject] doubleValue];
		endTime   = [[decoder decodeObject] doubleValue];
		runNumber = [[decoder decodeObject] unsignedIntegerValue];
		
		trackSegments = [[decoder decodeObject] retain];
		
		// Totally not sure about these
		// They are numbers, but if this is the correct assignment... no idea.
		dataChanged     = [[decoder decodeObject] boolValue];
		fetchedArchInfo = [[decoder decodeObject] boolValue];
		is64BitTarget   = [[decoder decodeObject] boolValue];
		
		runData = [[decoder decodeObject] retain];
	}
	
	return self;
}

- (void)dealloc
{
	[runData release];
	[trackSegments release];
	
	[super dealloc];
}


@end

@implementation XRVideoCardRun


- (NSString *)formattedSample:(NSUInteger)index
{
	NSDictionary *data = [sampleData objectAtIndex:index];
	NSMutableString *result = [NSMutableString string];
	
	double timestamp = [[data objectForKey:kXRVideoCardRunTimestampKey] doubleValue];
	double milliseconds = timestamp / 1000.0;
	double seconds      = milliseconds / 1000.0;
	
	[result appendFormat:@"FPS: %@ ", [data objectForKey:kXRVideoCardRunFPSKey]];
	[result appendFormat:@"Device: %@%% ", [data objectForKey:kXRVideoCardRunDeviceUtilizationKey]];
	[result appendFormat:@"Renderer: %@%% ", [data objectForKey:kXRVideoCardRunRendererUtilizationKey]];
	[result appendFormat:@"Tiler: %@%% ", [data objectForKey:kXRVideoCardRunTilerUtilizationKey]];
	[result appendFormat:@"Timestamp: %f ", seconds];
	
	return result;
}

- (NSString *)description
{
	NSString *start = [NSDateFormatter localizedStringFromDate:[NSDate dateWithTimeIntervalSince1970:startTime] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterMediumStyle];
	NSString *end = [NSDateFormatter localizedStringFromDate:[NSDate dateWithTimeIntervalSince1970:endTime] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterMediumStyle];
	
	NSMutableString *result = [NSMutableString stringWithFormat:@"Run %u, starting at %@, running until %@\n", (unsigned int)runNumber, start, end];
	
	for(NSUInteger i=0; i<[sampleData count]; i++)
	{
		[result appendFormat:@"Sample %u: %@\n", (unsigned int)i, [self formattedSample:i]];
	}
	
	return result;
}



- (id)initWithCoder:(NSCoder *)decoder
{
	if((self = [super initWithCoder:decoder]))
	{
		// No idea what that is or if it actually belongs to this class or XRRun
		// It's an NSNumber, and XRRun doesn't have any more numbers according
		// to class-dump, so yeah...
		[decoder decodeObject];
		
		sampleData = [[decoder decodeObject] retain];
		
		// Here are now three more objects, which are all nil...
		// Anyone got any idea?
		[decoder decodeObject];
		[decoder decodeObject];
		[decoder decodeObject];
	}
	
	return self;
}

- (void)dealloc
{
	[sampleData release];
	[super dealloc];
}

@end
