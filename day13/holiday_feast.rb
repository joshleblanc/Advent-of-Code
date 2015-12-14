require_relative 'table.rb'

class HolidayFeast
  def initialize
    @attendees = {}
    @table = nil
  end

  def set_table!
    @table = Table.new(@attendees)
  end

  def get_best_arrangement
    @table.calc_happiness
  end

  def get_attendee(name)
    @attendees[name]
  end

  def add_attendee(person)
    @attendees[person.name] = person
  end

  def add_last_minute_attendee(name)
    person = Person.new(name)
    @attendees.each do |k, v|
      v.add_relationship([name, 0])
      person.add_relationship([v.name, 0])
    end
    @attendees[person.name] = person
  end
end
