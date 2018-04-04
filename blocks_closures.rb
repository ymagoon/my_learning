=begin
  In Ruby, a block is basically a chunk of code that can be passed to and executed by any method.
  Blocks are always used with methods, which usually feed data to them (as arguments).

  Blocks are widely used in Ruby gems (including Rails) and in well-written Ruby code. They are not
  objects, hence cannot be assigned to variables.
=end

# A block is a piece of code enclosed by { } or do..end.

# { This is a single line block }

do
    # This is a multi-line block
end

# Any method can receive a block as an implicit argument. A block is executed by the yield statement within a method.
def meditate
  print "Today we will practice zazen"
  yield  # This indicates the method is expecting a block
end

# We are passing a block as an argument to the meditate method
meditate { print " for 40 minutes." }  # => "Today we will practice zazen for 40 minutes."

=begin
  When the yield statement is reached, the meditate method yields control to the block, the code within the block is
  executed and control is returned to the method, which resumes execution immediately following the yield statement.

  When a method contains a yield statement, it is expecting to receive a block at calling time. If a block is not
  provided, an exception will be thrown once the yield statement is reached.
=end

meditate  # Call method without passing a block

# => Today we will practice zazen.
# => LocalJumpError: no block given (yield)

# Make the block optional and avoid an exception from being raised
def meditate
  puts "Today we will practice zazen."
  yield if block_given?
end

meditate        # => "Today we will practice zazen."

# It is not possible to pass multiple blocks to a method. Each method can receive only one block.

# To pass an argument to a block, we have to pass the argument to the yield statement and specify its name at the block definition

def meditate
  yield("zazen")  # "zazen" is an argument passed from the method to the block
end

# When calling the meditate method, we will provide a block that takes an argument called "name"
meditate {|name| puts "Today we will practice #{name}."}    # => "Today we will practice zazen."

# Blocks can take multiple arguments
def meditate
  yield("zazen", 40)  # "zazen" and 40 are arguments passed from the method to the block
end

meditate {|name, time| puts "Today we will practice #{name} for #{time} minutes."} # => "Today we will practice zazen for 40 minutes."

# Return statements with blocks
=begin
  The return statement in a block behaves differently than that of a method (or a lambda). If a method is defined inside another method,
  the return statement exits only from the inner method itself; then the outer method resumes execution at the following line. In contrast,
  if a block is defined within a method, a return statement within the block will exit the block itself as well as the enclosing method.
=end
def meditate
  puts "Adjusting posture…"
  1.times { puts "Ringing bell…"; return }
  puts "Sitting still…"  # This is not executed
end

meditate                                    # => "Adjusting posture…", "LocalJumpError: unexpected return"

# If we define a block without an enclosing (outer) method and include a return statement, it will throw a LocalJumpError.
1.times { puts "Ringing bell…"; return }    # => "Ringing bell…", "LocalJumpError: unexpected return"

=begin
  This happens because when a return statement is reached within a block, instead of returning (exiting) from the method
  that yielded (called) the block, it will return from the scope on which it (the block) was defined. In the following example,
  a LocalJumpError happens because the block is trying to return from the top-level context, where it was defined.
=end

# If all we need is to exit prematurely from a block, we can use a next statement.
1.times do
  puts "Adjusting posture…"
  next                      # Exit block immediately
  puts "Sitting still…"     #This line is never executed
end

# Blocks and Enumerators
a = ["zazen", "shamata", "tonglen", "vipassana"]
a.each { |meditation| puts meditation }

# Converting blocks into procs when passed to a method with the argument name prefixed by & (ampersand)
def meditate(&practice)
  p = practice            # Assign the proc to a variable. We would not be able to do that with a block.
  p.call if block_given?
end

meditate { "40 minutes of zazen." } # => "40 minutes of zazen."

=begin
  Prefixing the practice argument with an & implicitly converts the passed block to a proc by calling the to_proc method.
  That's why we can assign it to the p variable and execute it with the call method instead of yield. We would not be able
  to do that with a regular block. As the argument prefixed with & is also used as the method's block, we could also execute
  it with a yield statement, like this:
=end
def meditate(&practice)
  yield
end

meditate { "40 minutes of zazen." } # => "40 minutes of zazen."

=begin
  Prefixing an explicit block argument with & will convert it to a proc. The opposite is also true: if we provide a proc as
  an argument prefixed with &, it will be converted into a block.

  Unlike methods and lambdas, blocks handle arguments with great flexibility. It silently defaults missing argument values to nil,
  discards unexpected (extra) arguments, unpacks arrays of arguments, etc.
