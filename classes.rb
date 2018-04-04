=begin
Classes are blueprints used to create a grouping of functions in a single container (object). In the example below
attr_accessor is an attribute accessor, or a method that allows us to read and write instance variables from
outside the class. :color is an attribute, which is a component of a class that ca be accessed from outside.
=end

class Car
  attr_accessor :color
end

# In order to use a class, we need to create an instance of it. If a class is a blueprint, then an instance is the actual
# object.

civic = Car.new     # Create an instance of Car

civic.color = "red" # Sets :color attribute to "red"
civic.color         # => "red"

# We can create as many instances as we want and store them in a collection such as an Array or Hash. Each instances
# could have a different attribute for :color.

=begin
  Reflection, also known as introspection, is the ability to programmatically examine (inspect) classes, objects, methods,
  etc. In other words, the application provides information about its own code and state. That is useful in the context of
  metaprogramming, debugging and understanding code written by other people.
=end

class Meditation
  def initialize
    @name = "zazen"
    @minutes = 40
  end
end

m = Meditation.new

# Inspecting the object provides us with a human-readable string representation of our object, including the class name,
# a hexadecimal representation of the object ID, and the names and values of the object's variables (instance variables).

m.inspect # => "#<Meditation:0x00000001662000 @name=\"zazen\", @minutes=40>"

# Testing if an object is an instance of a class

m === Meditation          # => true
m.is_a? Meditation        # => true
m.instance_of? Meditation # => true only returns true if instance of specific class without inheritance

n = Meditation.new

# Create one more instance, then get a list of all instances of the of the Meditation class.
ObjectSpace.each_object(Meditation) { |obj| puts obj } # we could use this example to write an attribute in all instances

# All classes are instances of a built-in class called Class.
class Foo
end

Foo.instance_of? class    # => true
f = Foo.new
f.instance_of? Foo        # => true
f.instance_of? Class      # => false

=begin
Foo class is an instance of the built-in Class named class. Foo is not a subclass of Class; there is no inheritance
relationship between them.

Class (built-in class)
   |
   |--- Foo (instance of Class)
         |
         |--- f (instance of Foo)
=end

# If a class has an itinitialize method, when an instance of a class is created Ruby automatically executes it
class Car
  attr_accessor :color

  def initialize
    @color = "black"
  end
end

c = Car.new
c.color               # => "black"

# We can also add parameters when defining the initialize method. When instantiating a class, any arguments passed to
# the new method are received by the initialize method.
class Car
  attr_accessor :color

  def initialize(color)
    @color = color
  end
end

c = Car.new          # ArgumentError: wrong number of arguments (given 0, expected 1)
c = Car.new "silver" # "silver" argument passed to the initialize method when the instance c is created
c.color              # => "silver"

# Attributes are class components that can be accessed from outside the object. Their values are accessible by using the
# "dot notation", as in object_name.attribute_name
class Car
  def initialize
    @wheels = 4      # This is an instance variable
  end
end

c = Car.new
c.wheels             # NoMethodError: undefined method `wheels' for #<Car:0x00000000d43500>

=begin
  In the above example, c is an instance (object) of the Car class. We tried unsuccessfully to read the value of the wheels
  instance variable from outside the object. What happened is that Ruby attempted to call a method named wheels within the
  c object, but no such method was defined. In short, object_name.attribute_name tries to call a method named attribute_name
  within the object. To access the value of the wheels variable from the outside, we need to implement an instance method by
  that name, which will return the value of that variable when called. That's called an accessor method. In the general
  programming context, the usual way to access an instance variable from outside the object is to implement accessor methods,
  also known as getter and setter methods. A getter allows the value of a variable defined within a class to be read from the
  outside and a setter allows it to be written from the outside.
=end

# Not the 'Ruby' way to set getters and setters, this only illustrates what they do
# Getter and setter methods should only be explicitly be defined like this if they need to do a calculation or data validation.
class Car
  def wheels  # getter method
    @wheels
  end

  def wheels=(val)  # setter method
    @wheels = val
  end
end

