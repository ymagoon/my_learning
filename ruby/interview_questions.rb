### What is a class?
#   Classes are blueprints used to create a grouping of functions in a single container (object). Classes contain methods
#   (getter or setter methods) thta allow us to read or write data to instance variables from outside the class

### What is the difference between a class and a module?
#   A module is somewhat similar to a class, except it does not support inheritance, nor instantiating. It is mostly used as a
#   container for storing multiple classes, methods, and consonants to prevent namespace issues and to allow for the
#   creation of Mixins.

### What is an object?
#   an object is an instance of a class

### How would you declare and use a constructor in Ruby?
#   Constants are declared in all capital letters like IM_A_CONSTANT. They are supposed to, well, remain constant
#   but that is not enforced. Instead, the compiler just gives you a warning.

### How would you create getter and setter methods in Ruby?
#   you can use the attr_accessor method followed by a symbol for the method you want to create, alternatively you can
#   do it manually def blah or def blah=()

### Describe the difference between class and instance variables?
#   a class is the blueprint, or a container that determines what methods, constants, etc that the portion of code can do.
#   an instance is an in memory representation of the class. It has state

### What are the three levels of method access control for classes and what do they signify?
#   access control methods signify the visibility of methods to the rest of our program. The three control methods are
#   public, private and protected.
#   Public methods can be accessed from outside the class
#   private methods cannot be accessed outside the class
#   protected methods cannot be accessed outside the class, except with an explicit receiver
#   private, public, and protected methods are inherited by a class

### What does ‘self’ mean?
#   The self keyword is always available, and it points to the current object. In Ruby, all method calls consist of a message sent to a
#   receiver. In other words, all methods are invoked on an object. The object on which the method is called is the receiver, and the method
#   is the message. If we call "foo".upcase, the "foo" object is the receiver and upcase is the message. If we don't specify an object
#   (a receiver) when calling a method, it is implicitly called on the self object.
#
#   When inside an instance method, the self keyword refers to that specific instance.
#   When inside a class (like a class method self.feed), the self keyword refers to the class

### Explain how (almost) everything is an object in Ruby.
#   Almost everything in ruby is an object. Numbers, strings, arrays, ranges, etc. They all inherit from the base
#   class Object.

### Explain what singleton methods are. What is Eigenclass in Ruby?
#   A singleton method is a method that is implemented only on a single object.
#
#   There is an apparent contradiction. Ruby stores methods in classes and all methods must be associated with a class. The object on
#   which a singleton method is defined is not a class (it is an instance of a class). If only classes can store methods, how can an
#   object store a singleton method? When a singleton method is created, Ruby automatically creates an anonymous class to store that
#   method. These anonymous classes are called metaclasses, also known as singleton classes or eigenclasses. The singleton method is
#   associated with the metaclass which, in turn, is associated with the object on which the singleton method was defined.
#
#   If multiple singleton methods are defined within a single object, they are all stored in the same metaclass.
#
#   def z1.say_hello  # Notice that the method name is prefixed with the object name
#     puts "Hello!"
#   end
#
#   Alternatively, you can define a singleton method like this:
#   z1.define_singleton_method(:say_hello) { puts "Hello!" }

### Describe available Ruby callbacks. How can we use them in practice?
#   TODO

### What is the difference between Proc and lambda?
#   A closure is a method with the following characteristics:
#    1. It remembers the values of all variables that were available in the scope it was defined, even when called on another
#       scope or when those variables are no longer available.
#    2. It is an object. Hence, it can be assigned to a variable, passed around, called from within different scopes, etc.
#
#   Blocks are not objects, cannot be assigned to variables. Unlike procs which have the Proc.new method, there is no
#   Block.new method. Blocks also don't have a call method.
#
#   Procs are very similar to blocks, with a few important differences:
#    1. Unlike blocks, procs are objects and can be assigned to variables.
#    2. Procs are closures, blocks are not (as seen above).
#    3. Unlike blocks, we can pass multiple Procs to a method as arguments.
#
#   A proc handles arguments with greater flexibility than a method or a lambda. In addition to defaulting missing argument
#   values to nil, a proc also silently discards unexpected arguments, implicitly unpacks arrays of arguments, etc. This behavior
#   an be useful in some cases, but it usually makes it harder to notice and debug argument mismatches.
#
#   Another important difference between a proc and a method or lambda is the way in which they handle the return statement.
#   If a method is defined inside another method, the return statement in the inner method exits only from the inner method itself,
#   then the outer method continues executing. The same goes for defining a lambda within a lambda, a lambda inside a method or a method
#   within a lambda. However, when a proc is defined within a method, the return statement will exit from the proc as well as the outer
#   (enclosing) method.
#
#   Lambdas are anonymous functions, which means they are functions with no name. They are objects and therefore can be stored inside
#   variables and passed around.
#
#   Lambdas are instances of the Proc class.
#
#   Return statement behavior: Like a method, a lambda can return a value using the return statement. A proc cannot do that. Also,
#   when a return statement is reached within a lambda, it will return execution to the outer method on which it was defined. When a
#   Proc encounters a return statement, it will exit from both the proc itself and the enclosing method (method on which the proc was defined).
#
#   Handling missing arguments: When a lambda expects arguments and we don't provide them, or we provide the wrong number of arguments,
#   an exception is thrown. When a Proc expects an argument and doesn't receive it, it runs and defaults the missing argument value to nil.

