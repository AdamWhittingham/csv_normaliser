require 'csv'

class Normaliser
  def initialize options={}
    @date_format = options[:date_format] || '%Y/%m/%d %H:%M:%S'
    @ratio_function = get_ratio_function options[:normalise]
  end

  private def get_ratio_function mode
    case mode
    when :percentage
      lambda {|values| 100.0 / values.reduce(:+) }
    when :degrees
      lambda {|values| 360.0 / values.reduce(:+) }
    when :relative, nil, null
      lambda {|values| 100.0/values.max}
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
      column_id,column_values = column
      out_table[column_id] = normalise column_values
    end
  end

  def normalise values
    if values.any?{|item| item.is_a? Float}
      normalise_numbers values, false
    elsif values.all?{|item| item.is_a? Numeric}
      normalise_numbers values
    elsif values.all?{|item| DateTime.parse item rescue return values}
      normalise_dates values
    end
  end

  def normalise_numbers values, round=true
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