civic = Car.new
civic.wheels = 4    # The setting method was invoked
civic.wheels        # => 4 the getter method was invoked

# Ruby provides an easier, shorter way via three methods: attr_accessor, attr_reader, attr_writer
class Car
  attr_accessor :wheels # wheels is readable and writable outside the class
end

civic = Car.new
civic.wheels = 4    # The setting method was invoked
civic.wheels        # => 4 the getter method was invoked

# Inheritance
=begin
  A class that inherits from another class is called a subclass (child class). The class that is inherited (where the inherited
  components are implemented) is called superclass or parent class.

  Usually, the superclass (parent) is more general and its subclasses (children) add further specialization. For instance, a
  class called Car may specify that cars have 4 wheels, a steering wheel and so on. This class may inherit from a class called
  Vehicle that implements the details of combustion engines and will also be inherited by the Motorcycle class.

  Each class can only inherit from one other class.
=end

# Method overriding allows a subclass to provide its own implementation of an inherited method. When there are two methods with the
# same name, one in the superclass and another on the subclass, the implementation of the subclass will override the one from the superclass
class A
  def meditate
    puts "Practicing zazen…"
  end
end

class B < A
  def meditate
    puts "Practicing kinhin…"
  end
end

b = B.new
b.meditate                    # => Practicing kinhin…

# Using the super keyword within the subclass the superclass implementation of the corresponding method
class Sitting < Zazen
  def meditate
    puts "Sitting…"
    super                     # Calls the meditate method implemented in the parent class
    puts "Getting up…"
  end
end

s = Sitting.new
s.meditate                    # "Sitting" \n "Practicing zazen..." \n "Getting up..."

# When called with no arguments, super automatically passes any arguments received by the method from which it's called (at the subclass)
# to the corresponding method in the superclass.
class A
  def some_method(*args)
    puts "Received arguments: #{args}"
  end
end

class B < A
  def some_method(*args)
    super
  end
end

b = B.new
b.some_method("foo", "bar")     # => Received arguments: ["foo", "bar"]

# If called with empty parentheses (empty argument list), no arguments are passed to the corresponding method in the superclass
class A
  def some_method(*args)
    puts "Received arguments: #{args}"
  end
end

class B < A
  def some_method(*args)
    super()                     # => Notice the empty parentheses here
  end
end

b = B.new
b.some_method("foo", "bar")     # => Received arguments: [ ]

# When called with an explicit argument list, it sends those arguments to the corresponding method in the superclass
class A
  def some_method(*args)
    puts "Received arguments: #{args}"
  end
end

class B < A
  def some_method(*args)
    super("baz", "qux")         # Notice that specific arguments were passed here
  end
end

b = B.new
b.some_method("foo", "bar")     # => Received arguments: ["baz", "qux"]

# Ruby provides reflective methods which return information about a class's inheritance chain.
class AsianReligion
end

class Buddhism < AsianReligion
end

class Zen < Buddhism
end

# If we are unable to look at the above code, we can find the relationship of inheritance using several methods
# Check if the Zen class is a descendant of the Buddism and AsianReligion classes:
Zen < Buddhism                 # => true
Zen < AsianReligion            # => true

Zen.superclass                 # => Buddhism identify the superclass of Zen

# Get a list of all ancestors of the Zen class. The ancestors method returns the whole inheritance hierarchy
# (Zen and all classes above it) and all the modules included in these classes
Zen.ancestors - Zen.included_modules  # => [Zen, Buddhism, AsianReligion, Object, BasicObject]

# Ruby's core object model https://go.gliffy.com/go/publish/5152080

# Polymorphism
=begin
  Polymorphism is to call the same method in different objects and get different results. We are actually calling
  different implementations of the method (entirely different methods with the same name). Hence, the different results.

  There are three types of polymorphism: inheritance polymorphism, interface polymorphism, and abstract polymorphism.
  Inheritance and interface examples are below, abstract is usually implemented by using abstract classes, which are not supported by Ruby.
=end

