#before we actually get into memoization, we need to understand operators that are used in memoization. Because they are new and I've
#never seen them before, I will cover them here

#Ruby's ||= operator, a = a || b, and a || a = b
a = nil
b = 20
a ||= b

puts a #=> 20

#the example above is a simple example demonstrating ||='s use. If the value on the left hand side is nil or false, it is set to
#the right hand side. In our case, a was nil, so it was set to b.

c = nil
d = 20
c = c || a

puts c #=> 20
#since c is nil, the left hand side of the equation is false, so the right hand side is looked at.
#this acts just like ||= in this example, but the difference is really only seen with a more complex problem.

#Let's look at one now.
h = {}

def h.[]= (k,v)
  puts "Setting hash key #{k} with #{v.inspect}"
  super
end

# 1. The standard ||= approach
h[:x] ||= 10
h[:x] ||= 20

# 2. The a = a || b approach
h[:y] = h[:y] || 10
h[:y] = h[:y] || 20

# 3. The a || a = b approach
h[:z] || h[:z] = 10
h[:z] || h[:z] = 10

#output
#Setting hash key x with 10
#Setting hash key y with 10
#Setting hash key y with 10
#Setting hash key z with 10

#we have six assignments, but only 4 outputs?! Let's see what happened...
#using the ||= operator, the hash key's value is only set once. Once the first value is set, the value is not nil or false,
#so the second assignment is never done.

#using a = a || b, there are two assignments, even though the value stays the same. The h[:y] portion of the equation
#is true, so h[:y] is set to itself.

#using a || a = b, we have a single assignment. It acts just like ||=

#we can use memoization to significantly increase performance of repeated processes. Take the fibonacci sequence, for example
def fib(n, memo = {})
  if n == 0 || n == 1
    return n
  end

  memo[n] ||= fib(n-1, memo) + fib(n-2, memo)
end

puts fib(3758)
