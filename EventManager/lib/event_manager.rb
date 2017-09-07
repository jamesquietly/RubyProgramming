require 'csv'
require 'sunlight/congress'
require 'erb'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
    zipcode.to_s.rjust(5, "0")[0..4]
end

def legislators_by_zipcode(zipcode)
    Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letters(id, form_letter)
    Dir.mkdir("output") unless Dir.exists?("output")

    filename = "output/thanks_#{id}.html"

    File.open(filename, 'w') do |file|
        file.puts form_letter
    end
end

$popular_hours = Hash.new(0)
$popular_days = Hash.new(0)

def time_targeting(time)
    days = {0 => "Sunday",
        1 => "Monday",
        2 => "Tuesday",
        3 => "Wednesday",
        4 => "Thrusday",
        5 => "Friday",
        6 => "Saturday"}

    datetime = DateTime.strptime(time, '%m/%d/%y %H:%M')
    $popular_hours[datetime.hour] += 1
    $popular_days[days[datetime.wday]] += 1
end

def print_popular(dict, key_string)
    array = dict.sort_by { |day, count| count}
    array = array.reverse
    array.each do |val|
        puts "#{key_string}: #{val[0]} count:#{val[1]}"
    end
end


template_letter = File.read "form_letter.html"
erb_template = ERB.new template_letter
contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
contents.each do |row|
    id = row[0]
    name = row[:first_name]
    zipcode = clean_zipcode(row[:zipcode])

    legislators = legislators_by_zipcode(zipcode)

    form_letter = erb_template.result(binding)

    save_thank_you_letters(id, form_letter)

    time_targeting(row[:regdate])
end

puts "popular hours are:"
print_popular($popular_hours, "hour")
puts " "
puts "popular days are:"
print_popular($popular_days, "day")