class Table
  def initialize(people)
    @arrangements = people.to_a.permutation
  end

  def calc_happiness
    @arrangements.map do |arrangement|
      arrangement.each_cons(2).inject(0) do |sum, (a, b)|
        sum + sum_relationships(a, b)
      end + sum_relationships(arrangement.first, arrangement.last)
    end
  end

  private
  def sum_relationships(a, b)
    a.last.relationships[b.first] + b.last.relationships[a.first]
  end
end