# Polymorphism is usually implemented through inheritance. if both child and parent classes define methods with the same name, the implementation
# of the subclass prevails
class Mammal
  @@vertebrate = true
  @@endothermic = true
  @@fur = true

  def make_sound
    raise NotImplementedError, "The make_sound method should be implemented in the subclass."
  end
end

class Cat < Mammal
end

class Dog < Mammal
  def make_sound
    puts "Woof"
  end
end

c = Cat.new
c.make_sound              # => NotImplementedError: The make_sound method should be implemented in the subclass.

d = Dog.new
d.make_sound              # =>  Output: Woof

# Interface Polymorphism
# Different methods with the same name are implemented in distinct classes and do different things.
"foo" + "bar"             # => "foobar" when called on a string object, it will concatenate two operands
1.0 + 1.0                 # => 2.0 when called on a float, it will sum two operands
["foo", "bar"] + ["baz"]  # => ["foo", "bar", "baz"] when called on an array, it will merge two operands into a single new array.

# Variable types
# Ruby provides five types of variables: global, instance, class, local and constant.

=begin
  Instance variables are defined within instance methods, and their names begin with @. Their value is only accessible within the
  specific object on which it was set. In other words, when we modify the value of an instance variable, the change only applies to
  that particular instance. Unlike local variables which are only available within the method where they were defined, instance variables
  are accessible by all methods within the object (instance methods of the class). Instance variables are the most commonly used type of
  variable in Ruby classes.
=end
class Car
  attr_reader :color

  def set_color(color_receiverd_as_argument)
    @color = color_receiverd_as_argument
  end
end

car1 = Car.new
car1.color                # => nil
car1.set_color "black"
car1.color                # => "black"

car2 = Car.new
car2.set_color "silver"   # Changing @color in one instance of Car does not affect the value of the same variable in the other instances
car2.color                # => "silver"

# Get a list of all instance variables of a class
car1.instance_variables   # => [:@color]
car2.instance_variables   # => [:@color]

# Class variables
=begin
  Class variables are defined at the class level, outside any methods. Their names begin with @@, and their values can be read or written
  from within the class itself or any of its subclasses and instances. Class variables can be accessed by both class methods and instance
  methods (explained further below).

  Note that accessor methods (explained above) such as attr_access, attr_read, and attr_write do not work with class variables. Rails
  provides accessor methods that work with class variables, named cattr_accessor, cattr_reader and cattr_writer.
=end
class Car
  @@count = 0            # This is a class variable

  def initialize
    @@count += 1         # Increment the count each time the class is instantiated
    puts @@count
  end


  def count              # This is a getter method, used to read the @@count class variable from outside
    @@count
  end
end

# Create 3 instances of the Car class
car1 = Car.new
car2 = Car.new
car3 = Car.new

car1.count               # => 3
car2.count               # => 3
car3.count               # => 3

class Sedan < Car
  def mess_up_count
    @@count = 345
  end
end

sedan = Sedan.new
sedan.count              # => 4 subclass class inherited @@count and its value from Car

sedan.mess_up_count
car3.count               # => 345

# The class_variables method returns an array containing the names of all class variables in a specific class
# Use Car.class_variables(false) to omit inherited class variables.
Car.class_variables      # => [:@@count]

# Class instance variables
=begin
  Class instance variable names also begin with @. However, they are defined at class level, outside any methods.
  Class instance variables can only be accessed by class methods. They are shared amongst all instances of a class
  but not its subclasses. In other words, they are not inheritable. If the value of a class instance variable is
  changed in one instance of the class, all other instances are affected. Earlier we saw how all classes are
  instances of a built-in class called Class. That is what makes class instance variables possible.
=end
class Vehicle
  @count = 0                   # This is a class instance variable

  def initialize
    self.class.increment_count
    self.class.show_count
  end

  def self.increment_count    # This is a class method
    @count += 1
  end

  def self.show_count        # This is a class method
    puts @count
  end
end

class Car < Vehicle
  @count = 0
end

v1 = Vehicle.new            # => 1
v2 = Vehicle.new            # => 2
v3 = Vehicle.new            # => 3

