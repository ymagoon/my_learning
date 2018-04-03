=begin
  There are many ways to iterate over data structures and perform certain functions.
  There are different iterators depending on thedata structure.
=end

# Numeric iterators for Integers
5.times { |i| print "#{n} " }              # => 0 1 2 3 4
1.upto(5) { |i| print "#{n} " }            # => 1 2 3 4 5
5.downto(1) { |i| print "#{n} " }          # => 5 4 3 2 1
0.step(20, 5) { |i| print "#{n} " }        # => 0 5 10 15 20 25 # go from 0 to 20 in steps of 5

# Notice how calling each and reverse_each on the range (1..5) display the same values as upto/downto
(1..5).each { |n| print "#{n} " }          # => 1 2 3 4 5
(1..5).reverse_each { |n| print "#{n} " }  # => 5 4 3 2 1

s = "What is \nthe sound \nof silence?"    # Notice the line breaks (\n)

s.each_char { |chr| print "#{chr} " }      # W h a t   i s
                                           #  t h e   s o u n d
                                           #  o f   s i l e n c e ?

s.each_line { |line| puts line }           # What is
                                           # the sound
                                           # of silence?

# We can iterate through the alphabet using a range
('a'..'e').each { |chr| print "#{chr} "}   # a b c d e

# The each_char and each_line have a method called .with_index that can provide the index of the current iteration
"str".each_char.with_index { |chr, index| print "#{chr} #{index} "} # => "s 0", "t 1", "r 2"

# Array iterators
=begin
  The iterator methods covered in this section are defined within the Array class.
  The Enumerable module, which is explained further below, provides dozens of other
  iterator methods which can also be used on arrays.
=end

ary = [1, 2, 3, 4, 5]
ary.each { |i| puts i }           # => 1, 2, 3, 4, 5
ary.each_index { |index| puts i } # => 0, 1, 2, 3, 4 returns the index at each iteration

# Hash iterators
h = { "car": "porche", "color": 'red', "max_speed": 100 }

h.each { |key, index| puts "#{key}: #{value}"} # => "car: porche", "color: red", "max_speed: 100"
h.each_key { |key| puts key }                  # => car, color, max_speed
h.each_value { |value| puts value }            # => porche, color, max_speed


=begin
  Most iterator methods rely on the each method under the hood. Hence, it is useful to learn how it works.
  When the each method is called and no block is provided, it returns an enumerator object,
  which is an instance of the Enumerator class.
=end

enum = ary.each                    # => #<Enumerator: [1, 2, 3, 4, 5]:each>

# If we look at the instance methods of the Enumerator class

Enumerator.instance_methods(false) # false ensures we only see those defined in Enumerator, not those inherited

=begin
  [:inspect, :size, :each, :each_with_index, :each_with_object, :next, :rewind, :with_index,
  :with_object, :next_values, :peek_values, :peek, :feed]
=end

# Let's test some
enum.size         # => 5 return the number of items in the enumerator
enum.next         # => 1 return the next item and move the internal position forward
enum.next         # => 2
enum.peek         # => 3 return the next item without moving the internal position
enum.next         # => 3

enum.rewind       # => set the internal position to the first item
enum.next         # => 1

#The Enumerable module
=begin
  In Ruby, almost everything is an object, a couple of relevant exceptions are methods and blocks.
  An object is an instance of a class. Hence, all arrays are instances of the Array class; hashes
  are instances of the Hash class and so on.

  Collection classes such as Array, Hash, and Range provide the each method (explained above),
  which yields the values in the collection, one by one. There is a built-in module called Enumerable,
  which is used as a mixin by collection classes. It provides multiple methods for working with collections.
  Every time we create an array or a hash, the methods provided by the Enumerable module are available.
  These additional methods rely on the each iterator implemented in the corresponding collection class.
=end

# We can easily confirm that the most popular collection classes use the Enumerable mixin:
Array.included_modules # => [Enumerable, Kernel]
Hash.included_modules  # => [Enumerable, Kernel]
Range.included_modules # => [Enumerable, Kernel]

