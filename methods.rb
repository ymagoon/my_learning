# Methods
=begin
  A method is a way of grouping related code into a single container. In other words, methods are named chunks
  of code that can be reused. Usually, methods take some data (called input or arguments), does something with
  that input and gives back a result (called return or output).
=end

def say_hello
  puts "Hello!"
end

say_hello               # => "Hello!" we execute a method simply by typing its name

# Positional Arguments
=begin
  Usually the terms parameter and argument are used interchangeably. In a stricter sense, a parameter
  (AKA formal parameter) is defined at the method declaration and an argument (AKA actual parameter) is the
  data provided to the method at calling time, which is "passed through" a parameter.
=end
def say_hello name          # name is the parameter
  puts "Hello, #{name}!"  # the data contained here is the argument
end

say_hello "dear visitor"    # => "Hello, dear visitors!"
say_hello("dear visitor")   # => "Hello, dear visitors!" we can also enclose the argument in parenthesis

# Methods can have multiple parameters
def greet time, name, *foo
  puts "Good #{time}, #{name}!"
end

greet "morning", "dear visitor" # => "Good morning, dear visitor!"

# Keyword Arguments
=begin
  When passing a large number of arguments to a method, the positional syntax used above can cause confusion.
  For instance, if we forget to include an argument when calling the method, all following arguments will be
  passed through the wrong parameters. In these cases, it's usually better to use keyword arguments, which
  allows us to switch the order of the arguments without affecting the result. Keyword arguments are passed by
  name, instead of by position.
=end

def greet time:, name:            # The : following the parameter is what makes these keyword parameters that accept keyword arguments
  puts "Good #{time}, #{name}!"
end

greet name: "dear visitor", time: "morning"   # => "Good morning, dear visitor!" the order does not matter because the parameters match

# Optional Arguments; Default Values
# When a method expects arguments and we don't provide them, or we provide the wrong number of arguments, an exception is thrown.
def greet time, name
  puts "Good #{time}, #{name}!"
end

greet                             # => ArgumentError: wrong number of arguments (given 0, expected 2)

method(:greet).arity              # => 2 we can use the built-in arity method to find out the number of arguments expected by a method

=begin
  When called on a method that takes mandatory arguments only, arity returns the number of expected arguments. When invoked on a method
  that takes both mandatory and optional arguments, arity returns -n-1 where n is the number of required arguments. So, a method with 3
  required arguments and any number of optional arguments has an arity of -4.
=end

#Method with option arguments. When the default value is set they become optional
def greet time="afternoon", name="dear visitor"
 puts "Good #{time}, #{name}!"
end

greet                             # => "Good afternoon, dear visitor!" call the method without providing any arguments

# Splat Operator
=begin
  Methods can take any number of arguments by prefixing a parameter with a * (splat) or a ** (double splat) operator.
  This is useful when the exact number of arguments is unknown at method definition.
=end

def list_masters *names
 print names
end

list_masters "Shunryu Suzuki", "Thich Nhat Hanh", "Kodo Sawaki" # => ["Shunryu Suzuki", "Thich Nhat Hanh", "Kodo Sawaki"] pass three arguments

# Double splat (**) operator stores arguments in a hash instead of an arrays
def meditate **details
 print details
end

meditate(mat: "zabuton", cushion: "zafu", practice: "shikantaza", time: 40) # => {:mat=>"zabuton", :cushion=>"zafu", :practice=>"shikantaza", :time=>40}

# Passing blocks into methods
=begin
  When the last parameter of a method is prefixed with the ampersand (&) operator, it means the method is expecting a block.
  Any method can take a block as an implicit argument. However, this is different. When we define a method with the last
  parameter prefixed with &, any block passed to the method will be converted into a proc (the to_p method is invoked under
  the hood) and assigned to the parameter.
=end
def tester &foo
  puts "foo is a #{foo.class}"
  foo.call  # call the proc
end

tester { puts "Hello from the proc" }       # => "foo is a Proc", "Hello from the proc"

