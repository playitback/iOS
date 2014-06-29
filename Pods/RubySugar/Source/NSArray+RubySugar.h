//
//  NSArray+RubySugar.h
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

#import <Foundation/Foundation.h>

@interface NSArray (RubySugar)

/**
 Returns new array by concatenating array with input object.
 Every object that responds to description selector is appended.
 */
- (instancetype):(id)object;

/**
 Returns self[@"<from>..<to>"]
 */
- (instancetype):(NSInteger)from :(NSInteger)to;

/**
 Returns self[@"<from>..<to>"] or self[@"<from>...<to>"] if exclusive.
 */
- (instancetype):(NSInteger)from :(NSInteger)to exclusive:(BOOL)exclusive;

/**
 Returns an empty array.
 */
- (instancetype)rs_clear;

/**
 Returns array that yields all combinations of n elements.
 */
- (instancetype)rs_combination:(NSInteger)n;

/**
 Returns a copy of self with all nil elements removed.
 */
- (instancetype)rs_compact;

/**
 Returns array without all items that are equal to object.
 */
- (instancetype)rs_delete:(id)object;

/**
 Returns array without the element at index.
 If index is negative, removes from back.
 */
- (instancetype)rs_deleteAt:(NSInteger)index;

/**
 Returns array without elements for which block evaluates true.
 If no block is given, it returns enumerator.
 */
- (id)rs_deleteIf:(BOOL(^)(id item))block;

/**
 Drops first n elements from ary and returns the rest of the elements in an array.
 If a negative number is given, raises an ArgumentError.
 */
- (instancetype)rs_drop:(NSInteger)count;

/**
 Drops elements up to, but not including, the first element for which the block 
 returns nil or false and returns an array containing the remaining elements.
 If no block is given, an Enumerator is returned instead.
 */
- (id)rs_dropWhile:(BOOL(^)(id item))block;

/**
 Calls the given block once for each element in self, passing that element as a parameter
 */
- (void)rs_each:(void (^)(id item))block;

/**
 Mirror: [self objectAtIndex:index];
 */
- (id)rs_fetch:(NSUInteger)index;

/**
 Returns a new array filled with ojbect for all elements.
 */
- (instancetype)rs_fill:(id)object;

/**
 Returns a new array filled with ojbect for selected elements.
 */
- (instancetype)rs_fill:(id)object withRange:(NSRange)range;

/**
 Returns a new array that is a one-dimensional flattening of self (recursively).
 That is, for every element that is an array, extract its elements into the new array.
 */
- (instancetype)rs_flatten;

/**
 Returns a new array that is a one-dimensional flattening of self (recursively).
 That is, for every element that is an array, extract its elements into the new array.
 The optional level argument determines the level of recursion to flatten.
 */
- (instancetype)rs_flatten:(NSInteger)level;

/**
 Mirror: [self containsObject:object];
 */
- (BOOL)rs_includes:(id)object;

/**
 Combines all elements of enum by applying a binary operation
 */
- (id)rs_inject:(id (^)(id accumulator, id item))block;
- (id)rs_inject:(id)initial withBlock:(id (^)(id accumulator, id item))block;

/**
 Shorthand ([self count] == 0)
 */
- (BOOL)rs_isEmpty;

/**
 Shorthand [rs_join:nil]
 */
- (NSString *)rs_join;

/**
 Returns a string created by converting each element of the array to a string, 
 separated by the given separator. If the separator is nil, it uses empty string.
 */
- (NSString *)rs_join:(NSString *)separator;

/**
 Returns an array of elements returned by the given block.
 */
- (instancetype)rs_map:(id (^)(id item))block;

/**
 Returns array that yields all permutations of all elements.
 */
- (instancetype)rs_permutation;

/**
 Returns array that yields all permutations of n elements.
 */
- (instancetype)rs_permutation:(NSInteger)n;

/**
 Returns a new array containing all elements for which the given block returns a false.
 */
- (instancetype)rs_reject:(BOOL (^)(id item))block;

/**
 Returns a new array containing self‘s elements in reverse order.
 */
- (instancetype)rs_reverse;

/**
 Returns a random element from the array or nil in case array is empty.
 */
- (id)rs_sample;

/**
 Returns an array of n random element from the array.
 */
- (instancetype)rs_sample:(NSUInteger)count;

/**
 Returns a new array containing all elements for which the given block returns a true.
 */
- (instancetype)rs_select:(BOOL (^)(id item))block;

/**
 Returns a new array with elements of self shuffled.
 */
- (instancetype)rs_shuffle;

/**
 Returns first n elements from the array.
 If a negative number is given, raises an ArgumentError.
 */
- (instancetype)rs_take:(NSInteger)count;

/**
 Passes elements to the block until the block returns nil or false, 
 then stops iterating and returns an array of all prior elements.
 
 If no block is given, an Enumerator is returned instead.
 */
- (id)rs_takeWhile:(BOOL(^)(id item))block;

/**
 Returns a new array by removing duplicate values in self.
 If a block is given, it will use the return value of the block for comparison.
 */
- (instancetype)rs_uniq;

/**
 Returns a new array by removing duplicate values in self.
 If a block is given, it will use the return value of the block for comparison.
 */
- (instancetype)rs_uniq:(id(^)(id item))block;

/**
 Returns an array of elements converted into array.
 */
- (instancetype)rs_zip;

- (id)objectForKeyedSubscript:(id<NSCopying>)key;

@end
