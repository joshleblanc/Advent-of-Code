def find_with(array)
  array.each do |e|
    v = yield(e)
    return v if v
  end
  nil
end

def replace(word, num_matches, r)
  word.gsub(r.first).with_index { |m, i| i == num_matches ? r.last : m }
end

def get_molecules(word, r)
  word.chars.each_cons(r.first.length).with_object([]) do |w, obj|
    next unless w.join == r.first
    after = replace(word, obj.length, r)
    obj << after unless after == word
  end
end

def find_r(curr_str, curr_rep, replacements, word, steps)
  find_with(get_molecules(curr_str, curr_rep.reverse)) do |m|
    return steps if m == word
    find_with(replacements.reverse!) { |r| find_r(m, r, replacements, word, steps + 1) }
  end
end

def find(replacements, word)
  replacements.map { |r| find_r(word, r, replacements, 'e', 0) }.compact.min + 1
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