# Notice in the example above that the block (which is now a proc) was assigned to the foo variable. We would not be
# able to do that to a block as blocks are not objects and cannot be assigned to variables.

# Even though the block is converted into a proc, it is also treated as the method's block. We can execute it with a call or yield
def tester &foo
    yield if block_given?
end

tester { puts "Hello from the block" }    # => "Hello from the block"

# When calling a method, we can pass a proc as an argument and prefix it with the ampersand (&) operator. This will convert the proc
# into a block and pass it to the method.
def tester
  yield if block_given?
end

p = Proc.new { puts "Hello from the proc, converted to a block" }
tester &p                                 # => "Hello from the proc, converted into a block"

# Lambdas are instances of the Proc class. They can also be passed to a method as an argument prefixed by &
l = lambda { puts "Hello from the lambda, converted to a block" }
tester &l                                 # => "Hello from the lambda, converted to a block"

# The & operator can also be used to pass an object as a block to a method

ary = [1, 2, 3, 4, 5]

ary.map { |n| n.to_s }
ary.map(&:to_s)       # same as above

=begin
  Both the examples above have the same result. In both, the map method takes the arr array and a block, then it runs the block on each
  element of the array. The code inside the block runs to_s on each element, converting it from integers to strings. Then, the map method
  returns a new array containing the converted items.

  In Ruby, items prefixed with colon (:) are symbols. All method names in Ruby are internally stored as symbols. By prefixing a method
  name with a colon, we are not converting the method into a symbol, neither are we calling the method, we are just passing the name of
  the method around (referencing the method). In the example above, we are passing :to_s, which is a reference to the to_s method, to the
  ampersand (&) operator, which will create a proc (by calling to_proc under the hood). The proc takes a value as an argument, calls to_s
  on it and returns the value converted into a string.

  Although the :to_s symbol is always the same, when running the map loop, it will refer to the to_s method of the class corresponding to
  each array item. If we passed an array such as [ 21, 4.453, :foobar, ] to the map method, the to_s method of the Fixnum class would be
  applied (called) on the first item, the to_s method of the Float class would be applied to the second item and the to_s method of the
  Symbol class would be applied to the third item. This makes sense because, as we learned above, we are not passing the actual to_s method
  to the ampersand operator, just its name.
=end

# An example of creating a proc that takes an argument, calls a method on it and returns the result of the method.
p = :upcase.to_proc
p.call("foo bar")           # => "FOO BAR"

# Review of what is going on in arr.map &:to_s
=begin
    1. At each iteration of map, one item of the array (an integer) is passed to &:to_s
    2. The :to_s symbol (which is a reference to the to_s method) is passed to the & operator, which creates a proc that will take an
       argument (an array item), call to_s on the argument and return the value converted into string;
    3. The map method returns a new array containing the strings "1", "2", "3", "4" and "5".
=end

# Returning a result
def say_hello name
  return "Hello, #{name}!"
end

greeting = say_hello "dear visitor"
puts greeting                             # => "Hello, dear visitor"

# Methods do not require a return statement in order to return something.Tthe method returns the value of the last evaluated expression (last statement)
# if the return statement is omitted
def say_hello name
  "Hello, #{name}!"
end

greeting = say_hello "dear visitor"
puts greeting                             # => "Hello, dear visitor"

# Parentheses are not required when calling a method, except when the passed arguments are ambiguous without parentheses.
def method1 arg1, arg2
  return "#{arg1} #{arg2}"
end

def method2 a1
  return a1
end

method1 "foo", method2 "bar"              # => "SyntaxError: (irb):175: syntax error, unexpected tSTRING_BEG, expecting keyword_do..."
method1("foo", method2("bar"))            # => "foo bar"

=begin
  In Ruby, methods are not closures, neither are the Method objects. As stated by Yukihiro Matsumoto (Matz) in the book as mentioned earlier
  "One important difference between Method objects and Proc objects is that Method objects are not closures. Ruby's method are intended to be
  completely self-contained, and they never have access to local variables outside of their scope. The only binding retained by a Method object,
  therefore, is the value of self - the object on which the method is to be invoked."
=end
