#### General ---------------------------------------------------------------------------------------------------------------

### Describe the MVC model
#   The MVC model is architecture used in software development that breaks up a program into three distinct parts: the model,
#   the view, and the controller.
#
#   Model: Maintains the data of the application and the business logic. The model interacts with the database.
#   View: User interface, or the GUI. Displays data from model to the user.
#   Controller: Handles the users' request. Interacts with the database based on the request from the user and renders the view.

### Describe SOLID
#   https://rubygarage.org/blog/solid-principles-of-ood
#
#   In OOP, SOLID is an acronym for five design principles intended to make software designs more understandable, flexible, and
#   maintainable.
#
#   S - Single Responsibility
#   O - Open-Closed Principle
#   L - Liskov Substitution Principle
#   I - Interface Segregation Principle
#   D - Dependency Inversion Principle
#
##  The Single Responsibility Principle (SRP) is the following: “A class should have a single responsibility.” In other words,
#   any complicated classes should be divided into smaller classes that are each responsible for a particular behaviour, making
#   it easier to understand and maintain your codebase. The goal of the SRP principle is to fight complexity that creeps in while
#   you’re developing an application’s logic.
#
##  The Open-Closed Principle (OCP) states that “Modules, classes, methods and other application entities should be open for
#   extension but closed for modification.” Put simply, all modules, classes, methods, etc. should be designed in a modular way
#   so that you (or other developers) are able to change the behavior of the system without changing the source code. The
#   open–closed principle helps developers achieve a flexible system architecture.
#
##  Liskov Substitution Principle (LSP) states that “Subclasses should add to a base class’s behaviour, not replace it.” In a
#   more informal interpretation, the principle states that parent instances should be replaceable with one of their child
#   instances without creating any unexpected or incorrect behaviour. Therefore, LSP ensures that abstractions are correct,
#   and helps developers achieve more reusable code and better organize class hierarchies.
#
##  The Interface Segregation Principle (ISP) states “Clients shouldn’t depend on methods they don’t use. Several client-specific
#   interfaces are better than one generalized interface.” Simply put, main classes should be segregated into smaller specific classes,
#   so their clients use only methods they need. As a result, we get the interfaces segregated according to their purpose, so we
#   avoid “fat” classes and code that’s hard to maintain.
#
##  The Dependency Inversion Principle (DIP) states “High-level modules shouldn’t depend on low-level modules. Both modules should
#   depend on abstractions. In addition, abstractions shouldn’t depend on details. Details depend on abstractions.” The DIP
#   principle is simply the result of strictly following two other SOLID principles: Liskov substitution and open-closed.

### Describe DRY
#   Don't Repeat Yourself (DRY) is a principle of software development aimed at reducing repetition of software patterns,
#   replacing it with abstractions, or repetition of the same data, using data normalization to avoid redundancy. The DRY
#   principle is stated as "Every piece of knowledge must have a single, unambiguous, authoritative representation within a
#   system".
#
#   When the DRY principle is applied successfully, a modification of any single element of a system does not require a change
#   in other logically unrelated elements. Additionally, elements that are logically related all change predictably and uniformly,
#   and are thus kept in sync.

#### Object Oriented ----------------------------------------------------------------------------------------------------

### What is a class?
#   Classes are blueprints used to create a grouping of functions in a single container (object). Classes contain methods
#   (getter or setter methods) that allow us to read or write data to instance variables from outside the class

### What is the difference between a class and a module?
#   A module is somewhat similar to a class, except it does not support inheritance, nor instantiating. It is mostly used as a
#   container for storing multiple classes, methods, and consonants to prevent namespace issues and to allow for the
#   creation of Mixins.

### What is an object?
#   an object is an instance of a class

