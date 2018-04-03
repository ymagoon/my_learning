=begin
There are two main ways to create an array in Ruby. The first is by an array literal.
That is, setting a variable to []. The array can be left empty or populated when it is
instantiated. The second way is by using the Array class.
=end

array = []        # array literal
array = Array.new # array object


#Both of the above methods will create an empty array []. Array.new supports paramaters as well as passing in blocks.

array = Array.new(3) => [nil, nil, nil]        # passing in 3 creates an array with 3 indicies of nil value
array = Array.new(3, "-") => ["-", "-", "-"]   # passing in 3 and "-" creats an array with "-" repeated 3 times
array = Array.new(3){ |i| (i+1).to_s }         # passing in a block applies the block to each element of the array

#Arrays literals can be populated like this. The following shows two examples using strings and numbers

array = ["this", "is", "the", "long", "method", "to", "create", "an", "array"] # strings
array = [1,2,3,4,5] #integers
# There is a shorthand for creating an array of strings by using the %w formatter %w[], %w(), %w{} (same thing)
array = %w[this is a way to create an array using space delimiters] # => ["1", "2", "3"] arrays with whitespace delimited

# You can also use ranges to create a range of strings or integers in an array
array = ('1'..'5').to_a # => ['1','2','3','4','5']
array = (1..5).to_a  # => [1, 2, 3, 4, 5]

=begin
Accessing data from arrays can be done in a variety of ways. You can access with a value associated with the index
you cant to access. You can also access a substring of values by supplying a range.

The last index of an array can be accessed using the index -1.
=end

array[0] # accessing the first element of an array

array[2..3] # => [3, 4] returns an array starting at position 2 ending at position 3 Inclusive
array[2...4] # => [3, 4] returns an array starting at position 2 ending at position 4 Exclusive

array[2..-2] # => [3, 4] returns an array ending at the second to last position (-1 is the last position)

# Another syntax to the ranges above is using the slice method
array.slice(0)     # => 1
array.slice(0..2)  # => [1, 2, 3]
array.slice(1..-2) # => [2, 3, 4]

# By using the index method, we can return the index where the first occurence of a value exists
array.index(3) # => 2 the value of 3 is located at index 2
array.index { |x| x == num * 2 } # => 3 if num == 2, passing in a block finds the index where x == 4

# There are two methods you can call on an array without supplying a position
array.first # => 0
array.last # => 5

# If you try an access an element that does not exist, it will not work
array[10] # => nil

# If the position doesn't exist, you can contol what is returned by using fetch
array.fetch(10,"that index does not exist") # => "that index does not exist"

# There are two more methods that do not require identifying positions to return values
array.take(3) # => [1, 2, 3] returns the first 3 values
array.drop(2) # => [3, 4, 5] returns an array without the first two elements

=begin
Arrays have certain methods that define an array. You can find the length/size of an array,
and you can determine whether an array contains a value.

length is a method that’s not part of Enumerable – it’s part of a concrete class (like String or Array)
and it runs very fast.

size is an alias, which does the same thing. Use length for strings, since objects like arrays, hashes, stacks etc
don't really have a length. Use sizefor these collections.
Whether you should use length or size is mostly a matter of personal preference.

count, on the other hand, is a totally different beast. It’s usually meant to be used with a block or an argument
and will return the number of matches in an Enumerable: There’s a performance implication with this, though – to calculate
the size of the enumerable the count method will traverse it, which is not particularly fast (especially for huge collections)
=end

array.size # => 5
array.count # => 5
arr.count(&:even?) # counts even elements

array.empty? # an array is empty [] if there are no values in it
array.include?(5) # => true

=begin
Arrays can be modified in many different ways. They can be added, subtracted, multiplied,
values can be added, subtracted, inserted and an array can actually be cleared. Here's a sample
of all of the ways an array can be modified.

<shift/unshift>[ 1  2  3  4  5]<push/pop>

Four methods (shown above) are used to add and remove elements from an array from the beginning or end
=end

