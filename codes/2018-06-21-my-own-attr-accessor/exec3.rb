class Person
	puts "at the starting of person class"

	def self.my_attr_reader variable_name
		evaluate_string = "def #{variable_name} \n" +  
		"return @#{variable_name} \n" + 
		"end \n"
		eval(evaluate_string)
	end

	my_attr_reader "name"

	def initialize name, age
		@name = name
		@age = age
	end

	puts "at the end of person class" 

end

person = Person.new("Tushar", 27)
puts(person.name)

Person.my_attr_reader "age"

puts (person.age)
