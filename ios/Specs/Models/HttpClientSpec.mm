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

        fakeURLSession.url should equal(@"http://example.com");
        responseList should equal(@[@{@"name": @"John"}]);
    });

    it(@"POSTs to URL with data, calling back with a JSON response", ^{
        __block NSDictionary *response;

        [httpClient post:@"http://example.com" withBody:@{@"name": @"John", @"friend": @"Bill"} then:^(NSDictionary *dictionary){
            response = dictionary;
        } error:^(NSError *error) {}];

        [fakeURLSession completePostWith:@"[{\"id\": 3, \"name\": \"John\", \"friend\": \"Bill\"}]"];

        fakeURLSession.url should equal(@"http://example.com");
        fakeURLSession.method should equal(@"POST");
        fakeURLSession.body should equal(@"friend=Bill&name=John");
        response should equal(@[@{@"name": @"John", @"id": @3, @"friend": @"Bill"}]);
    });

    it(@"DELETEs data, calling back when complete", ^{
        __block BOOL responseReceived = NO;

        [httpClient delete:@"http://example.com/posts/10" then:^(){
            responseReceived = YES;
        } error:^(NSError *error) {}];

        [fakeURLSession completeDelete];

        fakeURLSession.url should equal(@"http://example.com/posts/10");
        fakeURLSession.method should equal(@"DELETE");
        responseReceived should be_truthy;
    });
});

SPEC_END