car1 = Car.new              # => 1
car2 = Car.new              # => 2

v3 = Vehicle.new            # => 4

=begin
  Let's review the example above. A class instance variable called @count is set in the Vehicle class, with an initial
  value of 0. Every time the Vehicle class is instantiated, the initialize method calls self.increment_count to increment
  the value of @count and self.show_count to return the new value. Then, we have the Car class, which is a subclass of
  Vehicle and inherits all of its methods. However, it does not inherit the @count class instance variable, as this type
  of variable is not inheritable. That's why the counter works within the Car class, but it has its own count.

  Methods prefixed with self., such as self.increment_count and self.show_count, are class methods. That is the only kind
  of method capable of accessing class instance variables. We will get back to class methods soon.
=end

 # Local variables within a class are like any other local variable.. It is only accessible within the exact scope on which it's created
 class Car
   def initialize
     wheels = 4
   end

   def print_wheels
     print wheels
   end
 end

 c = Car.new
 c.print_wheels             # => NameError: undefined local variable or method `wheels'

# Constants
# Constants defined within classes can be accessed by all methods of that class. Those created outside a class can be accessed globally
# (within any method or class).
class Car
  WHEELS = 4

  def initialize
    puts WHEELS
  end
end

c = Car.new                # => 4

=begin
  In Ruby, all class and module names are constants, but convention dictates they should be written in camel case, such as SomeClass.

  Constants can be accessed from outside the class, even within another class, by using the :: (double colon) operator. To access the
  WHEELS constant from outside the Car class, we would use Car::WHEELS. The :: operator allows constants, public instance methods and
  class methods to be accessed from outside the class or module on which they are defined.
=end

Car::WHEELS                # => 4

# A built-in method called private_constant makes constants private (accessible only within the class on which they were created)
class Car
  WHEELS = 4

  private_constant:WHEELS
end

Car::WHEELS                # => NameError: private constant Car::WHEELS referenced

# Instance Methods
# All methods defined inside a class with the def method_name syntax are instance methods.
class Koan
  def say_koan
    puts "What is your original face before you were born?"
  end
end

k = Koan.new
k.say_koan                 # => What is your original face before you were born?

Koan.instance_methods(false)  # => [:say_koan]

# Class methods can be called directly on the class, without instantiating it. Their names are prefixed with self
class Car
  def self.drive
    puts "Driving car…"
  end
end

# Call the class method without instantiating the class
Car.drive                  # => "Driving car..."
Zabuton::stuff             # => "Driving car..."

# Call the class method through an object
civic = Car.new
civic.class.drive          # => "Driving car..."

# The following syntax can also be used to define class methods and will produce the same result as the above syntax
class Car
  class << self
    def drive
      puts "Driving car…"
    end
  end
end

# We can also call a class method from within an instance method, by prefixing it with self.class, as in the following example
class Car
  def initialize
    self.class.drive
  end

  def drive
    puts "Driving car..."
  end
end

civic = Car.new           # => "Driving car..."

# The built-in method called methods returns an array including the names of all class methods of a specific class
civic.methods             # => [:drive]

# Ruby provides three types of methods: public, private, and protected. Public methods are what we have been defining in all previous
# examples. They can be accessed from within or outside the class
civic.public_instance_methods(false)  # => [:drive]

# Private Methods
=begin
  To define a private method, we use the private keyword, which is actually a built-in method implemented in a class called Module.
  A private method can only be called by another method within the class on which it was defined (or one of its subclasses).
=end
class Car
  def output_drive
    drive
  end

  private
    def drive
      puts "Drives off a cliff..."
    end
end

civic = Car.new
civic.output_drive    # => "Drives off a cliff..."
civic.drive           # => NoMethodError: private method `drive' called for #<Car:0x000000021e7380>

# Private was used in the above example with no arguments. Any method below the keyword private will be private as well. We can also
# pass in methods as symbols to make them private
class Car
  def output_drive
  end

  def drive
  end

  private :drive
end

