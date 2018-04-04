https://practicingruby.com/articles/uses-for-modules-1
https://practicingruby.com/articles/uses-for-modules-2

Modules are used as namespaces and as mixins. This post only covers (briefly) mixins. Using modules for namespacing is well explained in this post at the Practicing Ruby website.

We learned before that Ruby does not support multiple inheritance. However, there are cases where a class would benefit by acquiring methods defined within multiple other classes. That is made possible by using a construct called module. A module is somewhat similar to a class, except it does not support inheritance, nor instantiating. It is mostly used as a container for storing multiple methods. One way to use a module is to employ an include or extend statement within a class. That way, the class gains access to all methods and objects defined within the module. It is said that the module is mixed in the class. So, a mixin is just a module included in a class. A single module can be mixed in multiple classes, and a single class can mix in multiple modules; thus, any limitations imposed by Ruby's single inheritance model are eliminated by the mixin feature.

All modules are instances of the Module class.

module Foo
end

Foo.instance_of? Module  # Output: => true

In the following example, the JapaneseGreetings module is included (as a mixin) in the Person class.

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
p.hello  # Output: Konnichiwa
p.goodbye  # Output: Sayōnara

Modules deserve a post of their own; this is only a brief introduction. 
