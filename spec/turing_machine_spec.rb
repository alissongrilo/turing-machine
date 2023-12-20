# frozen_string_literal: true

require 'turing_machine'

describe TuringMachine do
  describe '#run' do
    context "when the machine's rules are valids" do
      let :rules do
        {
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
      end

      context 'when sum_1_in_binary' do
        it 'returns the correct result' do
          expect(TuringMachine.new(rules['sum_1_in_binary'], 'q0').run('1011')).to eq('Tape Contents: B1100B')
          expect(TuringMachine.new(rules['sum_1_in_binary'], 'q0').run('1110')).to eq('Tape Contents: B1111B')
        end
      end

      context 'when change_letters' do
        it 'returns the correct result' do
          expect(TuringMachine.new(rules['change_letters'], 'q0').run('abba')).to eq('Tape Contents: BbaabB')
        end
      end

      context 'when ai_bi_ci' do
        it 'returns the correct result' do
          expect(TuringMachine.new(rules['ai_bi_ci'], 'q0').run('abbc')).to eq('Tape Contents: BXYbZB')
          expect(TuringMachine.new(rules['ai_bi_ci'], 'q0').run('aabbcc')).to eq('Tape Contents: BXXYYZZB')
        end
      end
    end
  end
end
