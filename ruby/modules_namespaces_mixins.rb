=begin
  Ruby does not support multiple inheritance. However, there are cases where a class would benefit by acquiring
  methods defined within multiple other classes. That is made possible by using a construct called module. A module
  is somewhat similar to a class, except it does not support inheritance, nor instantiating. It is mostly used as a
  container for storing multiple classes, methods, and consonants to prevent namespace issues and to allow for the
  creation of Mixins.
=end

# Module declaration looks just like class declaration except using the module keyword
module Foo
end

# All modules are instances of the Module class.
Foo.instance_of? Module  # => true

# Modules can be used to store any sort of information like classes, methods, constants, or even other modules
module Document
  class PDF
    def generate
      # ...
    end
  end

  class XML
    def generate
      # ...
    end
  end

  def send_to(destination)
    # ...
  end
end

# Modules and Namespacing
=begin
  One way to use a module is as a namespace. A common use of Ruby is to include code situated in other files into the
  current program. When including other files, you can quickly run into conflicts.
=end

# Class to generate XML documents for an XML generatoin library
class Document
  def generate
    # ...
  end
end

require 'pdf_lib'
require 'xml_lib'

document = Document.new
# do something with document
puts document.generate

# Now, what if you were using another library that generates PDF documents with a class of the same names
document = Document.new
# do something with document
puts document.generate

=begin
  Both lbraries are loaded which both contain a Document class. Ruby does not throw an error if two classes with
  the same name are defined. Ruby would actually applies the definitions of Document one after the other, with
  whatever file was required last taking precedence. The end result would in all likelihood be a very broken Document
  class that could generate neither XML nor PDF.
=end

# Modules provide namespaces to avoid this type of conflict. Notice both classes are still called Document
module XML
  class Document
    # ...
  end
end

module PDF
  class Document
    # ...
  end
end

# Explicitly include the namespace when referring to the Document library
require 'xml_lib'
require 'pdf_lib'

# Even though the Document class is the same, this pair of calls refer to two completely different classes
pdf_document = PDF::Document.new
xml_document = XML::Document.new

# One more example
module Toolbox
  class Ruler
    attr_accessor :length
  end
end

module Country
  class Ruler
    attr_accessor :name
  end
end

a = ToolBox::Ruler.new
a.length = 50

b = Country::Ruler.new
b.name = "Ghengis Khan from Moskau"

=begin
  Another way to use a module is to employ an include or extend statement within a class. That way, the class gains
  access to all methods and objects defined within the module. It is said that the module is mixed in the class.
=end

# In the following example, the JapaneseGreetings module is included (as a mixin) in the Person class.

module JapaneseGreetings
  def  hello
    puts "Konnichiwa"
  end

  def goodbye
    puts "Sayōnara"
  end
end

class Person
  include JapaneseGreetings
end

p = Person.new
p.hello           # => Konnichiwa
p.goodbye         # => Sayōnara

# All of the classes and methods available in JapaneseGreetings are available in the Person class
# because include takes a module and includes its contents into the current scope

# Including Enumerable
=begin
  The Array class has pre-included the methods provided by the Enumerable module, a module that supplies about 20
  useful counting- and iteration-related methods, including collect, detect, find, find_all, include?, max, min,
  select, sort, and to_a. All of these use Array’s each method to do their jobs, and if your class can implement an each
  method, you can include Enumerable, and get all those methods for free in your own class!
=end

# Basic example showing the each method can be used on arrays without any extra work
[1,2,3,4,5].each { |number| print "#{number} " }        # => 1 2 3 4 5

# If we create our own class and want to iterate over a sample of data
class Vowels
  @@vowels = %w{a e i o u}

  def initialize
    # ...
  end
end

vowels = Vowels.new
vowels.each { |v| puts v }      # => NoMethodError: undefined method `each' for #<AllVowelsTest:0x00000001a08510>

# You can implement an each method that uses Enumerable's each method
class Vowels
  @@vowels = %w{a e i o u}

  def each
    @@vowels.each { |v| yield v }
  end
end

vowels = Vowels.new
vowels.each { |v| puts v }      # => "a", "e", "i", "o", "u"

# Including Enumerable
class Vowels
  include Enumerable
  @@vowels = %w{a e i o u}

  def each
    @@vowels.each { |v| yield v }
  end
end

