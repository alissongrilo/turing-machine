# frozen_string_literal: true

# This class represents a Turing Machine.
class TuringMachine
  def initialize(rules, initial_state, finals_states = [])
    @tape = 'B'
    @head_position = 0
    @current_state = initial_state
    @rules = rules
    @finals_states = finals_states
  end

  def run(word)
    put_word_in_tape(word)

    loop do
      rule = @rules[@current_state][read]

      break if rule.nil?

      write(rule[:write])
      move_left if rule[:move] == 'L'
      move_right if rule[:move] == 'R'
      @current_state = rule[:next_state]
    end

    print_tape
  end

  def accept?
    @finals_states.include?(@current_state)
  end

  private

  def write(symbol)
    @tape[@head_position] = symbol
  end

  def move_left
    @head_position -= 1 if @head_position.positive?
  end

  def move_right
    @head_position += 1
  end

  def read
    @tape[@head_position]
  end

  def put_word_in_tape(word)
    @tape = "B#{word}B"
  end

  def print_tape
    "Tape Contents: #{@tape}"
  end
end

rules = {
  'sum_1_in_binary' => {
    'q0' => {
      'B' => { write: 'B', move: 'R', next_state: 'q1' }
    },
    'q1' => {
      '0' => { write: '0', move: 'R', next_state: 'q1' },
      '1' => { write: '1', move: 'R', next_state: 'q1' },
      'B' => { write: 'B', move: 'L', next_state: 'q2' }
    },
    'q2' => {
      '0' => { write: '1', move: 'L', next_state: 'q3' },
      '1' => { write: '0', move: 'L', next_state: 'q2' },
      'B' => { write: '1', move: 'L', next_state: 'q3' }
    },
    'q3' => {
      '0' => { write: '0', move: 'L', next_state: 'q3' },
      '1' => { write: '1', move: 'L', next_state: 'q3' }
    }
  },
  'change_letters' => {
    'q0' => {
      'B' => { write: 'B', move: 'R', next_state: 'q1' }
    },
    'q1' => {
      'a' => { write: 'b', move: 'R', next_state: 'q1' },
      'b' => { write: 'a', move: 'R', next_state: 'q1' },
      'B' => { write: 'B', move: 'L', next_state: 'q2' }
    },
    'q2' => {
      'a' => { write: 'a', move: 'L', next_state: 'q2' },
      'b' => { write: 'b', move: 'L', next_state: 'q2' }
    }
  },
  'ai_bi_ci' => {
    'q0' => {
      'B' => { write: 'B', move: 'R', next_state: 'q1' }
    },
    'q1' => {
      'a' => { write: 'X', move: 'R', next_state: 'q2' },
      'Y' => { write: 'Y', move: 'R', next_state: 'q6' }
    },
    'q2' => {
      'a' => { write: 'a', move: 'R', next_state: 'q2' },
      'Y' => { write: 'Y', move: 'R', next_state: 'q2' },
      'b' => { write: 'Y', move: 'R', next_state: 'q3' }
    },
    'q3' => {
      'b' => { write: 'b', move: 'R', next_state: 'q3' },
      'Z' => { write: 'Z', move: 'R', next_state: 'q3' },
      'c' => { write: 'Z', move: 'R', next_state: 'q4' }
    },
    'q4' => {
      'c' => { write: 'c', move: 'R', next_state: 'q4' },
      'B' => { write: 'B', move: 'L', next_state: 'q5' }
    },
    'q5' => {
      'a' => { write: 'a', move: 'L', next_state: 'q5' },
      'b' => { write: 'b', move: 'L', next_state: 'q5' },
      'c' => { write: 'c', move: 'L', next_state: 'q5' },
      'Y' => { write: 'Y', move: 'L', next_state: 'q5' },
      'Z' => { write: 'Z', move: 'L', next_state: 'q5' },
      'X' => { write: 'X', move: 'R', next_state: 'q1' }
    },
    'q6' => {
      'Y' => { write: 'Y', move: 'R', next_state: 'q6' },
      'Z' => { write: 'Z', move: 'R', next_state: 'q6' },
      'B' => { write: 'B', move: 'L', next_state: 'q7' }
    },
    'q7' => {}
  }
}

# MT soma 1 em binário
# tm = TuringMachine.new(rules['sum_1_in_binary'], 'q0')
# puts tm.run('1111')

# -----------------------------------------------------
# MT troca as letras A e B
# tm = TuringMachine.new(rules['change_letters'], 'q0')
# puts tm.run("aabb")

# -----------------------------------------------------
# MT triplo balanceamento
# tm = TuringMachine.new(rules['ai_bi_ci'], 'q0', ['q7'])
# puts tm.run('aabbcc')
# puts tm.accept?
