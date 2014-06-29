//
//  NSArray+RubySugar.m
//  RubySugar
//
//  Copyright (c) 2013 Michal Konturek
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "NSArray+RubySugar.h"

#import "NSNumber+RubySugar.h"
#import "NSString+RubySugar.h"

#import <MKFoundationKit/NSArray+MK_Block.h>

@implementation NSArray (RubySugar)

- (instancetype):(id)object {
    if (!object) return self;
    
    id result = [NSMutableArray arrayWithArray:self];
    if ([object isKindOfClass:[NSArray class]]) [result addObjectsFromArray:object];
    else [result addObject:object];
    
    return result;
}

- (instancetype):(NSInteger)from :(NSInteger)to {
    return [self :from :to exclusive:NO];
}

- (instancetype):(NSInteger)from :(NSInteger)to exclusive:(BOOL)exclusive {
    id op = (exclusive) ? @"..." : @"..";
    return self[[NSString stringWithFormat:@"%li%@%li", (long)from, op, (long)to]];
}

- (instancetype)rs_clear {
    return [[self class] array];
}

- (instancetype)rs_combination:(NSInteger)n {
    if (n == 1) return [self rs_zip];
    
    id result = [NSMutableArray array];
    for (int idx = 0; idx < self.count; idx++) {
        id element = self[idx];
        id temp = [self rs_drop:(idx + 1)];
        for (id array in [temp rs_combination:n - 1]) {
            [result addObject:[array : element]];
        }
    }
    
    return result;
}

- (instancetype)rs_compact {
    id result = [NSMutableArray arrayWithCapacity:self.count];
    
    for (id item in self) {
        if (![item isEqual:[NSNull null]]) [result addObject:item];
    }
    
    return result;
}

- (instancetype)rs_delete:(id)object {
    if (![self containsObject:object]) return self;
    
    id result = [NSMutableArray arrayWithArray:self];
    [result removeObject:object];
    
    return result;
}

- (instancetype)rs_deleteAt:(NSInteger)index {
    if (index >= (NSInteger)[self count]) return self;
    
    id result = [NSMutableArray arrayWithArray:self];
    if (index < 0) index = self.count + index;
    [result removeObjectAtIndex:index];
    
    return result;
}

- (id)rs_deleteIf:(BOOL (^)(id))block {
    if (!block) return [self objectEnumerator];
    
    id result = [NSMutableArray array];
    for (id item in self) {
        if (!block(item)) [result addObject:item];
    }
    
    return result;
}

- (instancetype)rs_drop:(NSInteger)count {
    if (count < 0) @throw [NSException exceptionWithName:NSInvalidArgumentException
                                                  reason:NSInvalidArgumentException
                                                userInfo:nil];
    
    if (count >= (NSInteger)self.count) return [NSArray array];
    
    NSRange range = NSMakeRange(count, [self count] - count);
    return [self subarrayWithRange:range];
}

- (id)rs_dropWhile:(BOOL(^)(id item))block {
    if (!block) return [self objectEnumerator];
    
    NSInteger count = 0;
    for (id item in self) {
        if (block(item)) count++;
        else break;
    }
    
    return [self rs_drop:count];
}

- (void)rs_each:(void (^)(id item))block {
    [self mk_each:block];
}

- (id)rs_fetch:(NSUInteger)index {
    return [self objectAtIndex:index];
}

- (instancetype)rs_fill:(id)object {
    return [self rs_fill:object withRange:NSMakeRange(0, self.count)];
}

- (instancetype)rs_fill:(id)object withRange:(NSRange)range {
    if (!object) object = [NSNull null];
    
    id result = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ((idx >= range.location) && (idx < range.location + range.length)) {
            [result addObject:object];
        } else {
            [result addObject:obj];
        }
    }];
    
    return result;
}

- (instancetype)rs_flatten {
    return [self rs_flatten:-1];
}

- (instancetype)rs_flatten:(NSInteger)level {
    id result = [NSMutableArray array];
    
    for (id item in self) {
        if (level == 0) [result addObject:item];
        else if (![item isKindOfClass:[NSArray class]]) [result addObject:item];
        else [result addObjectsFromArray:[item rs_flatten:(level - 1)]];
    }
    
    return result;
}

- (BOOL)rs_includes:(id)object {
    return [self containsObject:object];
}

- (id)rs_inject:(id (^)(id accumulator, id item))block {
    return [self rs_inject:nil withBlock:block];
}

- (id)rs_inject:(id)initial withBlock:(id (^)(id accumulator, id item))block {
    if (!block) return initial;
    
    __block id result = initial;
    
    [self rs_each:^(id element) {
        result = result ? block(result, element) : element;
    }];
    
    return result;
}

