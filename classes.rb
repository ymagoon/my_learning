#extending classes thta already exist
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

#great, let's create some new classes
class Die
  def roll
    1 + rand(6)
  end
end

dice = Die.new
puts "You rolled a #{dice.roll}"

#let's convert this into code using instance variables
class Die2
  def roll
    @num = 1 + rand(6)
  end

  def show
    @num
  end
end

dice2 = Die2.new
dice2.roll
puts dice2.show

#if we accidentally tried to show the die before we rolled it, we would return nil. We need to initialize a value
#when the object is created
class Die3
  def initialize
    roll #when an object is created, its initialize method (if it has one) is always called.
  end

  def roll
    @num = 1 + rand(6)
  end

  def show
    @num
  end

  def cheat t
    if t.between?(1,6)
      @num = t
    else
      @num = 6
    end
  end
end

die = Die3.new
puts "dice roll #{die.show}"
die.cheat(99)
puts die.show