# In order to make a class method private, use the private_class_method keyword/method instead of private.
# To list all private instance methods in a class, use the private_instance_methods built-in method. For private class methods,
# use private_methods.
Car.private_instance_methods(false)  # => [:drive]

# Protected Methods
=begin
  To define a protected method, we use the protected keyword (which is actually a method). Like private methods, protected methods
  can also be called by other methods within the class on which it was defined (or one of its subclasses). The difference is, protected
  methods can also be called from within other instances of the same class.

  Let's suppose we need to select a few meditators to participate in a study. To find the most experienced meditators, we need to compare
  their total hours of meditation. However, we don't want the number of hours to be visible.
=end
class Meditator
  def initialize(hours)
    @hours = hours
  end

  def more_experienced?(other_person)
    hours > other_person.hours
  end

  protected
    attr_read :hours # we have made the accessor protected
end

m1 = Meditator.new 3000
m2 = Meditator.new 5000

m2.more_experienced?(m1)    # => true
m1.more_experienced?(m2)    # => false

# To list all protected instance methods in a class, use the protected_instance_methods built-in method. For protected class methods,
# use protected_methods.
Meditator.protected_instance_methods(false)  # => [:hours]

=begin
  The self keyword is always available, and it points to the current object. In Ruby, all method calls consist of a message sent to a
  receiver. In other words, all methods are invoked on an object. The object on which the method is called is the receiver, and the method
  is the message. If we call "foo".upcase, the "foo" object is the receiver and upcase is the message. If we don't specify an object
  (a receiver) when calling a method, it is implicitly called on the self object.
=end

# Class level
class Foo
  @@self_at_class_level = self

  def initialize
    puts "self at class level is #{@@self_at_class_level}"
  end
end

f = Foo.new                                 # => self at class level is Foo

# Instance method level
# When inside an instance method, the self keyword refers to that specific instance.
class Meditation
  def initialize
    puts "self within an instance method is #{self}"
  end
end

# Notice that #<Meditation:0x00000000ab2b38> is a string representation of the m1 object, which is an instance of the Meditation class.
m1 = Meditation.new                         # => self within an instance method is #<Meditation:0x00000000ab2b38>

# Self with modules
module Meditable
  def meditate
    "Practicing #{self.meditation_name}…"
  end
end

class Sitting
  include Meditable
  attr_accessor:meditation_name

  def initialize(meditation_name)
    @meditation_name = meditation_name
  end
end

s = Sitting.new "zazen"
s.meditate                                  # => "Practicing zazen…"

# In the above example, the self keyword refers to the instance of the Sitting class from which the meditate method was called.

=begin
  All instance methods defined in this post's examples are global methods. That means they are available in all instances of the
  class on which they were defined. In contrast, a singleton method is implemented on a single object.

  There is an apparent contradiction. Ruby stores methods in classes and all methods must be associated with a class. The object on
  which a singleton method is defined is not a class (it is an instance of a class). If only classes can store methods, how can an
  object store a singleton method? When a singleton method is created, Ruby automatically creates an anonymous class to store that
  method. These anonymous classes are called metaclasses, also known as singleton classes or eigenclasses. The singleton method is
  associated with the metaclass which, in turn, is associated with the object on which the singleton method was defined.

  If multiple singleton methods are defined within a single object, they are all stored in the same metaclass.
=end

class Zen
end

z1 = Zen.new
z2 = Zen.new

def z1.say_hello  # Notice that the method name is prefixed with the object name
  puts "Hello!"
end

z1.say_hello     # => Hello!
z2.say_hello     # => NoMethodError: undefined method `say_hello'…

# Alternatively, you can define a singleton method like this:
z1.define_singleton_method(:say_hello) { puts "Hello!" }

=begin
  We learned earlier that classes are also objects (instances of the built-in class called Class). We also learned about class methods.
  Well, class methods are nothing more than singleton methods associated with a class object. The following example was already seen in
  the section about class methods. After learning about metaclasses, we may look at it again with a deeper understanding.
=end
class Zabuton
  class << self
    def stuff
      puts "Stuffing zabuton…"
    end
  end
end

