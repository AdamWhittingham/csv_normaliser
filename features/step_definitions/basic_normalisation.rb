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

When /^I call normalise_csv from the command line with a file argument$/ do
  File.open('tmp/test.csv','w') { |file| file.write @example_input }
  @normalised = %x{ruby app/normalise.rb tmp/test.csv}
end

Then /^the output should be normalised relative to the largest value$/ do
  @normalised.should == @expected
end

When /^I call normalise_csv from ruby with a file argument$/ do
  normaliser = Normaliser.new
  @normalised = normaliser.normalise_csv(@example_input).to_s
end

class String
  def unindent 
    gsub(/^#{scan(/^\s*/).min_by{|l|l.length}}/, "")
  end
end