# By including Enumerable, we now have access to every method it contains!
vowels = Vowels.new
vowels.map { |v| v + 'x' }    # => "ax", "ex", "ix", "ox", "ux"

# Including Comparable
=begin
  The Comparable module operators such as <, <=, ==, >=, and >, as well as the between? method that returns
  true if the value is between (inclusively) the two parameters supplied (for example, 4.between?(3,10) == true).
  To provide these methods, the Comparable module uses the <=> (spaceship) comparison operator on the class that
  includes it. <=> returns -1 if the supplied parameter is higher than the object’s value, 0 if they are equal,
  or 1 if the object’s value is higher than the parameter.
=end
class Song
  include Comparable
  attr_accessor :length

  def <=>(other)
    @length <=> other.length
  end

  def initialize(song_name, length)
    @song_name = song_name
    @length = length
  end
end

a = Song.new('Rock around the clock', 143)
b = Song.new('Bohemian Rhapsody', 544)
c = Song.new('Minute Waltz', 60)

a < b                         # => => true
b >= c                        # => => true
c > a                         # => => false
a.between?(c,b)               # => => true

# Another, slightly more complex example
class Computation
  include Comparable

  def initialize(&block)
    @action = block
  end

  def result
    @result ||= @action.call
  end

  def <=>(other)
    return  0 if result == other.result
    return  1 if result > other.result
    return -1 if result < other.result
  end
end

a = Computation.new { 1 + 1 }
b = Computation.new { 4*5 }
c = Computation.new { -3 }

p a < b  #=> true
p a <= b #=> true
p b > c  #=> true
p b >= c #=> true
p a == b #=> false

=begin
  The first new thing is just an include statement that tells Ruby to mix the Comparable functionality into the Computation
  class definition. But in order to make use of the mixin, we need to tell Comparable how to evaluate the sort order of our
  Computation objects, and that’s where <=> comes in.

  The <=> method, sometimes called the spaceship operator, essentially fills in a template method that allows Comparable to
  work. It codifies the notion of comparison in an abstract manner by expecting the method to return -1 when the current object
  is considered less than the object it is being compared to, 0 when the two are considered equal, and 1 when the current object
  is considered greater than the object it is being compared to.
=end

# So, a mixin is just a module included in a class. A single module can be mixed in multiple classes, and a single class can mix
# in multiple modules; thus, any limitations imposed by Ruby's single inheritance model are eliminated by the mixin feature.


#keep everything below, but it needs to be better explained so I can understand it....

# Namespacing actually applies to the way constants are looked up in Ruby in general, not classes in particular.
# This means that it applies to modules nested within modules as well as ordinary constants as well.

module A
  module B
  end
end

p A::B        # => A::B

module A
  C = 10
end

p A::C        # => 10

=begin
  This same behavior of using modules as namespaces applies just as well to classes

  Nesting a class within a class does not in any way make it a subclass or establish
  any relationship between Blog and Blog::Comment except that Blog::Comment is within the Blog namespace.
=end
class Blog
  class Comment
    #...
  end
end

blog = Blog.new
comment = Blog::Comment.new   # looks the same as a class nested within a module

# Constants are looked up from the innermost nesting to the outermost, finally searching the global namespace.
module FancyReporter
  class Document
    def initialize
       @output = String.new
    end

    attr_reader :output
  end
end

# Inspecting an instance of Document shows its output class
FancyReporter::Document.new.output.class      # => String

# If we then have the code below, it creates all sorts of issues with the String class
module FancyReporter
  module String
    class Formatter
    end
  end
end

# You cannot even create an instance of Document before the following error is raised:
FancyReporter::Document.new     # => NoMethodError: undefined method `new' for FancyReporter::String:Module

# The best way to avoid this problem is to just pick a new name. But, we can also use explicit constant lookup
module FancyReporter
  class Document
    def initialize
       @output = ::String.new
    end

    attr_reader :output
  end
end

=begin
  Prepending any constant with :: will force Ruby to skip the nested namespaces and bubble all the way up to the root.
  In this sense, the difference between A::B and ::A::B is that the former is a sort of relative lookup whereas the
  latter is absolute from the root namespace.
=end


https://practicingruby.com/articles/uses-for-modules-1
https://practicingruby.com/articles/uses-for-modules-2
https://practicingruby.com/articles/uses-for-modules-3
https://practicingruby.com/articles/uses-for-modules-4
