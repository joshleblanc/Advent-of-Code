require_relative 'holiday_feast.rb'
require_relative 'person.rb'

holiday_feast = HolidayFeast.new
File.open('input', 'r') do |infile|
  while (line = infile.gets)
    person = Person.new(line)
    if (attendee = holiday_feast.get_attendee(person.name))
      attendee.add_relationship(person.relationships.first)
    else
      holiday_feast.add_attendee(person)
    end
  end
end

holiday_feast.set_table!
p "The best net happiness is: #{holiday_feast.get_best_arrangement.max}"

holiday_feast.add_last_minute_attendee("me")
holiday_feast.set_table!
p "The best net happiness with yourself is: #{holiday_feast.get_best_arrangement.max}"