### Describe inheritance
#    A class that inherits from another class is called a subclass (child class). The class that is inherited (where the inherited
#    components are implemented) is called superclass or parent class.
#
#    Usually, the superclass (parent) is more general and its subclasses (children) add further specialization. For instance, a
#    class called Car may specify that cars have 4 wheels, a steering wheel and so on. This class may inherit from a class called
#    Vehicle that implements the details of combustion engines and will also be inherited by the Motorcycle class.
#
#    Each class can only inherit from one other class.
#
#   Some built-in classes are Array, Bignum, Class, Dir, Exception, File, Fixnum, Float, Integer, IO, Module, Numeric, Object,
#   Range, String, Thread, Time. Some built-in modules are Comparable, Enumerable, GC, Kernel, Math. The BasicObject class is
#   the parent class of all classes in Ruby. Its methods are therefore available to all objects unless explicitly overridden.

### Describe Polymorphism
#   https://robots.thoughtbot.com/back-to-basics-polymorphism-and-ruby
#   At its core, in Ruby, polymorphism means being able to send the same message to different objects and get different results.
#
#   Polymorphism can be achieved through inheritance by creating a parent class with a method (parse) and with two child classes,
#   both overriding the parent classes method (parse). The code will behave differently depending on which child class receives
#   the (parse) method.
#
#   Polymorphism in Ruby can also be achieved with Duck Typing. Duck typing allows us to create two classes with the same method
#   and a third, more generic class (without inheritance). In the generic class, we can take an argument and call the method (parse)
#   on the argument. By passing in an instance of one of our classes, the generic method calls (parse) on it.
#
#   Polymorphism can also be achieved by using design patterns.
#
#   Using polymorphism correctly can simplify code as well as ensure our code satifies SRP from SOLID.

### Describe Encapsulation
#   Encapsulation means that the internal representation of an object is hidden from the outside. Only the object can interact
#   with its internal data. By only exposing the components necessary for interacting with it, we can change methods to suit our
#   needs without having to make the change everywhere.

### Describe abstract classes
#

### How would you declare and use a constructor in Ruby?
#   Constructors are created by defining a method called initialize, which can take parameters

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
#   class Object. Blocks are not objects, nor are parameters.

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
#   A RESTful API is an application program interface (API) that uses HTTP requests to GET, PUT, POST and DELETE data.
#
#   A RESTful API -- also referred to as a RESTful web service -- is based on representational state transfer (REST)
#   technology, an architectural style and approach to communications often used in web services development.
#
#   The basic premise is, instead of relying exclusively on the URL to indicate what webpage you want to go to (and just
#   using the one method), it's a combination of VERB and URL.
#
#   This way, the same URL, when used with a different verb (such as GET, PUT, POST, DELETE), will get you to a different
#   page. This makes for cleaner, shorter URLs, and is particularly adapted to CRUD applications, which most web apps are.

### Describe CRUD verbs and actions.
#   Create
#    - new
#    - create
#   Read
#    - index
#    - show
#   Update
#    - edit
#    - update
#   Delete
#    - destroy

### How should you test routes?
#   Like everything else in your Rails application, you can test your routes. Route tests reside in test/controllers/
#   or are part of controller tests.

### How should you use filters in controllers?
#   Filters are methods that are run "before", "after" or "around" a controller action.

### What are Strong Parameters?
#   With strong parameters, Action Controller parameters are forbidden to be used in Active Model mass assignments until
#   they have been whitelisted. This means that you'll have to make a conscious decision about which attributes to allow
#   for mass update. This is a better security practice to help prevent accidentally allowing users to update sensitive
#   model attributes.

### What do we need to test in controllers?
#?

### How should you use content_for and yield?
#   The content_for method allows you to insert content into a named yield block in your layout. For example,
#   this view would work:
#
#   <html>
#     <head>
#     <%= yield :head %>
#     </head>
#     <body>
#     <%= yield %>
#     </body>
#   </html>
#
#   <% content_for :head do %>
#     <title>A simple page</title>
#   <% end %>
#
#   <p>Hello, Rails!</p>
#
#   The content_for method is very helpful when your layout contains distinct regions such as sidebars and footers that should
#   get their own blocks of content inserted. It's also useful for inserting tags that load page-specific JavaScript or css
#   files into the header of an otherwise generic layout.

