//
//  MWFeedInfo.m
//  MWFeedParser
//
//  Copyright (c) 2010 Michael Waterfall
//  
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  1. The above copyright notice and this permission notice shall be included
//     in all copies or substantial portions of the Software.
//  
//  2. This Software cannot be used to archive or collect data such as (but not
//     limited to) that of events, news, experiences and activities, for the 
//     purpose of any concept relating to diary/journal keeping.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "MWFeedInfo.h"

static NSString * const MWFeedInfoGuidKey       = @"id";
static NSString * const MWFeedInfoTitleKey      = @"title";
static NSString * const MWFeedInfoLinkKey       = @"link";
static NSString * const MWFeedInfoSummaryKey    = @"summary";
static NSString * const MWFeedInfoUrlKey        = @"url";
static NSString * const MWFeedInfoImageUrlKey   = @"image";
static NSString * const MWFeedInfoFeedItems     = @"feed_items";

#define EXCERPT(str, len) (([str length] > len) ? [[str substringToIndex:len-1] stringByAppendingString:@"…"] : str)

@implementation MWFeedInfo

- (instancetype)initWithObjectMap:(NSDictionary *)map
{
    self = [super init];
    if (self)
    {
        _guid = [map objectForKey:MWFeedInfoGuidKey];
        _title = [map objectForKey:MWFeedInfoTitleKey];
        _link = [map objectForKey:MWFeedInfoLinkKey];
        _summary = [map objectForKey:MWFeedInfoSummaryKey];
        _url = [map objectForKey:MWFeedInfoUrlKey];
        _imageURL = [map objectForKey:MWFeedInfoImageUrlKey];
    }
    return self;
}

- (NSDictionary *)objectMap
{
    NSMutableDictionary *map = [NSMutableDictionary dictionary];
    
    [map setValue:_guid forKey:MWFeedInfoGuidKey];
    [map setValue:_title forKey:MWFeedInfoTitleKey];
    [map setValue:_link forKey:MWFeedInfoLinkKey];
    [map setValue:_summary forKey:MWFeedInfoSummaryKey];
    [map setValue:_url forKey:MWFeedInfoUrlKey];
    [map setValue:_imageURL forKey:MWFeedInfoUrlKey];

    return map;
}

#pragma mark NSObject

- (NSString *)description
{
	NSMutableString *string = [[NSMutableString alloc] initWithString:@"MWFeedInfo: "];
	if (self.title)   [string appendFormat:@"“%@”", EXCERPT(self.title, 50)];
	return string;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    
	if (self)
    {
        _guid = [decoder decodeObjectForKey:MWFeedInfoGuidKey];
		_title = [decoder decodeObjectForKey:MWFeedInfoTitleKey];
		_link = [decoder decodeObjectForKey:MWFeedInfoLinkKey];
		_summary = [decoder decodeObjectForKey:MWFeedInfoSummaryKey];
		_url = [decoder decodeObjectForKey:MWFeedInfoUrlKey];
        _imageURL = [decoder decodeObjectForKey:MWFeedInfoImageUrlKey];
        _feedItems = [decoder decodeObjectForKey:MWFeedInfoFeedItems];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_guid forKey:MWFeedInfoGuidKey];
    [encoder encodeObject:_title forKey:MWFeedInfoTitleKey];
	[encoder encodeObject:_link forKey:MWFeedInfoLinkKey];
	[encoder encodeObject:_summary forKey:MWFeedInfoSummaryKey];
	[encoder encodeObject:_url forKey:MWFeedInfoUrlKey];
    [encoder encodeObject:_imageURL forKey:MWFeedInfoUrlKey];
    [encoder encodeObject:_feedItems forKey:MWFeedInfoFeedItems];
}

@end