Enumerable.instance_methods(false).sort # false ensures we only see those defined in Enumeraable, not those inherited
=begin
  => [:all?, :any?, :chunk, :chunk_while, :collect, :collect_concat, :count, :cycle, :detect, :drop, :drop_while,
  :each_cons, :each_entry, :each_slice, :each_with_index, :each_with_object, :entries, :find, :find_all,
  :find_index, :first, :flat_map, :grep, :grep_v, :group_by, :include?, :inject, :lazy, :map, :max, :max_by,
  :member?, :min, :min_by, :minmax, :minmax_by, :none?, :one?, :partition, :reduce, :reject, :reverse_each,
  :select, :slice_after, :slice_before, :slice_when, :sort, :sort_by, :take, :take_while, :to_a, :to_h, :zip]
=end

# Methods provided with the Enumerable object. These are shown with arrays for simplicity, but work on Hashes and Ranges as well.
names = ['John', 'Greg', 'Avery']

# Loop through indexes and values
names.each_with_index { |name, index| puts "#{index} #{name}"} # => "0 John", "1 Greg", "2 Avery"

# Loop through items and modify them
names.map { |name| name.upcase } # => "JOHN", "GREG", "AVERY"

# We can also pass a method reference (as a symbol) to the map method, instead of a block.
names.map(&:upcase)              # => "JOHN", "GREG", "AVERY"

# map! will alter the collections in place instead of returning an array.  In other words, it passes each collection item
# to the block and replaces its original value with the value returned by the block.

# The collect and collect! methods are aliases to map and map!, so they can be used interchangeably. Let's verify:
Array.instance_method(:map)  == Array.instance_method(:collect)   # => true
Array.instance_method(:map!) == Array.instance_method(:collect!)  # => true

# Test if all items meet specific criteria
[2, 4, 6].all? { |n| n.even? }                  # => true
[1, 2, nil, 5].all?                             # => false If no block is specified looks at 'falsyness' nil is 'falsy'

# Find any item that meets a specific criteria
[2, 4, 6, 9].any? { |n| n.odd? }  # => true
[nil, false, "foo"].any?                        # => true If no block is specified looks at 'truthyness' 'foo' is true

# Test all items do not meet spefific criteria
[2, 4, 6, 8].none? { |n| n < 10 }               # => true
[false, false, nil, false].none? { |n| n < 10 } # => true returns true if all values in the collection are falsey (false or nil).

# Count items
a = [ "foo", "bar", "baz", "foo" ]
a.count("foo")                                  # => 2
[2, 5, 6, 9, 10].count { |i| i.even? }          # => 3

=begin
  What about counting occurences in a collection?  In other words, to generate a list of unique values and count the occurrences
  of each value in the collection? For more info http://carol-nichols.com/2015/08/07/ruby-occurrence-couting/
=end

arr = [ "foo", "bar", "baz", "foo", "foo", "baz" ]

# 1. Best for performance
Hash[arr.group_by(&:itself).map {|key, value| [key, value.size] }]  # => {"foo"=>3, "bar"=>1, "baz"=>2}

=begin
  arr.group_by(&:itself)                             # => {"foo"=>["foo", "foo", "foo"], "bar"=>["bar"], "baz"=>["baz", "baz"]}
  {<shortened>}.map { |key,value [key,value.size] }  # => [["foo", 3], ["bar", 1], ["baz", 2]]
  Hash[[["foo", 3], ["bar", 1], ["baz", 2]]]         # => {"foo"=>3, "bar"=>1, "baz"=>2}
=end

# 2. A little easier to read, basically the same performance
arr.each_with_object(Hash.new(0)) { |word, counts| counts[word] += 1 }

# These methods return a new collection containing only the selected items. None of them will modify the original collection.

# Return the items for which the block returned true
[1, 2, 3, 4, 5, 6, 8, 9].select { |n| n > 3 }        # => [4, 5, 6, 8, 9]

=begin
  The difference between the find_all and the select methods is that find_all will always return an array,
  regardless of the type of object it was called on. That can be demonstrated by calling both methods on a hash:
=end

h = { a: 1, b: 2, c: 3 }

h.find_all { true }                                 # => [[:a, 1], [:b, 2], [:c, 3]]
h.select { true }                                   # => {:a=>1, :b=>2, :c=>3}

# The inverse of select is reject. It returns items for which the block returns false
[1, 2, 3, 4, 5, 6, 8, 9].reject { |n| n > 3 }       # => [1, 2, 3]