- (BOOL)rs_isEmpty {
    return ([self count] == 0);
}

- (NSString *)rs_join {
    return [self rs_join:nil];
}

- (NSString *)rs_join:(NSString *)separator {
    if (!separator) separator = @"";
    
    __block id result = nil;
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx == 0) result = [obj description];
        else result = [NSString stringWithFormat:@"%@%@%@", result, separator, obj];
    }];
    return result;
}

- (instancetype)rs_map:(id (^)(id item))block {
    return [self mk_map:block];
}

- (instancetype)rs_reverse {
    return [[self reverseObjectEnumerator] allObjects];
}

- (id)rs_sample {
    if ([self rs_isEmpty]) return nil;
    assert([self count] <= (uint32_t) - 1);
    return self[arc4random_uniform((uint32_t)[self count])];
}

- (instancetype)rs_sample:(NSUInteger)count {
    if ([self rs_isEmpty]) return self;
    assert([self count] <= (uint32_t) - 1);
    
    if (count > self.count) count = self.count; // R: return shuffled
    
    id indices = [NSMutableIndexSet indexSet];
    while (YES) {
        NSInteger index = arc4random_uniform((uint32_t)[self count]);
        [indices addIndex:index];
        if ([indices count] == count) break;
    }

    id result = [NSMutableArray arrayWithCapacity:[indices count]];
    [indices enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        [result addObject:self[idx]];
    }];

    return result;
}

- (instancetype)rs_select:(BOOL (^)(id item))block {
    return [self mk_select:block];
}

- (instancetype)rs_shuffle {
    assert([self count] <= (uint32_t) - 1);
    NSUInteger index =  arc4random_uniform((uint32_t)[self count]);
    return [self rs_permutation][index];
}

- (instancetype)rs_permutation {
    return [self rs_permutation:self.count];
}

- (instancetype)rs_permutation:(NSInteger)n {
    if (n == 1) return [self rs_zip];

    id result = [NSMutableArray array];
    for (int idx = 0; idx < self.count; idx++) {
        id element = self[idx];
        id temp = [[self copy] rs_deleteAt:idx];
        for (id array in [temp rs_permutation:n - 1]) {
            [result addObject:[array : element]];
        }
    }
    
    return result;
}

- (instancetype)rs_reject:(BOOL (^)(id item))block {
    return [self mk_reject:block];
}

- (instancetype)rs_zip {
    id result = [NSMutableArray array];
    [self mk_each:^(id item) {
        [result addObject:@[item]];
    }];
    return result;
}

- (instancetype)rs_take:(NSInteger)count {
    if (count < 0) @throw [NSException exceptionWithName:NSInvalidArgumentException
                                                  reason:NSInvalidArgumentException
                                                userInfo:nil];
    
    if (count > (NSInteger)self.count) return self;
    
    NSInteger length = (count > self.count) ? self.count : count;
    return [self subarrayWithRange:NSMakeRange(0, length)];
}

- (id)rs_takeWhile:(BOOL(^)(id item))block {
    if (!block) return [self objectEnumerator];
    
    NSInteger count = 0;
    for (id item in self) {
        if (block(item)) count++;
        else break;
    }
    
    return [self rs_take:count];
}

- (instancetype)rs_uniq {
    return [self rs_uniq:nil];
}

- (instancetype)rs_uniq:(id(^)(id item))block {
    id result = [NSMutableArray array];
    
    for (id item in self) {
        if (!block) {
            if (![result containsObject:item]) [result addObject:item];
        }
        else {
            if (![result mk_any:^BOOL(id obj) {
                return [block(obj) isEqual:block(item)];
            }]) {
                [result addObject:item];
            }
        }
    }
    
    return result;
}

- (id)objectForKeyedSubscript:(id<NSCopying>)key {
    static NSString *inclusiveRange = @"..";
    static NSString *exclusiveRange = @"...";
    
    if ([(id)key isKindOfClass:[NSString class]]) {
        
        NSRange range = NSRangeFromString((NSString *)key);
        if ([(NSString *)key rs_containsString:exclusiveRange]) {
            range = NSMakeRange(range.location + 1, range.length - range.location - 1);
        } else if ([(NSString *)key rs_containsString:inclusiveRange]) {
            range = NSMakeRange(range.location, range.length - range.location + 1);
        }
        
        return [self subarrayWithRange:range];
    } if ([(id)key isKindOfClass:[NSValue class]]) {
        
        NSRange range = [(NSValue *)key rangeValue];
        range.length = 1;
        return [self subarrayWithRange:range];
        
    } else @throw [NSException exceptionWithName:NSInvalidArgumentException
                                          reason:NSInvalidArgumentException
                                        userInfo:nil];
}

@end
