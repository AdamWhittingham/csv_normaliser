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
  File.open('tmp/test.csv','w') { |file| file.write @example_input}
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
  File.open('tmp/test.csv','w') { |file| file.write @example_input}
end

Given /^an example containing plain text$/ do
  @example_input = <<-EOS.unindent
    field a, field b
    text 1, testA
    text 2, testB
    text 3, testC
    EOS
  File.open('tmp/test.csv','w') { |file| file.write @example_input}
end

Given /^I specify the date format option with the format '(.+)'$/ do |date_format|
  @date_format = date_format
  @cli_opts = " -d #{@date_format}"
end

Given /^an example csv$/ do
  @example_input = <<-EOS.unindent
  data a, data b
  20.0,160
  30.0,40
  EOS
  File.open('tmp/test.csv','w') { |file| file.write @example_input}
end

When /^I set no options$/ do
  @expected = <<-EOS.unindent
  data a, data b
  66.66666666666667,100
  100.0,25
  EOS
  @cli_opts = ''
end

When /^I call from the command line with the test file$/ do
  @normalised = %x{bin/csv_normalise tmp/test.csv#{@cli_opts}}
end

When /^I call from ruby with the test file$/ do
  normaliser = Normaliser.new
  @normalised = normaliser.normalise_csv(@example_input).to_s
end

When /^I call from the command line with data on stdin$/ do
  File.open('tmp/test.csv','w') { |file| file.write @example_input }
  @normalised = %x{cat tmp/test.csv |bin/csv_normalise}
end

When /^I set the '(.+)' option$/ do |opt|
  @cli_opts=" #{opt}"
end

Then /^the output should be normalised relative to the largest value$/ do
  @normalised.should == @expected
end

Then /^the dates output should be in the format "(.*)"$/ do |date_format|
  @date_format = date_format
  @dates.each do |date|
    step "the output should contain \"#{date.strftime @date_format}\""
  end
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

Then /^the output should be normalised into percentages$/ do
  @expected = <<-EOE.unindent
  data a, data b
  40.0,80
  60.0,20
  EOE
  @normalised.should == @expected
end

Then /^the output should be normalised into degrees$/ do
  @expected = <<-EOE.unindent
  data a, data b
  144.0,288
  216.0,72
  EOE
  @normalised.should == @expected
end

class String
  def unindent
    gsub(/^#{scan(/^\s*/).min_by{|l|l.length}}/, "")
  end
end