### How should you use nested layouts?
#   You may find that your application requires a layout that differs slightly from your regular application layout to
#   support one particular controller. Rather than repeating the main layout and editing it, you can accomplish this by
#   using nested layouts (sometimes called sub-templates).
#
#   <html>
#   <head>
#     <title><%= @page_title or "Page Title" %></title>
#     <%= stylesheet_link_tag "layout" %>
#     <style><%= yield :stylesheets %></style>
#   </head>
#   <body>
#     <div id="top_menu">Top menu items here</div>
#     <div id="menu">Menu items here</div>
#     <div id="content"><%= content_for?(:content) ? yield(:content) : yield %></div>
#   </body>
#   </html>
#
#   <% content_for :stylesheets do %>
#     #top_menu {display: none}
#     #right_menu {float: right; background-color: yellow; color: black}
#   <% end %>
#
#   <% content_for :content do %>
#     <div id="right_menu">Right menu items here</div>
#     <%= content_for?(:news_content) ? yield(:news_content) : yield %>
#   <% end %>
#   <%= render template: "layouts/application" %>

### -----------------------------------------------------------------------------------------------------------------------

### Explain the Active Record pattern.
#   It's an architectural pattern that stores in-memory object data in relational databases. It's an approach to
#   access data from a database. An object instance is mapped to a single row in the table. If a new object is created, a new
#   row is added to the table. If the object is updated then the row corresponding to the object is also updated.

### What is Object-Relational Mapping?
#   It's a technique for converting data between incompatible type systems using object-oriented programming languages. This
#   creates, in effect, a "virtual object database" that can be used from within the programming language.

### Describe Active Record conventions.
#   Activerecord is built on the premise of convention over configuration.
#
#   By default, Active Record uses some naming conventions to find out how the mapping between models and database tables
#   should be created. Rails will pluralize your class names to find the respective database table. So, for a class Book,
#   you should have a database table called books. The Rails pluralization mechanisms are very powerful, being capable of
#   pluralizing (and singularizing) both regular and irregular words. When using class names composed of two or more words,
#   the model class name should follow the Ruby conventions, using the CamelCase form, while the table name must contain the
#   words separated by underscores.
#
#   Active Record uses naming conventions for the columns in database tables, depending on the purpose of these columns.
#   Foreign keys - These fields should be named following the pattern singularized_table_name_id (e.g., item_id, order_id).
#   These are the fields that Active Record will look for when you create associations between your models.
#   Primary keys - By default, Active Record will use an integer column named id as the table's primary key. When using
#   Active Record Migrations to create your tables, this column will be automatically created.

### Explain the Migrations mechanism.
#   Rails provides a domain specific language (DSL) for managing database schema called migrations. Migrations are stored in
#   files which are executed against any database that Active Record supports using rake.
#
#   Rails keeps track of which files have been committed to the database and provides rollback features. To actually create
#   the table, you'd run rails db:migrate and to roll it back, rails db:rollback.

### Describe types of associations in Active Record.
#   In Rails, an association is a connection between two Active Record models. With Active Record associations, we can streamline
#   operations by declaratively telling Rails that there is a connection between the two models.
#
#   Types of associations:
#    - belongs_to
#    - has_one
#    - has_many
#    - has_many :through
#    - has_one :through
#    - has_and_belongs_to_many

### What is Scopes? How should you use it?
#   Scoping allows you to specify commonly-used queries which can be referenced as method calls on the association objects or
#   models. With these scopes, you can use every method previously covered such as where, joins and includes. All scope methods
#   will return an ActiveRecord::Relation object which will allow for further methods (such as other scopes) to be called on it.
#
#   scope :published, -> { where(published: true) }
#
#   Scopes can also take arguments
#
#   scope :created_before, ->(time) { where("created_at < ?", time)

