
lines = File.read('input').lines

original_word = lines.last.strip
replacements = lines[0..lines.length - 3].map do |n|
  n.split(" => ").map(&:strip)
end

# original_word = "HOHOHO"
# replacements = [
#   ["e", "H"],
#   ["e", "O"],
#   ["H", "HO"],
#   ["H", "OH"],
#   ["O", "HH"]
# ]

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

@steps = []
def find_r(curr_str, curr_rep, replacements, word, steps)
  final_steps = 0
  get_molecules(curr_str, curr_rep).each do |m|
    replacements.each do |r|
      if m == word
        p @steps
        @steps << steps
      end
      next if m.length > word.length
      final_steps = find_r(m, r, replacements, word, steps + 1)
    end
  end
  return final_steps
end

def find(replacements, word)
  replacements.each do |r|
    find_r(r.first, r, replacements, word, 0)
  end
end

arr = replacements.each.with_object([]) do |r, obj|
  obj << get_molecules(original_word, r)
end.flatten
p arr.uniq.length

find(replacements, original_word)
p @steps.min + 1
