require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  counts = HashMap.new
  string.each_char do |chr|
    if counts.include?(chr)
      counts[chr] += 1
    else
      counts[chr] = 1
    end
  end
  total = 0
  counts.each { |x| total += 1 if x[1] % 2 == 1 }
  total <= 1
end
