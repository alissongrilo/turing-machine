# Turing Machine Simulator

## Overview

This Ruby code defines a `TuringMachine` class that simulates a Turing Machine. A Turing Machine is a theoretical model of computation with an infinite tape, a tape head, and a set of rules.

## Usage

Instantiate the `TuringMachine` class with specific rules and initial states, then run it with an input word using the `run` method. Check if the machine accepted the input with the `accept?` method.

## Example

```ruby
# Instantiate the Turing Machine for binary addition
tm = TuringMachine.new(rules['sum_1_in_binary'], 'q0')
puts tm.run('1111')

# Uncomment and run other examples as needed
# tm = TuringMachine.new(rules['change_letters'], 'q0')
# puts tm.run("aabb")

# tm = TuringMachine.new(rules['ai_bi_ci'], 'q0', ['q7'])
# puts tm.run('aabbcc')
# puts tm.accept?
