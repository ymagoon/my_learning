
#arrays summary:
#there are two ways to create an array
long_way = Array.new
short_way = []

#setting values to the arrays is simple
long_way = ["this", "is", "the", "long", "method", "to", "create", "an", "array"]
short_way = [1,2,3,4,5]

#accessing arrays can be done based on the index, which starts with 0
#puts short_way[0]

#a range of values from an array can also be returned.
#two dots (..) is inclusive of the last value, and three dots (...) is exclusive

#puts short_way[2..4]
#puts short_way[2...4]

#you can also use a negative number (-1,-2, etc) where -1 is the last element
#of an array, -2 is the second to last number, etc.
#puts short_way[0..-2]

#if you want to access all the elements of an array, instead of using a for/while
#loop, you can use an iterator

#long_way.each do |long_way|
#  puts "I like #{long_way}"
#end

# << is called the shovel operator. Essentially the same as Array.push
fruits = []
fruits << "apple"
fruits << "cranberry"

#puts fruits

#arrays can be concatenated
#puts long_way + short_way

#there are two ways to get an array's size
#puts [1,2,3].count
#puts [1,2,3].length
#returns 3
#puts [].empty?
#returns true

#LIFO: pushing/poping
#difference between shovel (#<<) and #push is that push accepts multiple
#arguments and << only accepts a single argument
nums = []
nums << 1
nums << 2
nums << 3
# nums << 3 + 2
nums << (nums.pop) + (nums.pop)
# nums << 1 + 5
nums << (nums.pop) + (nums.pop)
#answer is 6
#puts nums

#arrays can be used as a queue or FIFO using #push and #delete_at
nums = [1,2,3]
nums.delete_at(0)
nums.push(4)
#puts nums

#shift and unshift are opposite push/pop. They add and remove elements from
#the beginning of an array
nums = [1,2,3]
nums.shift
#puts nums
nums.unshift(5)
#puts nums

#arrays can be joined into a string using the join method
#puts "things I like include: #{long_way.join(" ")}!"

#finding elements in an array is simple with the include? method
#puts long_way.include?("is")

#the index method returns the position of the first occurence of an item in an array
#puts long_way.index("is")

#sorting an array can be done with the sort method
#notice how sort doesn't effect the actual contents of the array, it creates a new
#instance of the object. Using the sort! method actually changes the object
#sort is a safe method, sort! is an unsafe method
sort_me = [3,1,5,6,3]
#puts sort_me.sort
#puts sort_me

sort_me.sort!
#puts sort_me

#arrays can be shuffled into a random order
#shuffle also has safe and unsafe methods
#puts sort_me.shuffle
#sort_me.shuffle!

#accessing the first and last elements of an array is simple
#puts sort_me.first
#puts sort_me.last

#random sampling of an array can be dome with the sample method
#each element of the array has the same probability of being chosen
#puts sort_me.sample

#---------------------------------------------

#accessing an array is simple, it can be done by position like below
new_arr = [1,2,3,4,5]
puts new_arr[0]
puts new_arr[6].inspect #check out error that is thrown

#if you want to control the error that is being thrown, you can use fetch
#puts new_arr.fetch(6).inspect #this throws an error
puts new_arr.fetch(6,"shit, out of bounds")

#special methods to return items without directly identifying the position
puts new_arr.first
puts new_arr.last
puts new_arr.take(3).inspect #from 0 to argument

#drop is the opposite of take, it ignores from 0 to argument, and returns the rest
puts new_arr.drop(2).inspect

#info about an array can be found with a number of functions
puts new_arr.length #size or count work as well
puts new_arr.empty?
puts new_arr.include?(5)

#adding and removing items from an array can be done with several functions
puts (new_arr << 6).inspect #adds to end
puts new_arr.push(7).inspect #adds to end
puts new_arr.unshift(0).inspect #adds to beginning

puts new_arr.insert(3, "banana").inspect
puts new_arr.pop #removes the last element and returns it
puts new_arr.inspect
puts new_arr.shift.inspect #removes first element and returns it
puts new_arr.inspect
puts new_arr.delete_at(2).inspect #deletes item at specific index and returns it
puts new_arr.inspect

puts new_arr.push(6).delete(6) #adding a second 6 to the end of the array, and delete all 6's from the array
puts new_arr.inspect

#a really nifty method to use to remove duplicates from an array is uniq

new_arr << 6 << 6
puts new_arr.uniq.inspect #removes the second 6

new_arr = ['first', 'second', 'third', 'fourth', 'fifth', 'sixth']

#looping over all elements in an array
new_arr.each { |word| puts word }
#loop over all elements backwards
new_arr.reverse_each { |word| puts word }

#map can be used to create a new array based on the original array
#for instance, we can apply a block of code to each element of an array and return a new array
#removing all vowels from all words
puts new_arr.map { |word| word.gsub(/[aeiou]/,'') }.join(' ')

#similar to map, we can SELECT a set of values in an array based on a block condition

new_arr = [1,2,3,4,5,6]

puts new_arr.select { |num| num > 2 }.inspect #returns an array of all values greater than 2
#alternatively, we can use the opposite of select to reject values that don't qualify for a condition
puts new_arr.reject { |num| num < 3 }.inspect

puts ([1,1,3,5] & [3,2,1]).inspect #returns an array containing unique elements common to the two arrays
puts ([1,1,3,5] - [3,2,1]).inspect #returns an array containing elements in the first array that don't exist in the second
puts ([3,2,1] - [1,1,3,5] ).inspect

puts ([1,2,3] + [4,5,6]).inspect #concatenates an array, keeping the order
puts ([1,2,3] * 3).inspect #repeats the array n number of times where n = 3 in this example

arr = [1,2,3,4,5,6]
puts arr[3]
puts arr[1,2].inspect
puts arr[1..2].inspect
puts arr.slice(1,2).inspect
puts arr.slice(1..2).inspect
puts arr.slice(1..-1).inspect #-1 index refers to the last element

arr = [1,2,3,4,5,6]

num = 2
puts arr.index { |x| x == num*2 } #finds index of value 4 (2 * 2)

puts [1,2].hash == [2,1].hash
