def get_molecules(original_word, r)
  tmp = original_word
  matches = 0
  original_word.chars.each_cons(r.first.length).with_object([]) do |w, obj|
    next unless w.join == r.first
    before = tmp
    after = before.gsub(w.join).with_index do |m, i|
      i == matches ? r.last : m
    end
    unless before == after
      obj << after
      matches += 1
    end
  end
end

def find_r(curr_str, curr_rep, replacements, word, steps)
  get_molecules(curr_str, curr_rep.reverse).each do |m|
    return steps if m == word
    replacements.reverse!.each do |r|
     val = find_r(m, r, replacements, word, steps + 1)
     return val if val
    end
  end
  nil
end

def find(replacements, word)
  vals = []
  replacements.map do |r|
    Thread.new { vals << find_r(word, r, replacements, 'e', 0) }
  end.each(&:join)
  vals.compact.min + 1
end

def get_num_distinct_molecules(replacements, original_word)
  replacements.map { |r| get_molecules(original_word, r) }.flatten.uniq.length
end

def get_replacements(lines)
  lines[0..lines.length - 3].map { |n| n.split(" => ").map(&:strip) }
end

lines = File.read('input').lines
original_word = lines.last.strip
replacements = get_replacements(lines)



p "#{get_num_distinct_molecules(replacements, original_word)} distinct molecules can be created"
p "It takes #{find(replacements, original_word)} steps to create #{original_word}"
