//
//  MWFeedItem.m
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

#import "MWFeedItem.h"
#import "NSString+HTML.h"

#define EXCERPT(str, len) (([str length] > len) ? [[str substringToIndex:len-1] stringByAppendingString:@"…"] : str)

@implementation MWFeedItem

#pragma mark NSObject

- (NSString *)description {
	NSMutableString *string = [[NSMutableString alloc] initWithString:@"MWFeedItem: "];
	if (self.title)   [string appendFormat:@"“%@”", EXCERPT(self.title, 50)];
	if (self.date)    [string appendFormat:@" - %@", self.date];
	return string;
}

#pragma mark - Properties

@synthesize guid = _guid;

- (NSString *)guid
{
    if (_guid)
        return _guid;
    
    if (self.identifier.length)
    {
        _guid = [self.identifier md5HashSum];
    }
    else if (self.link.length)
    {
        _guid = [self.link md5HashSum];
    }
    else if (self.title.length)
    {
        _guid = [self.title md5HashSum];
    }
    else
    {
        _guid = [[NSString stringWithFormat:@"%@%@%@%@", self.identifier, self.date, self.title, self.link] md5HashSum];
    }
    
    return _guid;
}

#pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self)
    {
		_identifier = [decoder decodeObjectForKey:@"identifier"];
		_title = [decoder decodeObjectForKey:@"title"];
		_link = [decoder decodeObjectForKey:@"link"];
		_date = [decoder decodeObjectForKey:@"date"];
		_updated = [decoder decodeObjectForKey:@"updated"];
		_summary = [decoder decodeObjectForKey:@"summary"];
		_content = [decoder decodeObjectForKey:@"content"];
		_author = [decoder decodeObjectForKey:@"author"];
		_enclosures = [decoder decodeObjectForKey:@"enclosures"];
        
        _imageURL = [decoder decodeObjectForKey:@"imageURL"];
        _guid = [decoder decodeObjectForKey:@"guid"];
        _feedInfo = [decoder decodeObjectForKey:@"feedInfo"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
	[encoder encodeObject:_identifier forKey:@"identifier"];
	[encoder encodeObject:_title forKey:@"title"];
	[encoder encodeObject:_link forKey:@"link"];
	[encoder encodeObject:_date forKey:@"date"];
	[encoder encodeObject:_updated forKey:@"updated"];
	[encoder encodeObject:_summary forKey:@"summary"];
	[encoder encodeObject:_content forKey:@"content"];
	[encoder encodeObject:_author forKey:@"author"];
	[encoder encodeObject:_enclosures forKey:@"enclosures"];
    [encoder encodeObject:_imageURL forKey:@"imageURL"];
    [encoder encodeObject:self.guid forKey:@"guid"];
    [encoder encodeObject:_feedInfo forKey:@"feedInfo"];
}

@end
