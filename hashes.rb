=begin
Hashes have a different storage format and way to define each object within the collection
than Arrays. Rather than having an assigned position in a list, objects within a hash are
given a key that points to them. It’s more like a dictionary than a list, as there’s no
guaranteed order, but just simple links between keys and values.

Just like with arrays, you can declare hashes a number of ways
=end

hash = Hash.new                         # => {}
hash = Hash.new(0)                      # => {} default value of 0. If an element not in the hash is accessed, 0 returns
hash = Hash["a" => 100, "b" => 200]     # => { "a" => 100, "b" => 200 }

months = { "1" => "January",            # => { "1" => "January", "2" => "February", "3" => "March" }
           "2" => "February",
           "3" => "March" }

=begin
The hash rocket (=>) is the 'old pre ruby 1.9' syntax for defining a key => value pair. The new syntax is a JSON-like
format where all of the keys are symbols. Either format is acceptible; however, the hash rocket must be used if
an object is being used as the key.
=end

# Creating months with the new syntax. Note that this syntax will not work if you want the key to be an Integer.
months = { 1: 'January',                # => { :1 => 'January', :2 => 'February', :3 => 'March' }
           2: 'February',
           3: 'March' }

# Hashes can be created using blocks
hash = {}
(1..5).each { |i| hash[i] = i.to_s }   # => { 1 => "1", 2 => "2", 3 => "3", 4 => "4", 5 => "5" }

# You can also pass the initial object (empty hash) into the loop with each_with_object. H refers to the passed in hash.
hash = (1..5).each_with_object({}) { |i, h| h[i] = i.to_s } # => { 1 => "1", 2 => "2", 3 => "3", 4 => "4", 5 => "5" }

# Accessing data within a Hash is done by supplying the key or value
months[1]              # => "January" returns the value matching the key
months.key('January')  # => 1 returns the key matching the value

# All of the keys or values in our hash can be displayed
months.keys              # => [:1, :2, :3] array of all keys is returned
months.values            # => ['January', 'February', 'March'] an array of all values is returned

# You can check if a key exists in a hash
months.include?(1)       # => true
months.has_key?(2)       # => true

# You can check if a value exists in a hash
months.value?('January')     # => true
months.has_value?('January') # =? true

# You can check if a hash is empty. That is, it has no matching key value pairs
months.empty?            # => false

# Similarly, you can determine how many key value pairs there are
months.size              # => 3

=begin
Since Hashes are constructed with key value pairs, the order does not matter. Thus, there is no
pushing and popping like arrays, which makes adding and removing values from a Hash much more simple.
=end

months[4] = 'April'     # => { 1 => 'January', 2 => 'February', 3 => 'March', 4 => 'April' }
months.store(5, 'May')  # => { 1 => 'January', 2 => 'February', 3 => 'March', 4 => 'April' 5 => 'May' }

months.delete(5)        # => { 1 => 'January', 2 => 'February', 3 => 'March', 4 => 'April' } deleted value is returned

# Deleting can bedone conditionally as well
months.delete_if { |key, value| key > 2 } # => { 1 => 'January', 2 => 'February' }

# Deleting can be done opposite delete_if. Delete every key value pair for which block evaluates to false.
months.keep_if { |key, value| value == 'January' } # => { 1 => 'January' }

hash.clear # => {} empties the entire Hash

=begin
Just like Arrays, you can iterate over Hashes with many of the same methods. The biggest difference between calling the
methods on Hashes is that two values are passed to the block instead of one: the key and the value
=end

hash = { "a" => 1, "b" => 2, "c" => 3, "d" => 4, "e" => 5, "f" => 6 }

hash.each { |key, value| puts "#{key} equals #{value}" } # a basic iteration that outputs the key its corresponding value
hash.each_key { |key| puts "#{key}" }       # iterate over only the keys in the Hash
hash.each_value { |value| puts "#{value}" } # iterate over only the values in the Hash

# Returns a new hash consisting of entries for which the block returns false
hash.reject { |key, value| k < "e" }        # => { "a" => 1, "b" => 2, "c" => 3, "d" => 4 }

# We can invert a Hash to switch keys and values
hash.invert # => { "d" => 4, "c" => 3, "b" => 2, "a" => 1 } returns an inverted array. Doesn't change the original array

=begin
Merging hashes can be a complex process depending on how the data is structured. Several examples are included below
to show how it can be done.

The merge function returns a new hash containing the contents of hash a and b. If there are duplicate keys and no block is specified,
the value for entries with duplicate keys will be that of b. If there is a block specified, the value of the duplicate is defined in the block.
=end

h1 = { "a" => 100, "b" => 200 }
h2 = { "b" => 254, "c" => 300 }

h1.merge(h2)  # => { "a" => 100, "b" => 254, "c" => 300 } since b is a duplicate, the value of h2 is used
h2.merge(h1)  # => { "a" => 100, "b" => 200, "c" => 300 } since b is a duplicate, the value of h1 is used
h1.merge(h2) {|key, h1_val, h2_val| h1_val + h2_val } # => { "a" => 100, "b" => 454, "c" => 300 }


a = {:car => {:color => "red"}}
b = {:car => {:speed => "100mph"}}

# key == car, a_val == {:color => "red"} b_val == {:speed => "100mph"}
a.merge(b) {|key, a_val, b_val| a_val.merge b_val } # => {:car=>{:color=>"red", :speed=>"100mph"}}

# A recursive merge method can be defined to merge nested hashes
def merge_recursively(a, b)
  a.merge(b) {|key, a_item, b_item| merge_recursively(a_item, b_item) }
end

merge_recursively(a, b) # =>  {:car=>{:color=>"red", :speed=>"100mph"}}

# A hash can be converted into a nested array of [key, value]
h2.to_a # => [["b", 254], ["c", 300"]]
