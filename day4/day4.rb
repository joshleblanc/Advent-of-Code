require 'digest'

def get_hex(str, num)
  Digest::MD5.hexdigest "#{str}#{num}"
end

def find_md5_hash_with_leading_zeroes(num_zeroes, str)
  while(i = (i || 0).next)
    return i if get_hex(str, i)[0...num_zeroes] == '0' * num_zeroes
  end
end

input = File.read('input').strip
p "The first hash with five leading zeroes comes from #{input}#{find_md5_hash_with_leading_zeroes 5, input}"
p "The first hash with six leading zeroes comes from #{input}#{find_md5_hash_with_leading_zeroes 6, input}"
