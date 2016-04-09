class A
  def initialize(file_name)
    out_file = File.open(file_name.sub(/in/, 'out'), 'w')

    File.open(file_name, "r") do |io|
      test_cases = io.readline.to_i
      (1..test_cases).each_with_index do |e, t|
        n = io.readline.to_i
        digits = (0..9).map { |i| [i, false] }.to_h
        seen = []

        input = n
        (1..10**6).each do |i|
          break if input == 0
          break if digits.all? { |k, v| v }
          input = i*n
          #puts input
          #puts digits

          input.to_s.chars.map(&:to_i).each do |d|
            digits[d] = true
          end
          seen << input
        end

        result = seen.last
        result = 'INSOMNIA' if input == 0

        out_file.print "Case ##{e}: "
        out_file.puts "#{result}"
      end
    end

    out_file.close
  end
end

A.new('example.in')
A.new('small.in')
A.new('large.in')
