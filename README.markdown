# GeekUp Nottingham September 2010: Template Method

This was an audience-participation session refactoring from some
Template Method code to a Strategy system.

There are two branches:

* **master** - contains the initial code
* **2010\_09\_geekup\_session** - contains the refactored code


## Session commentary

Unfortunately I didn't have a git auto-commit system set up for this,
so the changes appear in one huge transformation.

Thanks for feedback about the session.  I rushed preparing the initial code,
and it turns out I made a few mistakes from a pedagogical point of view.

One is I should not have used formatting as one of the dimensions of variation.
It's too obviously offensive and in need of decoupling, which may explain
why the audience voted (6 to 5) to remove that first, despite the fact the discount
system is the dimension that introduces the extra duplication.  It would be
better if the two dimensions were more balanced.

Another is that the code works with primitive data structures (Arrays), which
is a distraction from the actual goal of transforming the code from a hierarchy
to a network.

The lack of an "Order" object or similar is really evident by the end, where
the formatting is only partially factored out.  While it would be nice if the
code ended up conceptually clean, on the other hand, the fact that refactoring
Template Method to Strategy reveals another object role is illuminating.

Thanks for everyone who participated and gave feedback.  I think there is
mileage in this refactoring.  Before I repeat this session, I'll spend time
putting the initial code into a better state, and work on the mechanics
to emphasise the rhythm and smaller refactorings (eg Push Up Method,
Inline Method) more.  I haven't yet seen anyone document the mechanics of this
larger refactoring.  I can't see it in Kerievsky's Refactoring to Patterns, for
example.


## Installation

    rvm install 1.9.2
    rvm use 1.9.2
    rvm gemset create '2010_09_geekup_nottingham'
    gem install bundler
    cd 2010_09_geekup_nottingham
    bundle install