require 'csv'
require 'optparse'

class Normaliser
  def initialize options={}
    @date_format = options[:date_format] || '%Y/%m/%d %H:%M:%S'
  end

  def normalise_csv (input, headers=true)
    csv_options= [:headers => headers, :write_headers => headers, :header_converters => nil, :converters => :all]
    data_array = CSV.parse input, *csv_options
    parse_table CSV::Table.new data_array
  end

  def parse_table table
    out_table = table.dup
    table.by_col.each do |column|
      column_id,column_data = column
      out_table[column_id] = normalise column_data
    end
  end

  def normalise data
    if data.any?{|item| item.is_a? Float}
      normalise_floats data
    elsif data.all?{|item| item.is_a? Numeric}
      normalise_numbers data
    else
      begin
        if data.all?{|item| DateTime.parse item}
          normalise_dates data
        end
      rescue nil #Column isn't parsable to DateTime, leave it be
      end
    end
  end

  def relative_ratio data
    100.0 / data.max
  end

  def normalise_floats data
    ratio = relative_ratio data
    data.map {|val| (val*ratio)}
  end

  def normalise_numbers(data, round= true)
    ratio = relative_ratio data
    data.map {|val| (val*ratio).round}
  end

  def normalise_dates(data)
    data.map {|date| DateTime.parse(date).strftime @date_format }
  end
end

if __FILE__ == $0
  options = {}
  OptionParser.new do |opts|
    opts.banner = "Usage: #{$0} [options] [file]"
    opts.on("-d", "--date-format FORMAT", "Linux/Ruby date format to convert to (eg. '%Y/%m/%d %H:%M:%S')") do |format|
      options[:date_format] = format
    end
    opts.on_tail("-h", "--help", "-?", "Show this message") {puts opts; exit}
  end.parse!

  normaliser = Normaliser.new options
  puts normaliser.normalise_csv ARGF.read
end
