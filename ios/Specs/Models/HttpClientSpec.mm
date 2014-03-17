#import "HttpClient.h"
#import "FakeURLSession.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(HttpClientSpec)

describe(@"HttpClient", ^{
    __block HttpClient *httpClient;
    __block FakeURLSession *fakeURLSession;

    beforeEach(^{
        fakeURLSession = [[FakeURLSession alloc] init];
        httpClient = [[HttpClient alloc] initWithSession:fakeURLSession];
    });

    it(@"GETs lists, calling back with an array of JSON objects", ^{
        __block NSArray *responseList;

        [httpClient getList:@"http://example.com" then:^(NSArray *list) {
            responseList = list;
        } error:^(NSError *error) {}];

        [fakeURLSession completeGetWith:@"[{\"name\": \"John\"}]"];
        responseList should equal(@[@{@"name": @"John"}]);
    });
});

SPEC_END
