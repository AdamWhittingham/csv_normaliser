require 'csv'

class Normaliser
  def initialize options={}
    @date_format = options[:date_format] || '%Y/%m/%d %H:%M:%S'
    setup_ratio_function options[:normalise]
  end

  def setup_ratio_function mode
    if mode == :percentage
      @ratio_function = lambda {|values| 100.0 / values.reduce(:+) }
    else
      @ratio_function = lambda {|values| 100.0/values.max}
    end
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

  def normalise column
    if column.any?{|item| item.is_a? Float}
      normalise_numbers column, false
    elsif column.all?{|item| item.is_a? Numeric}
      normalise_numbers column
    else
      begin
        if column.all?{|item| DateTime.parse item}
          normalise_dates column
        end
      rescue nil #Column isn't parsable to DateTime, leave it be
      end
    end
  end

  def normalise_numbers values, round= true
    ratio = @ratio_function.call values
    if round
      values.map {|val| (val * ratio).round}
    else
      values.map {|val| (val * ratio)}
    end
  end

  def normalise_dates values
    values.map {|date| DateTime.parse(date).strftime @date_format }
  end
end