### Explain the difference between optimistic and pessimistic locking.
#   Locking is helpful for preventing race conditions when updating records in the database and ensuring atomic updates.
#   Active Record provides two locking mechanisms:
#    - Optimistic Locking
#    - Pessimistic Locking
#
#   Optimistic locking allows multiple users to access the same record for edits, and assumes a minimum of conflicts with
#   the data. It does this by checking whether another process has made changes to a record since it was opened. An
#   ActiveRecord::StaleObjectError exception is thrown if that has occurred and the update is ignored.
#
#   Pessimistic locking uses a locking mechanism provided by the underlying database. Using lock when building a relation
#   obtains an exclusive lock on the selected rows. Relations using lock are usually wrapped inside a transaction for preventing
#   deadlock conditions.

### Explain what is a sessions mechanism. How does it work?
#   Most applications need to keep track of certain state of a particular user. This could be the contents of a shopping
#   basket or the user id of the currently logged in user. Without the idea of sessions, the user would have to identify, and
#   probably authenticate, on every request. Rails will create a new session automatically if a new user accesses the application.
#   It will load an existing session if the user has already used the application.
#
#   A session usually consists of a hash of values and a session ID, usually a 32-character string, to identify the hash.
#   Every cookie sent to the client's browser includes the session ID. And the other way round: the browser will send it
#   to the server on every request from the client. In Rails you can save and retrieve values using the session method:

### Describe cross-site request forgery, cross-site scripting, session hijacking, and session fixation attacks.
#   Many web applications have an authentication system: a user provides a user name and password, the web application
#   checks them and stores the corresponding user id in the session hash. From now on, the session is valid. On every request
#   the application will load the user, identified by the user id in the session, without the need for new authentication. The
#   session ID in the cookie identifies the session.
#
#   Hence, the cookie serves as temporary authentication for the web application. Anyone who seizes a cookie from someone
#   else, may use the web application as this user - with possibly severe consequences.
#
#   Apart from stealing a user's session ID, the attacker may fix a session ID known to them. This is called session fixation.
#
#   This attack focuses on fixing a user's session ID known to the attacker, and forcing the user's browser into using this ID.
#
#   It is therefore not necessary for the attacker to steal the session ID afterwards. Here is how this attack works:
#   - The attacker creates a valid session ID: They load the login page of the web application where they want to fix the session,
#     and take the session ID in the cookie from the response (see number 1 and 2 in the image).
#   - They maintain the session by accessing the web application periodically in order to keep an expiring session alive.
#   - The attacker forces the user's browser into using this session ID (see number 3 in the image). As you may not change a
#     cookie of another domain (because of the same origin policy), the attacker has to run a JavaScript from the domain of
#     the target web application. Injecting the JavaScript code into the application by XSS accomplishes this attack. Here is
#     an example: <script>document.cookie="_session_id=16d5b78abb28e3d6206b60f22a03c8d9";</script>.
#   - The attacker lures the victim to the infected page with the JavaScript code. By viewing the page, the victim's browser
#     will change the session ID to the trap session ID.
#   - As the new trap session is unused, the web application will require the user to authenticate.
#   - From now on, the victim and the attacker will co-use the web application with the same session: The session became valid
#     and the victim didn't notice the attack.
#
#   Cross-site request forgery (CSRF) works by including malicious code or a link in a page that accesses a web application
#   that the user is believed to have authenticated. If the session for that web application has not timed out, an attacker
#   may execute unauthorized commands.
#
#   The most widespread, and one of the most devastating security vulnerabilities in web applications is XSS. This malicious attack
#   injects client-side executable code.
#
#   An attacker injects some code, the web application saves it and displays it on a page, later presented to a victim. Most
#   XSS examples simply display an alert box, but it is more powerful than that. XSS can steal the cookie, hijack the session,
#   redirect the victim to a fake website, display advertisements for the benefit of the attacker, change elements on the web
#   site to get confidential information or install malicious software through security holes in the web browser.