=begin
  All objects may have metaclasses. That means classes can also have metaclasses. In the above example, class << self modifies self so
  it points to the metaclass of the Zabuton class. When a method is defined without an explicit receiver (the class/object on which the
  method will be defined), it is implicitly defined within the current scope, that is, the current value of self. Hence, the stuff method
  is defined within the metaclass of the Zabuton class. The above example is just another way to define a class method. IMHO, it's better
  to use the def self.my_new_clas_method syntax to define class methods, as it makes the code easier to understand. The above example was
  included so we understand what's happening when we come across the class << self syntax.
=end

# Returns an array of names of the singleton methods associated with a specific object.
z1.singleton_methods          # => [:say_hello]

# Remember how all classes are instances of a built-in class called Class? Well, Class is a subclass of Module (another built-in class).
Class.superclass              # => Module

# Most of the built-in methods used to manipulate classes are defined in the Module class.
Module.instance_methods(false)
=begin
  => [:<=>, :module_exec, :class_exec, :<=, :>=, :==, :===, :include?, :included_modules, :ancestors, :name,
  :public_instance_methods, :instance_methods, :private_instance_methods, :protected_instance_methods, :const_get,
  :constants, :const_defined?, :const_set, :class_variables, :class_variable_get, :remove_class_variable,
  :class_variable_defined?, :class_variable_set, :private_constant, :public_constant, :singleton_class?,
  :deprecate_constant, :freeze, :inspect, :module_eval, :const_missing, :prepend, :method_defined?, :class_eval,
  :public_method_defined?, :private_method_defined?, :<, :public_class_method, :>, :protected_method_defined?,
  :private_class_method, :to_s, :autoload, :autoload?, :instance_method, :public_instance_method, :include]
=end

=begin
  As we already learned, it is standard practice to implement "generic" code (which can be used in different contexts) in the superclass and add
  extra specialization within subclasses. An example is how the Class class inherits all the above instance methods from the Module class and
  implements three additional methods.
=end
Class.instance_methods(false) # => [:new, :allocate, :superclass]

# Nested Classes
=begin
  In Ruby, it’s possible to define classes within other classes. These are called nested classes.
  Nested classes are useful when a class depends on other classes, but those classes aren’t necessarily
  useful anywhere else. They can also be useful when you want to separate classes into
  groups of classes rather than keep them all distinct.
=end

class Drawing
  class Line
  end

  class Circle
  end
end

# From within Drawing, you can access the Line and Circle classes directly, but from outside
# the Drawing class, you can only access Line and Circle as Drawing::Line and Drawing::Circle.
class Drawing
  def Drawing.give_me_a_circle
    Circle.new
  end

  class Line
  end

  class Circle
    def what_am_i
      "This is a circle"
    end
  end
end

a = Drawing.give_me_a_circle
puts a.what_am_i                      # => This is a circle
a = Drawing::Circle.new
puts a.what_am_i                      # => This is a circle
a = Circle.new
puts a.what_am_i                      # => NameError: uninitialized constant Circle



#https://stackoverflow.com/questions/4470108/when-monkey-patching-a-method-can-you-call-the-overridden-method-from-the-new-i
#https://stackoverflow.com/questions/30143217/ruby-monkey-patching-array?rq=1

class Integer
  def to_eng
    if self == 5
      english = 'five'
    elsif self == 199
      english = '199'
    else
      english = "smd"
    end

    english
  end
end

#by extending the Integer class, we can call the to_eng method directly on an integer
#puts 5.to_eng
#puts 58.to_eng
#puts 199.to_eng

#if we created the method as a stand-alone method, we will get an error
def to_engl
  if self == 5
    english = 'five'
  elsif self == 199
    english = '199'
  else
    english = "smd"
  end

  english
end

#puts 5.to_engl #error: 'private moethod 'to_engl' called for 5:Fixnum

#we have to take in a parameter and use it, instead of 'self'
def to_engli(var)
  if var == 5
    english = 'five'
  elsif var == 199
    english = '199'
  else
    english = "smd"
  end

  english
end
#puts to_engli(5) #this is how you have to write it
