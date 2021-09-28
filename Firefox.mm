#import <Foundation/Foundation.h>
#import <Foundation/NSPlatform.h>
#include <unistd.h>
#include <fcntl.h>

int main(int argc, const char **argv)
{
    __NSInitializeProcess(argc, argv);
    @autoreleasepool {
        NSBundle *mainBundle = [[NSBundle mainBundle] autorelease];

        NSString *execPath = [mainBundle pathForResource:@"firefox" ofType:@""
            inDirectory:@"usr/lib/firefox"];
        execv([execPath UTF8String], (char * const *)argv);
    }

    return -1;
}
