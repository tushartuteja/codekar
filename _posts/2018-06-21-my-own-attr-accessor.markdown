---
layout: post
title:  "Ruby's eval, attr_accessor, attr_reader, and  attr_writer; Rails has_many, has_one, belongs_to"
date:   2018-06-21 12:37:47 +0530
categories: ruby rails
comments: true
tags: eval, attr_accessor, attr_reader, attr_writer, rails, has_many, has_one, belongs_to
---

This is my first blog post and the only post right now :) , it covers a variety of topics needed to understand how attr_accessor in Ruby works or how has_many works in an Active Record association. I would recommend you to code alongside while following this post. I have attached code links with code snippets as well.

# 1 The eval Function
One of the most amazing functions that I find in Ruby Programming Language is the eval function. There is so much one can do with it. 
eval takes a string as input and evaluates that string as code. 

Eg. the follwing code. 
{% highlight ruby %}

while true
        print(">>>")
        read_input = gets
        puts eval(read_input)
end

{% endhighlight %}
I saved the above code and I ran it in my terminal

![My helpful screenshot]({{ "/images/2018-06-21-my-own-attr-accessor/eval.gif" | absolute_url}})


The above code is a basic Ruby REPL(Read Evaluate Print Loop) like `irb`. It can only evaluate a single line and forgets what was declared in the previous line. Still powerful enough for a 5 line 91 characters code. 

# 2 Everything in Ruby is executed. 

We all know ruby is a dynamically typed interpreted language and everything is executed in Ruby. This part is just to emphasise the fact that indeed everything is executed in Ruby.


Eg. 

{% highlight ruby %}

class Person
	puts "at the start of person class"
end

{% endhighlight %}

If I save and run the above code I get the following output.
![My helpful screenshot]({{ "/images/2018-06-21-my-own-attr-accessor/exec1.png" | absolute_url}})


Ruby started loading the Person class and encountered a puts statement, and it ran the put statement. 
Let's add a few more lines to our code. 

{% highlight ruby %}
class Person
	puts "at the starting of person class"

	def initialize name, age
		@name = name
		@age = age
	end

	puts "at the end of person class" 

end


{% endhighlight %}

Output: 

![My helpful screenshot]({{ "/images/2018-06-21-my-own-attr-accessor/exec2.png" | absolute_url}})

We all know that we cannot access name and age of an instance of the Person class as they are private variables, and we need to define getters and setters for it. 
One way is to define your own getter and setter, the other way is to use attr_accessor. We won't be using any of it, just see the following code. 


{% highlight ruby %}
class Person
        puts "at the starting of person class"


        ###### Look Here ######## 
        def self.my_attr_reader variable_name
                evaluate_string = "def #{variable_name} \n" +
                "return @#{variable_name} \n" +
                "end \n"
                eval(evaluate_string)
        end

        my_attr_reader "name"
        ###### Code in discussion Ends ##########

        def initialize name, age
                @name = name
                @age = age
        end

        puts "at the end of person class"

end

person = Person.new("Tushar", 27)
puts(person.name)

{% endhighlight %}

Output: 

![My helpful screenshot]({{ "/images/2018-06-21-my-own-attr-accessor/exec3.png" | absolute_url}})


I added a class method `my_attr_reader`, used `self` keyword to do it. We'll discuss `self` keyword in another blog. You just need to know that the `self` keyword here is used to describe a class method. The `self` keyword is a long blog post in itself.  

As soon as I defined my_attr_reader, I called it with "name" argument, and it evaluated the following string as code. The following code is added to the class at runtime. 
This is a very powerful tool and a lot of things are build over the similar concept. And hence we defined our own attr_reader method, you may do the same for attr_accessor and attr_writer methods, you may define your own. 

{% highlight ruby %}

def name
	return @name
end

{% endhighlight %}

After the class is defined and `name` is printed, now I want to print the age, and there is no getter method for the age. 
I can call the my_attr_reader method at runtime to create the getter for `age`. Look at the following code and output. 

{% highlight ruby %}
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


###### Look Here ######## 
Person.my_attr_reader "age"
puts (person.age)

###### Code in discussion Ends ##########

{% endhighlight %}

Output:

![My helpful screenshot]({{ "/images/2018-06-21-my-own-attr-accessor/exec4.png" | absolute_url}})


Voila!!! It works, it works as we were able to change the Person class at runtime, and we added a getter after the person object was made. we'll discuss openness of classes in Ruby in another post. 

One thing to note is that we cannot call Ruby's attr_accessor, and the likes of it from outside of the class, as it is a private method. `Person.attr_reader` would give you an exception. 

# 3 Rails has_many, has_one, belongs_to

I think by now you guys would have figured out how has_many, has_one and belongs_to work. 
It would be a good assignment for your guys to write your own has_many, has_one and belongs_to function. 

Ping me if you have any doubts.


See you next week with some more random concepts, I'll try to find some order in them. 
You may comment a topic for my next blog post.

<div id="disqus_thread"></div>
<script>

/**
*  RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.
*  LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables*/
/*
var disqus_config = function () {
this.page.url = PAGE_URL;  // Replace PAGE_URL with your page's canonical URL variable
this.page.identifier = PAGE_IDENTIFIER; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
};
*/
(function() { // DON'T EDIT BELOW THIS LINE
var d = document, s = d.createElement('script');
s.src = 'https://codekar-com.disqus.com/embed.js';
s.setAttribute('data-timestamp', +new Date());
(d.head || d.body).appendChild(s);
})();
</script>
<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
                            