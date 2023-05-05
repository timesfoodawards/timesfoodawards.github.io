require 'erb'
require 'tilt'
require 'simple_xlsx_reader'
require 'pry'

template = Tilt.new('templates/award_winners_base.erb')
doc = SimpleXlsxReader.open('tfna_winners_2023.xlsx')
puts "Number of Sheets : #{doc.sheets.length}"
# process each sheet

cities = []
doc.sheets.each do |sheet|
  cities << sheet.name
end

doc.sheets.each do |sheet|
  puts "Processsing Sheet #{sheet.name}"
  sheet_data = sheet.slurp
  # loop through the rows
  scope = Object.new
  scope.instance_variable_set :@cities, cities
  scope.instance_variable_set :@sheet_data, sheet_data
  output = template.render(scope)
  filename = "./times_food_nightlife_awards/2023/#{sheet.name}_winners.html"
  File.write(filename, output)
  puts "Wrote file #{filename}"
end
