class B
  def initialize(file_name)
    out_file = File.open(file_name.sub(/in/, 'out'), 'w')

    File.open(file_name, "r") do |io|
      test_cases = io.readline.to_i
      (1..test_cases).each_with_index do |e, t|
        s = io.readline.to_s.strip.chars
        result = 0
        #puts e
        #puts "#{s} s"
        while(s.any? { |p| p != '+' }) do
          to_flip = s.take_while { |i| i == s.first }
          #puts "#{to_flip} to flip"
          top = flip to_flip
          bottom = s.slice(top.length, s.length)
          s = top + bottom
          #puts s
          result += 1
        end

        out_file.print "Case ##{e}: "
        out_file.puts "#{result}"
      end
    end

    out_file.close
  end

  def flip(pancakes)
    pancakes.reverse.map { |p| p == '-' ? '+' : '-' }
  end
end

B.new('example.in')
B.new('small.in')
B.new('large.in')
