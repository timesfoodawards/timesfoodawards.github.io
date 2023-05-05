require 'erb'
require 'tilt'
require 'simple_xlsx_reader'
require 'pry'

doc = SimpleXlsxReader.open('tfna_winners_2023.xlsx')
cities = []
scope = Object.new

doc.sheets.each do |sheet|
  cities << sheet.name
end
template = Tilt.new('templates/index.erb')
scope.instance_variable_set :@cities, cities
# binding.pry
output = template.render(scope)
filename = "index.html"
File.write(filename, output)
puts "Wrote file #{filename}"