array.push(6)    # => [1, 2, 3, 4, 5, 6] adds an element to the end of the array
array << 7       # => [1, 2, 3, 4, 5, 6, 7] you can also use the shovel operator to add elements
array << 8 << 9  # => [1, 2, 3, 4, 5, 6, 7, 8, 9] elements can be shoveled several at a time

array.unshift(0) # => [0, 1, 2, 3, 4, 5, 6, 7, 8, 9] adds elements to the beginning
array.pop        # => [0, 1, 2, 3, 4, 5, 6, 7, 8] removes the last element
array.shift      # => [1, 2, 3, 4, 5, 6, 7, 8] removes the first element

array << array.pop + array.pop # => [1, 2, 3, 4, 5, 6, 15] the shovel operator can accept multiple parameters

=begin
Using pushing/popping we can create a stack or a queue data structure using arrays.
LIFO (last in first out) pushes items onto the stack, then removes then
array.push(value)
array.push(value)
array.pop

FILO (first in last out) pushes items into a queue and removes them
array.push(value)
array.push(value)
array.shift
=end

# In addition to using shift and pop to remove elements from the ends of an array, you can use
#delete and delete_at to remove from within the array

new_arr.delete_at(2) # => 3 leaving array = [1, 2, 4, 5, 6, 15] returns value deleted

array << 2 # => [1, 2, 4, 5, 6, 15, 2]
array.delete(2) # => 2 leaving array = [1, 4, 5, 6, 15] returns value deleted or nil. Removes all instances of value.

# if an array contains duplicate values then the #uniq method can be used to remove any element after the first
array << 4 # => [1, 4, 5, 6, 15, 4]
array.uniq # => [1, 4, 5, 6, 15] the original array is not modified. The uniq method returns a unique array.

# different operators can be applied to two arrays to return a combination of them
[1,1,3,5] & [3,2,1] # => [1, 3] returns an array containing unique elements common to the two arrays
[1,1,3,5] - [3,2,1] # => [5] returns an array containing elements in the first array that don't exist in the second
[3,2,1] - [1,1,3,5] # => [2]

[1,2,3] + [4,5,6,7] # => [1, 2, 3, 4, 5, 6, 7] concatenates an array, keeping the order
[1,2,3] * 2         # =? [1, 2, 3, 1, 2, 3] repeats the array n number of times where n = 2 in this example

# arrays can be shuffled into a random order
array.shuffle # => [4, 5, 1, 15, 6] returns a randomly shuffled array. It does not modify the original array

=begin
Sorting is a very complex topic, so it will be included here in brevity. Advanced sorting methods will be
covered in their own sections. For the array class you can use the sort method to sort arrays. The sort
method can accept a block which allows you to customize how the array is sorted.

The block must implement a comparison between two values (a, b).
When -1 is returned a < b, 0 is returned a == b, and when 1 is returned b > a
=end

array.sort                    # => [1, 4, 5, 6, 15] returns a sorted array. Does not alter the original array.
array.sort { |x,y| y <=> x }  #=> [15, 6, 5, 4, 1]

# Arrays can be joined together into a string
array.join(' ') # => "15 6 5 4 1"

# If you need a random sampling of data, you can chose a value from an array with equal probability
array.sample # => 5

=begin
Accessing all of the elements of an array can be done by traversing the array. There are a variety of
methods that allow us to traverse arrays that each have a different function.
=end

array.each { |i| puts i } # prints each element in the array. Anything can be supplied in the block

array.each do |i| # the same as above, except the block is formatted differently
  puts i
end

array.reverse_each { |i| puts i } # accesses an array in reverse

array.select { |i| i.even? }       # => [6, 4] returns an array that meets the condition in the block
array.map { |i| i * 2 }            # => [30, 12, 10, 8, 2] returns a new array with the block applied to each value
array.reject { |i| i < 5 }         # => [15, 6, 5] reject values that do not qualify for a condition

# The reduce function (alias is inject) passes the object back through each iteration. This is used to
# reduce an array to a single value
array.reduce { |sum, i| sum += i } # => 26 through each iteration, the sum is passed into the block
array.reduce(:+)                   # => 26 shorthand approach calling the #+ method
