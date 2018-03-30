#this won't work because we have double quotes around the entire string and double
#quotes around steak. Ruby interprets this as two separate strings with an unidentified
#variable (steak) in between.

#stomach_contents = "Bacon 'ipsum dolor' sit amet venison\n fatback pig, prosciutto/pork belly jowl.\n
#Beef kielbasa leberkas, shank t-bone doner strip "steak" pork loin. Doner hamburger"

#if we fix this by changing steak to single quotes
#stomach_contents = 'Bacon 'ipsum dolor' sit amet venison\n fatback pig, prosciutto/pork belly jowl.\n
#Beef kielbasa leberkas, shank t-bone doner strip 'steak' pork loin. Doner hamburger'

#now, the entire string is single quote, but so is ipsum dolor
#also, since we are using single quotes the \n character cannot be rendered correctly

#example of how to fix this
#` “"Pigs" is double quoted, and this is a backslash \” `

#stomach_contents = '"Pigs" is double quoted, and this is a backslash \" '
#puts stomach_contents

#it's very common to build strings using string interpolation. 
# code inside #{} is executed, and the returned value is inserted into the string
#worst_days = "Monday"
#day = 1
#puts "#{worst_days}s are the worst because it's the #{day}st day of the week!"

#the following lines are going to contain tons of examples of using functions on strings!

#string * integer outputs the string integer number of times
puts "Ho! " * 3
puts "Ho! " * 0

#concatenation combines two strings together
puts "Hello from the " + "moon"
puts "Hello from " + self.to_s

a = "hello "
puts a << "world"
puts a.concat(" I am George!")

#comparing strings using <=> returns -1, 0, 1, or nil depending on whether string is less than, equal to, or greater than the other string
puts "abcdef" <=> "abcde" #returns 1 because >
puts "abcdef" <=> "abcdef" #returns 0 because ==
puts "abcdef" <=> "Abcdef" #returns 1
puts "abcdefg" <=> "abdfefgh" #returns -1 because <
puts "a" <=> 1 #returns nil because string is not comparable to integer

#strings are objects and can be accessed as such
string = "I am a string 19 times over"
puts string[0] #returns substring of a single character
puts string[0,4] #returns substring containing length characters starting at start [start,length]
puts string[0..12] #returns a range between 1 and 4
puts string[0..-1] #if an index is negative, it starts counting at the end of the string
puts string[/\d+/] #matching portion of the string is returned, aka the digits

puts string["times"] #returns argument if it is found in the string, otherwise it returns nil

#controling the case of a string can be done with three different functions
puts "hello".capitalize #capitalizes the first word
puts "hello WORLD how Are You?".capitalize #returns string with first word capitalized and the rest lowercase
puts "HELLO WORLD".downcase #returns str with all uppercase letters replaced with lowercase counterparts
puts "hello world".upcase #does same as downcase, but in reverse

#returns an array of characters in the string. Shorthand for string.each_char.to_a
puts "test 123".chars.inspect
puts "test 123".split('').inspect #alternate way to write this

#removing characters from the end of an array with chomp
puts "hello".chomp #nothing to remove
puts "hello\n".chomp.inspect #removes \n character
puts "hello\r".chomp.inspect #removes \r character (carage return)
puts "hello\r\n".chomp.inspect #removes them both
puts "hello\n\r".chomp.inspect #only removes carrigae return
puts "hello bitch".chomp(" bitch").inspect #removes any character defined

#empty a string and or removing characters from it
puts "I a boss and no one can touch me".clear
puts "I am a boss and no one can touch me".delete "o"

#finding whether a string is empty or not
puts "".empty?
puts "not empty".empty?

#starts with and ends with
puts "hello".end_with?("ello") #true
puts "hello".end_with?("heaven","cows") #false, returns true if one of suffixes match
puts "hello".end_with?("heaven", "ello") #true

puts "hello".start_with?("hel") #true
puts "hello".start_with?("dog","cat") #false

#string =~ Regexp expression returns the index of the string where it is true. 
puts "a okay" =~ /okay/ #returns 2, that is where okay starts
puts "a okay" =~ /\w+/ #returns 0 because that is where all strings start
puts "a okay" =~ /\d/ #returns nil because there are no digits in this string

puts "a okay".match(/\w+\s+\w+/) #returns "a okay" because the patern matches!

#returns a string replacing matched text with second argument. If there is no second argument (''), then the text returns with characters removed
puts "hello".gsub(/[aeiou]/,'') #removes all vowels from text
puts "hello".gsub(/[^aeiou]/,'') #removes al consonants from text
puts "hello".gsub(/[aeiou]/,'*') #returns text with vowels replaced with asterisks (*)

puts "hello".gsub(/[aeiou]/) {|s| (s.ord + 2).chr} #applies block to matching string and returns entire string

test_hash = {'e' => "!", 'o' => "*"}

puts "hello".gsub(/[eo]/, test_hash) #if argument is hash, and the string matches one of hashes keys, returns replacement string

#hex takes a hexadecimal string and converts it into hex
puts "00A0FF".hex
puts "r:" + "00".hex.to_s + " g:" + "A0".hex.to_s + " b:" + "FF".hex.to_s #this is useful for hex -> rgb color conversions

#include is used to determine whether a series of characters is part of a string
puts "hello".include?("llo")

#the index method returns the index of the supplied string
puts "hello".index('e') #returns 1
puts "hello".index('a').inspect #returns nil if nothing is found
puts "hello".index(?e) #regexp
puts "hello".index(/[aeiou]/,2) #starts searching at position 2, returns 4 because of index of letter 'o'

puts "cat in the hat".index("a") #finds first index
puts "cat in the hat".rindex("a") #returns last index of argument, if found

#replace
puts "hello".replace("world") #replaces a string with argument, if found
puts "hello".gsub(/hello/,"world") #this can also be done using regex expressions
puts "hello"["hello"] = "world" #another easy way to do this

puts "hello i like saying hello".replace("world") #replaces the ENTIRE string with the word
puts "hello i like saying hello".gsub(/hello/,"world") #replaces ONLY the matching text
puts "hello i like saying hello"["hello"] = "world" #finds first instance and returns replacement (acts just like replace method)

#there are a variety of ways to insert characters into a string
puts "abd".insert(2,"c") #insert needs to be used very carefully during an iteration

#removing whitespaces
puts "   hello.".lstrip #left strip
puts "   hello.   ".rstrip #right strip
puts "   hello.   ".strip #removes trailing and leading white space
puts "  hello I am no white spaces  ".gsub(/\s+/,'') #removes all spaces in all text

#scanning a string - iterates through str, matching a pattern. For each match, 
#a result is generated and either added to an array or passed to a block (if present)
str = "a cruel world"
puts str.scan(/\w+/).inspect
puts str.scan(/.../).inspect
puts str.scan(/(...)/).inspect

#block form
cnt = 0
str.scan(/.../) { |w| cnt += 1}
puts cnt
cnt2 = 0
str.scan("l") {cnt2 += 1}
puts cnt2

