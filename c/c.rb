require 'prime'

class C
  def initialize(file_name)
    out_file = File.open(file_name.sub(/in/, 'out'), 'w')

    File.open(file_name, "r") do |io|
      test_cases = io.readline.to_i
      (1..test_cases).each_with_index do |e, t|
        input = io.readline.split
        n = input[0].to_i
        j = input[1].to_i
        coins = {}

        gen_coins(n).each do |c|
          break if coins.size == j
          nums = (2..10).map do |b|
            num = c.to_i b
            { divisor: divisor(num, b), prime: Prime.prime?(num) }
          end
          coins[c] = nums.map { |num| num[:divisor] } if nums.all? { |num| !num[:prime] }
          puts coins.size
          #puts "c #{c}"
          #puts nums
        end

        out_file.puts "Case ##{e}: "

        coins.each do |c, v|
          out_file.print "#{c}"
          v.each do |d|
            out_file.print " #{d}"
          end
          out_file.puts ''
        end
      end
    end
    out_file.close
  end

  def gen_coins(n)
    bases = (1..(n-2)**2 - 1).map { |i| i.to_s(2).rjust(n - 2, '0') }
    bases.map { |b| "1#{b}1" }
  end

  def divisor(n, b)
    Prime.prime_division(n).flatten.take_while { |i| i != 1 && i != b }.first
  end
end

C.new('example.in')
C.new('small.in')
#C.new('large.in')