### What is RubyGems? How does it work?
#   It's a package manager that provides a standard format for distributing ruby programs and libraries

### How can you build your own Ruby gem?
#   It's as simple as creating the file structure for them gem, completing the .gemspec and wabang!

### Explain the structure of a Ruby gem.
#   the .gemspec is in the root directory while there is a lib, spec, bin folder. All the code for the gem goes in
#   the lib folder. There is one index file with the same name as the gem name and the rest of the gems are included
#   in the index gem file.
#   https://guides.rubygems.org/make-your-own-gem/

### Can you give me some examples of your favorite gems besides Ruby on Rails?
#   nokogiri - I like scraping

### -----------------------------------------------------------------------------------------------------------------------

### What is ActiveJob? When should we use it?
#   Active Job is a framework for declaring jobs and making them run on a variety of queuing backends. These jobs can be
#   everything from regularly scheduled clean-ups, to billing charges, to mailings. Anything that can be chopped up into
#   small units of work and run in parallel, really.

### What is Asset Pipeline?
#   The asset pipeline can be thought of as the tools and mechanisms by which Javascript files, stylesheets, and images are
#   processed and prepared for use by the browser. These processes can minify and compress assets, as well as pre-process assets
#   that are written in other languages such as Coffeescript or Sass.
#
#   The asset pipeline was created to solve a variety of problems related to static assets. One such issue is that each asset
#   specified separately in the HTML markup must be retrieved separately, resulting in a higher number of HTTP requests and,
#   in the end, a longer load time. Raw Javascript and CSS files can also waste a lot of bandwidth with comments, extra white
#   space, and long variable names. Another issue that comes up involves caching. When you serve up a Javascript file from your
#   server, for example, the browser will automatically cache that file for a period of time. That improves page load time, but
#   what if that asset changes at a later point in time? The browser won’t know about it, so it will continue to use the cached
#   asset until its cache life has expired.

### Explain the difference between Page, Action, Fragment, Low-Level, SQL caching types.
#   Page caching has been removed in Rails 4
#   Action caching has been removed in Rails 4
#
#   Dynamic web applications usually build pages with a variety of components not all of which have the same caching
#   characteristics. When different parts of the page need to be cached and expired separately you can use Fragment Caching.
#
#   Fragment Caching allows a fragment of view logic to be wrapped in a cache block and served out of the cache store
#   when the next request comes in.
#
#   Sometimes you need to cache a particular value or query result instead of caching view fragments. Rails' caching mechanism
#   works great for storing any kind of information.
#
#   The most efficient way to implement low-level caching is using the Rails.cache.fetch method. This method does both reading
#   and writing to the cache. When passed only a single argument, the key is fetched and value from the cache is returned. If a
#   block is passed, that block will be executed in the event of a cache miss. The return value of the block will be written to
#   the cache under the given cache key, and that return value will be returned. In case of cache hit, the cached value will be
#   returned without executing the block.
#
#   Query caching is a Rails feature that caches the result set returned by each query. If Rails encounters the same query again
#   for that request, it will use the cached result set as opposed to running the query against the database again.

### What is a Rails engine?
#   Engines can be considered miniature applications that provide functionality to their host applications. A Rails application
#   is actually just a "supercharged" engine, with the Rails::Application class inheriting a lot of its behavior from
#   Rails::Engine.

### -----------------------------------------------------------------------------------------------------------------------

### Provide an example of RESTful routing and controller.

### Describe CRUD verbs and actions.

### How should you test routes?

### How should you use filters in controllers?

### What are Strong Parameters?

### What do we need to test in controllers?

### How should you use content_for and yield?

### How should you use nested layouts?

### Explain the Active Record pattern.

### What is Object-Relational Mapping?

### Describe Active Record conventions.

### Explain the Migrations mechanism.

### Describe types of associations in Active Record.

### What is Scopes? How should you use it?

### Explain the difference between optimistic and pessimistic locking.

### Explain what is a sessions mechanism. How does it work?

### Describe cross-site request forgery, cross-site scripting, session hijacking, and session fixation attacks.

### What is the difference between SQL Injection and CSS Injection?

### How should you store secure data such as a password?

### Why do we need to use HTTPS instead of HTTP?

### What is unit testing (in classical terms)?

### What is the primary technique for writing a test?

### What are your favorite tools for writing unit tests?

### What are your favorite tools for writing feature tests?

### What is a code smell?

### What are your favorite tools to find code smells and potential bugs?

### Why should you avoid fat controllers?

### Why should you avoid fat models?

### Explain extract Value, Service, Form, View, Query, and Policy Objects techniques.