# Return a new collection containing the items whose values match the given expression using ===
a = [ "foo", 3, "bar", 7, "baz", 10, "qux" ]
a.grep(/ba/)                                        # => ["bar", "baz"] is equivalent to: a.select { |x| /ba/ === x }

a = [ "foo", 3, "bar", 7, "baz", 10, "qux" ]
a.grep(1..8)                                        # => [3, 7]
a.grep(Integer)                                     # => [3, 7, 10]
a.grep(String)                                      # => ["foo", "bar", "baz", "qux"]

# grep may also take a block. It yields each matching item to the block and a new array containing the block's output is returned.
# That is useful for applying operations only to items whose values match the regex.
a.grep(/ba/) { |x| x.upcase }                       # => ["BAR", "BAZ"] is equivalent to a.select { |x| /ba/ === x }.map { |x| x.upcase }

# Reverse grep. Returns a new array containing the items that do not match the pattern.
[ "foo", "bar", "baz", "qux" ].grep_v(/ba/)         # => ["foo", "qux"]

# The drop_while and take_while methods are similar to reject and select,
# except they will stop looking once the first item that meets the specified criteria is reached.
arr = [1, 2, 3, 4, 5, 6, 1, 2, 3, 8]
arr.take_while { |a| a < 4 }                        # => [1, 2, 3]

# Returns the first value for which the expression within the block is true
[1, 3, 6, 8, 10].find { |n| n > 5 }                 # => 6

# The detect method is the same as find
Array.instance_method(:detect) == Array.instance_method(:find)  # => true

# Returns the index of the first value for which the expression within the block is true
["foo", "foo", "bar", "baz"].find_index { |x| x.include? "ba" } # => 2

# Returning first(n) collection items
a = [ "foo", "bar", "baz" ]
a.first                                             # => "foo"
a.first(2)                                          # => ["foo", "bar"]

# Enumerable has no method to find the last value of a collection. Array and Range provide a method that do this
[ "foo", "bar", "baz" ].last                        # => "baz"
(1..8).last                                         # => 8

# The Hash class does not provide such method, however, we can convert the hash keys, values or both into an array
# and use the last method from the Array class:
h = { "a": 1, "b": 2, "c": 3 }
h.values.last                                       # => 3
h.keys.last                                         # => :c
h.to_a.last                                         # => [:c, 3]

# Apply a binary operation (such as sum or division) to each collection item and store the new value in an accumulator
# variable. In other words, reduce a collection to a single value.
[2, 3, 5].reduce { |sum, n| sum + n }               # => 10

# We can pass in a shorthand, just like with map
[ 2, 3, 5 ].reduce(:+)                              # => 10
[ 2, 3, 5 ].reduce(:*)                              # => 30

# The inject method is an alias to reduce
Array.instance_method(:reduce) == Array.instance_method(:inject)  # Output: => true

# Sort collection items. Numbers are sorted in ascending order and strings in alphabetical order
# Uppercase strings come before lowercase strings.
[ "foo", "Foo", "Bar", "bar", "qux", "Qux" ].sort   # => ["Bar", "Foo", "Qux", "bar", "foo", "qux"]

# Sorting by a number returned by a block. Any logic in the block is fine as long as it returns a number
["liberation", "zen", "zazen"].sort_by { |word| word.length}

# Loop through two arrays at once
a = [1, 3, 5]
b = [9, 5, 1]
c = a.zip(b).each { | x, y | puts "#{x} - #{y}" } # => [[1, 9], [3, 5], [5, 1]] returns array of each first, second and third elements
# the actual output is
# 1 - 9
# 3 - 5
# 5 - 1

# Other alternative loops, generally frowned upon

# Rubysts never use for loops, so don't use them
for i in 1..50          # => 7, 14, 21, 28, 35, 42, 49
   puts i if i % 7==0
end

# While loops execute code while a condition is true
i = 0
while (i < ary.size)    # => 1, 2, 3, 4, 5
 puts "#{ary[i]}"
 i += 1
end

# Until loops execute code while a condition is false
i = 0
until (i > ary.size)    # => 1, 2, 3, 4, 5
 puts "#{ary[i]}"
 i += 1
end

# Loop without knowing how many of iterations to perform. Synonymous to while (true)
my_iterator = (1..9).each
loop do
  puts my_iterator.next
end
