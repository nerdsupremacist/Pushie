# Pushie
Push Down Automaton Creation in Swift. The easy way.

Pushie allows you to create Push down automata quickly and easily, for quick and simple Parsing of your own defined languages. Designed to be easy to read and understand

## Usage

First install the Pod

## Creating your Automaton

To create you Automaton you will have to:
1. Create the different States in your Machine.
2. Specify the transitions between the states.
3. Create an Automaton Object from your initial State.

In this case we will be writing an Automaton that accepts the Language that has n 0's followed by n 1's and will return the respective n as a result.

### Creating the States

To create a state simply instantiate it. Remember to use the generics to specify what your product will be.

```Swift
let stateOne = State<Int>()
let stateTwo = State<Int>()
```

If a state is a final state just do:

```Swift
let stateThree = State<Int>(finite: true)
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
stateOne.when("A").on("1").goTo(stateTwo).pop()
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

![alt text](https://raw.githubusercontent.com/mathiasquintero/Pushie/master/exmple.png "Taken from wikipedia")

Now it's time to start it:

```Swift
let automaton = Pushie(start: 0, state: stateOne)
automaton.stack.push("C")

automaton.handle("1100") // Optional(2)
automaton.handle("11100") // nil
```
