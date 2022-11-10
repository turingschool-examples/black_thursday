## Black Thursday

Find the [project spec here](http://backend.turing.io/module1/projects/black_thursday/).

# Braxton, Kyle, Nigel, Kara

## Reflection Questions


What was the most challenging aspect of this project?

  - Setting up the sales engine in the beginning was difficult. Sticking to TDD throughout, especially when refactoring and pulling methods
    across classes.

What was the most exciting aspect of this project?

  - The use of modules. The complex interaction between classes when they know each other/ how they connect.

Describe the best choice enumerables you used in your project. Please include file names and line numbers.

  - sales_analyst.rb, line 179: we used each with object, instead of declaring a hash accumulator.
  - We used many find all methods: in the repository files and sales engine to find all items, merchants, invoices, etc. by id.
  - sales_analyst line 185: we used sort_by on to sort through the merchant revenue hash, sorting the values in the hash
  - Repo queries file in the modules directory, line 31: we used the foreach to iterate through the csv file instead of using open.

Tell us about a module or superclass which helped you re-use code across repository classes. Why did you choose to use a superclass and/or a module?
  - Repo_queries in the modules directory: Our repos had similar behavior so we found the methods that were practically identical and put them in to a module
  - Calculations file in the modules directory: Use math formulas for the standard deviation and average. We noticed we had many averages so that helped us reduce the amount of code throughout our files.

Tell us about 1) a unit test and 2) an integration test that you are particularly proud of. Please include file name(s) and line number(s).

 - Unit test: customer_spec.rb line 5. Simple and straight to the point, it exists, it has attributes, it works

 - Integration test: merchant_spec line 26 : merchant has a sales engine and a merchant repo and a merchant.

Is there anything else you would like instructors to know?

Please include a minimum of 1 question from each group member (max: 3 questions per group member). Include these questions as a section in your project README. Your evaluating instructor will answer these in your feedback video.

Braxton: Where did we go wrong with our create/update methods, how come we cant pass the spec harness?
After speaking with other classmates our spec harness run time is much longer than others. How could we have shortened it up?
Kyle: What are some strategies to sticking to tdd especially when making helper methods? It can feel tedious at times
Nigel: How can we best implement repo update method into a module when different repos want to update an instance with different attributes? And if they share the same method then some instances will not correctly initialize.
Kara: Is there a better way to connect all the find by id methods in to a module, even though they are specific to the class? It seems like it could clean up a lot

BLOG
https://drive.google.com/file/d/14NhA3IJPbdgz0ukNNMhkFj7TZPW9_baj/view?usp=sharing
