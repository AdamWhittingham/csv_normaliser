CSV_Normaliser
==============

The aims of this project are 2 fold:
- Provide an easy way to normalise the values in CSVs and Arrays
- Give me a way to learn Ruby

This means it should be useful for turning a CSV or array of numbers into something
which is easier to graph or can be shared without disclosing super-secret business
numbers.

It also means that there may be some slightly wonky bits of Ruby or strange syntactic
choices (read: I used to write Java). If you spot any of these, I'd only be greatful
to have them pointed out in a short email or pull request, I'd like to improve!

Installation
------------
Clone the repository and get to it- everything is core Ruby 1.9 (1.9.2-p290 to be exact)

Usage
-----
The normaliser can be used as a library (using the Normaliser.normalise\_csv(String) or
normalise(Array) methods), or it can also be used on the command line (both with a file
argument or piping data in on stdin).

Development
-----------
I'm using Cucumber for tests so far but everything else should be core Ruby 1.9.2
As stated earlier, I'd be really happy for any adivce, patches or constructive comments.