### What is the difference between SQL Injection and CSS Injection?
#   SQL injection attacks aim at influencing database queries by manipulating web application parameters. A popular goal of
#   SQL injection attacks is to bypass authorization. Another goal is to carry out data manipulation or reading arbitrary data.

### How should you store secure data such as a password?
#   It's better to use something like OAuth, which is one-way encryption. But, if that is not an option, store them encrypted.

### Why do we need to use HTTPS instead of HTTP?
#   HTTPS pages typically use one of two secure protocols to encrypt communications - SSL (Secure Sockets Layer) or
#   TLS (Transport Layer Security). Both the TLS and SSL protocols use what is known as an 'asymmetric' Public Key
#   Infrastructure (PKI) system. An asymmetric system uses two 'keys' to encrypt communications, a 'public' key and a
#   'private' key. Anything encrypted with the public key can only be decrypted by the private key and vice-versa.

### What is unit testing (in classical terms)?
#   Unit testing is a software development process in which the smallest testable parts of an application, called units,
#   are individually and independently scrutinized for proper operation. Unit testing can be done manually but is often
#   automated.

### What is the primary technique for writing a test?
#   Test driven development?

### What are your favorite tools for writing unit tests?
#   Rspec

### What are your favorite tools for writing feature tests?


### What is a code smell?
#   Any characteristic in the source code of a program that possibly indicates a deeper problem. Another way to look at
#   smells is with respect to principles and quality: "Smells are certain structures in the code that indicate violation
#   of fundamental design principles and negatively impact design quality".[3] Code smells are usually not bugs; they are not
#   technically incorrect and do not prevent the program from functioning. Instead, they indicate weaknesses in design that
#   may slow down development or increase the risk of bugs or failures in the future.

### What are your favorite tools to find code smells and potential bugs?
#   Bullet, Breakman, Rubocop

### Why should you avoid fat controllers?
#   In practice, this can require a range of different types of refactoring, but it all comes down to one idea: by moving
#   any logic that isn’t about the response (for example, setting a flash message, or choosing whether to redirect or render
#   a view) to the model (instead of the controller), not only have you promoted reuse where possible but you’ve also made
#   it possible to test your code outside of the context of a request.

### Why should you avoid fat models?
#   Organize code into gems and reuse it!

### Explain extract Value, Service, Form, View, Query, and Policy Objects techniques.
#   https://www.sitepoint.com/7-design-patterns-to-refactor-mvc-components-in-rails/
#
#   Service Objects are created when an action:
#   - is complex (such as calculating an employee’s salary)
#   - uses APIs of external services
#   - clearly doesn’t belong to one model (for example, deleting outdated data)
#   - uses several models (for example, importing data from one file to several models)
#
#   The Value Object design pattern encourages simple, small objects (which usually just contain given values), and lets you
#   compare these objects according to a given logic or simply based on specific attributes (and not on their identity).
#   Examples of values objects are objects representing money values in various currencies. We could then compare these value
#   objects using one currency (e.g. USD). Value objects could also represent temperatures and be compared using the Kelvin
#   scale, for instance.
#
#   Form Object is a design pattern that encapsulates logic related to validating and persisting data.
#
#   Query Object is a design pattern that lets us extract query logic from Controllers and Models into reusable classes.
#
#   A View Object allows us to take data and calculations that are needed only for surfacing a representation of the Model
#   in the View – such as an HTML page for a website or a JSON response from an API endpoint – out of the Controller and Model.
#
#   The Policy Objects design pattern is similar to Service Objects, but is responsible for read operations while Service
#   Objects are responsible for write operations. Policy Objects encapsulate complex business rules and can easily be
#   replaced by other Policy Objects with different rules. For example, we can check if a guest user is able to retrieve
#   certain resources using a guest Policy Object. If the user is an admin, we can easily change this guest Policy Object
#   to an admin Policy Object that contains admin rules.
