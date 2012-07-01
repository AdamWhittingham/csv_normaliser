Given /^an example containing integers and floats$/ do
  @example_input = <<-EOS.unindent
    data a,data b
    1,50.0
    2,33.3333
    3,15.555555
    4,3.33333
    EOS
  @expected = <<-EOS.unindent
    data a,data b
    25,100.0
    50,66.6666
    75,31.11111
    100,6.66666
  EOS
end

Given /^an example containing dates$/ do
  @dates = []
  @dates << DateTime.new(2012,06,30,15,05,30)
  @dates << DateTime.new(2012,06,29)
  @dates << DateTime.new(2012,06,28,04,55,26)
  @example_input = <<-EOS.unindent
    date
    #{@dates[0].strftime('%Y/%m/%d %H:%M:%S')}
    #{@dates[1].strftime('%Y-%m-%d')}
    #{@dates[2].strftime('%Y%m%d %H%M%S')}
    EOS
end

Given /^an example containing plain text$/ do
  @example_input = <<-EOS.unindent
    field a, field b
    text 1, testA
    text 2, testB
    text 3, testC
    EOS
end

Given /^I specify the date format option with the format '(.+)'$/ do |date_format|
  @date_format = date_format
  @cli_opts = " -d #{@date_format}"
end

When /^I call from the command line with a test file$/ do
  File.open('tmp/test.csv','w') { |file| file.write @example_input}
  @normalised = %x{bin/csv_normalise tmp/test.csv#{@cli_opts}}
end

When /^I call from ruby with a test file$/ do
  normaliser = Normaliser.new
  @normalised = normaliser.normalise_csv(@example_input).to_s
end

When /^I call from the command line with data on stdin$/ do
  File.open('tmp/test.csv','w') { |file| file.write @example_input }
  @normalised = %x{cat tmp/test.csv |bin/csv_normalise}
end

Then /^the output should be normalised relative to the largest value$/ do
  @normalised.should == @expected
end

Then /^the dates should be in the format '(.+)'$/ do |date_format|
  @date_format = date_format
  step 'the dates should be in that format'
end

Then /^the dates should be in that format$/ do
  @expected = "date\n"
  @dates.each do |date|
    @expected << "#{date.strftime @date_format}" << "\n"
  end
  @normalised.should == @expected
end

Then /^everything should be the same$/ do
  @normalised.should == @example_input
end

class String
  def unindent
    gsub(/^#{scan(/^\s*/).min_by{|l|l.length}}/, "")
  end
end