=end

# Blocks are not closures
=begin
  A closure is a method with the following characteristics:
    1. It remembers the values of all variables that were available in the scope it was defined, even when called on another
       scope or when those variables are no longer available.
    2. It is an object. Hence, it can be assigned to a variable, passed around, called from within different scopes, etc.

  Blocks are not objects, cannot be assigned to variables. Unlike procs which have the Proc.new method, there is no
  Block.new method. Blocks also don't have a call method.
=end

# Ruby has two types of closures: Lambdas and Procs

# Procs
=begin
  Procs are very similar to blocks, with a few important differences:
    1. Unlike blocks, procs are objects and can be assigned to variables.
    2. Procs are closures, blocks are not (as seen above).
    3. Unlike blocks, we can pass multiple Procs to a method as arguments.
=end

# Procs are defined by calling Proc.new and called with the call method
p = Proc.new { puts "Hello!" }
p.call                              # => Hello!

p = Proc.new do
  print "Hello! "
  print "Goodbye!"
end
p.call                              # => Hello! Goodbye!

# We can pass multiple procs to a single method as arguments
def multi_proc_demo(p1, p2)
  p1.call
  p2.call
end

p1 = Proc.new { puts "Hello from the first proc" }
p2  = Proc.new { puts "Hello from the second proc " }

multi_proc_demo(p1, p2)                                           # => "Hello from the first proc", "Hello from the second proc"

# Procs can take arguments
p = Proc.new { |name| puts "Hello, #{name}!" }
p.call "Eihei Dogen"                                              # => Hello, Eihei Dogen!

def meditate(p)
  p.call 'zazen'  # zazen is an argument passed by the method to the proc
end

meditate Proc.new {|name| puts "Today we will practice #{name}."} # => "Today we will practice zazen."

# Unlike a method, when a proc expects an argument and we don't provide one, it runs normally and defaults the missing argument value to nil
p = Proc.new { |name| puts "Hello, #{name}!" }
p.call                                                            # => Hello, !

=begin
  A proc handles arguments with greater flexibility than a method or a lambda. In addition to defaulting missing argument
  values to nil, a proc also silently discards unexpected arguments, implicitly unpacks arrays of arguments, etc. This behavior
  can be useful in some cases, but it usually makes it harder to notice and debug argument mismatches.
=end

# Return statements and procs
=begin
  Another important difference between a proc and a method or lambda is the way in which they handle the return statement.
  If a method is defined inside another method, the return statement in the inner method exits only from the inner method itself,
  then the outer method continues executing. The same goes for defining a lambda within a lambda, a lambda inside a method or a method
  within a lambda. However, when a proc is defined within a method, the return statement will exit from the proc as well as the outer
  (enclosing) method.
=end
def meditate
  puts "Adjusting posture…"
  p = Proc.new { puts "Ringing bell…"; return }
  p.call
  puts "Sitting still…"  # This is not executed
end

meditate                 # => "Adjusting posture…", "Ringing bell…"

# If we define a proc without an enclosing (outer) method and use a return statement, it will throw a LocalJumpError.
p = Proc.new { puts "Ringing bell…"; return }
p.call                   # => "Ringing bell…", "LocalJumpError: unexpected return"

=begin
  This happens because when a return statement is reached within a proc, instead of returning from the context where it
  was called, it returns from the scope on which it (the proc) was defined. In the following example, a LocalJumpError happens
  because the proc is trying to return from the top-level environment, where it was defined.
=end
def meditate p
  puts "Adjusting posture…"
  p.call
  puts "Sitting still…"  # This is not executed
end

p = Proc.new { puts "Ringing bell…"; return }   # scope of proc not inside method like the previous example

meditate p               # => "Adjusting posture…", "Ringing bell…", "LocalJumpError: unexpected return"

=begin
  Usually, it's not a good idea to use a return statement within a proc. Procs are usually passed around between
  methods and if the method on which the proc was defined has already returned, it will throw an exception. In the
  example below we could just remove the return statement. However, there are cases we actually need to return something.
  In the latter, it's probably best to use a lambda instead of a proc. We will see later that lambdas handle return statements
  in a different way, more like methods.
=end
def zafu_factory
  # This method will return the following proc implicitly
  Proc.new { puts "Round black zafu"; return }
end

