# Pushie
![alt text](https://cocoapod-badges.herokuapp.com/v/Pushie/badge.png "Taken from wikipedia")

Push Down Automaton Creation in Swift. The easy way.

Pushie allows you to create Push down automata quickly and easily, for quick and simple Parsing of your own defined languages. Designed to be easy to read and understand

### Documentation

You can see the automatically generated Documentation here:
[Documentation](http://cocoadocs.org/docsets/Pushie/0.0.18/)

## Usage

First install the Pod

```Ruby
pod 'Pushie'
```

## Creating your Automaton

To create you Automaton you will have to:
1. Create the different States in your Machine.
2. Specify the transitions between the states.
3. Create an Automaton Object from your initial State.

In this case we will be writing an Automaton that accepts the Language that has n 0's followed by n 1's and will return the respective n as a result.

Basically we want to create an Automaton that accepts the language L. L being defined as:


<img src="https://raw.githubusercontent.com/mathiasquintero/Pushie/master/language.png" height=40>



### Creating the States

To create a state simply instantiate it. Remember to use the generics to specify what your product will be.

```Swift
let stateOne = State<Int>()
let stateTwo = State<Int>()
```

If a state is a final state just do:

```Swift
let stateThree = State<Int>(final: true)
```

### Transitions

Now we want to let the machine figure out where to go next. For that we define transitions.
We start by calling the when() function in a State with what we expect to be in the Stack.

Now we can add more information to this.
Mainly what characters it should listen for, what stack operation it should do and to what state it should go.

For example:

```Swift
stateOne.when("Z").goTo(stateThree)
```

Means that we can make an epsilon transition from state 1 to state 3 if the last item in the stack is Z.

```Swift
stateOne.when("A").on("0").goTo(stateTwo).pop()
```
Will create a transition from state 1 to state 2 if the last item in the Stack is A and it reads a "1". After doing so it will pop the last item from the Stack.

Further, Pushie is storing a result for your calculation. Meaning you can give it a function that will transform the current result. It should take a the a String and your result and return the new Result. So for our example we will be storing the number of 0's

```Swift
stateOne.when("Z").on("0").push("A").transform() { $1 + 1 }
stateOne.when("A").on("0").push("A").transform() { $1 + 1 }
```

Lastly we can finish up the states for our example:

```Swift
stateTwo.when("A").on("1").pop()
stateTwo.when("Z").goTo(stateThree)
```

So we have just created all the transitions in the following picture:

![alt text](https://raw.githubusercontent.com/mathiasquintero/Pushie/master/example.png "Taken from wikipedia")

Now it's time to start it:

```Swift
let automaton = Pushie(start: 0, state: stateOne)
automaton.stack.push("C")

automaton.handle("0011") // Optional(2)
automaton.handle("00011") // nil
```

## Creating Context Free Grammars

Creating automata is pretty tedious. That's why Pushie allows you to define Context Free grammars just as easily and translate them into automata.
We will now be working with the same example as before.

To create it in as little steps as possible we need to determine a CFG that should look like this:


<img src="https://raw.githubusercontent.com/mathiasquintero/Pushie/master/grammar.png" height=90>


For that you simply have to define your Variables:

```Swift
let A = GrammarVariable<Int>()
```

Now you have to create the productions. In this case we want A to be translated into either an Empty string or a 0 and a 1 with another A in the middle:

```Swift
A.to("0").and(A).and("1").transform() { $1 + 1 }
A.to("")
```

And now create a grammar starting from A:

```Swift
let grammar = Grammar(startVariable: A)
```

And now just like before you can call the handle function with both the starting value of the accumulator and the input:

```Swift
grammar.handle(0, input: "0011") // Optional(2)
grammar.handle(2, input: "0011") // Optional(4)
grammar.handle(0, input: "00011") // nil
```

Best of luck with Pushie!

Built with ♥


