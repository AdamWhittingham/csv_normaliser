require 'csv'

class Normaliser
  def normalise_csv (input, headers=true)
    csv_options= [:headers => headers, :write_headers => headers, :header_converters => nil, :converters => :all]
    data_array = CSV.parse input, *csv_options
    table = parse_table CSV::Table.new data_array
  end

  def parse_table table
    table.by_col.each do |column|
      column_id,column_data = column
      table[column_id] = normalise column_data
    end
    return table
  end

  def normalise data
      if data.any?{|item| item.is_a? Float}
        normalise_floats data
      elsif data.all?{|item| item.is_a? Numeric}
        normalise_numbers data
      end
  end

  def normalise_floats data
      ratio = 100.0 / data.max
      data.map {|val| (val*ratio)}
  end

  def normalise_numbers(data, round= true)
      ratio = 100.0 / data.max
      data.map {|val| (val*ratio).round}
  end
end

if __FILE__ == $0
  normaliser = Normaliser.new
  if ARGV
    puts normaliser.normalise_csv ARGF.read
  else
    while line = gets.chomp
      data << line
    end
    puts normaliser.normalise_csv data
  end
end