def meditate
  puts "Adjusting posture…"
  p = zafu_factory
  p.call
  puts "Sitting still…"   # This is not executed
end

meditate                  # => "Adjusting posture…", "Round black zafu", "LocalJumpError: unexpected return"

=begin
  What just happened? The zafu_factory method created and implicitly returned a proc. Then, the proc was called by the
  meditate method and when the return statement within the proc was reached, it tried to return from the context on which
  it was defined (the zafu_factory method). However, zafu_factory already returned the proc and a method can only return
  once each time it's called. In other words, an exception was thrown because the zafu_factory method had already returned
  when the proc was called and tried to return a second time.
=end
def meditate
  puts "Adjusting posture…"
  p = Proc.new do
      puts "Ringing bell…"
      next
      puts "Throwing up zafus"
  end
  p.call
  puts "Sitting still…"   # This line *is* executed
end

meditate                  # => "Adjusting posture…", "Ringing bell", "Sitting Still..."

# The proc exits immediately when the next statement is reached (no zafus were thrown up).
# When the proc exits, the execution of the enclosing (outer) method is resumed and the line below the proc
# (puts "Sitting still…") runs normally.

# See all available methods that can be called on a proc, which is always an instance of the Proc class
Proc.instance_methods.sort

Proc.instance_methods(false) # => [:[], :arity, :binding, :call, :curry, :lambda?, :parameters, :source_location, :to_proc, :yield]

# Lambdas
=begin
  Lambdas are anonymous functions, which means they are functions with no name. They are objects and therefore can be stored inside
  variables and passed around.

  Lambdas are instances of the Proc class.
=end

Proc.new { }        # => #<Proc:0x00000001295210@(irb):153>
lambda {}           # => #<Proc:0x00000001312b48@(irb):154 (lambda)>

# Differences between lambdas and procs
=begin
  Return statement behavior: Like a method, a lambda can return a value using the return statement. A proc cannot do that. Also,
  when a return statement is reached within a lambda, it will return execution to the outer method on which it was defined. When a
  Proc encounters a return statement, it will exit from both the proc itself and the enclosing method (method on which the proc was defined).

  Handling missing arguments: When a lambda expects arguments and we don't provide them, or we provide the wrong number of arguments,
  an exception is thrown. When a Proc expects an argument and doesn't receive it, it runs and defaults the missing argument value to nil.
=end

l = lambda { puts "Hello" }
l.call                        # => Hello

# Stabby lambda
l = ->{ puts "Hello" }
l.call                        # => Hello

l = lambda do
  puts "Hello"
end

l.call                        # => Hello

# Just like in methods, we can set parameters when defining a lambda and pass arguments when calling it.
l = lambda { |name| puts "Today we will practice #{name} meditation." }
l.call "zazen"                # => Today we will practice Zazen meditation.

# Stabby syntax
l = -> (name) { puts "Today we will practice #{name} meditation." }
l.call "zazen"                # => Today we will practice Zazen meditation.

# When a lambda expects arguments and we don't provide them, or we provide the wrong number of arguments, an exception is thrown.
l = lambda { |name| puts "Today we will practice #{name} meditation." }
l.call                        # => ArgumentError: wrong number of arguments (given 0, expected 1)

# We can use the arity method to find out the number of expected arguments:
l.arity                       # => 1

=begin
  Just like methods, lambdas accept all of the following types of parameters/arguments:
    - Positional parameters (required and optional)
    - Single splat parameter (*);
    - Keyword parameters (required and optional);
    - Double splat parameter (**);
    - Explicit block parameter prefixed with ampersand (&).
end

=begin
  Lambdas handle arguments the same way as methods.

  There is an exception though. In Ruby, we can pass a block as an implicit argument to any method and execute it with a yield statement.
  Lambdas are different as they will not accept a block as an implicit argument. However, as seen above, we can pass a block to a lambda
  as an explicit argument (prefixed with ampersand) and execute it with the call method. We can also pass procs and other lambdas to a
  lambda as arguments.
=end
lambda1 = -> { puts "Hello from lambda1" }
lambda2 = ->(other_lambda) do
  other_lambda.call
  puts "Hello from lambda2"
end

lambda2.call lambda1        # => "Hello from lambda1", "Hello from lambda2"

=begin
  Lambdas also handle return statements in the same way as methods. When reached, a return statement will exit from the lambda itself
  and return execution to the outer (enclosing) method. Return statements are optional and, just like methods, lambdas will implicitly
  return the last evaluated expression.
=end
