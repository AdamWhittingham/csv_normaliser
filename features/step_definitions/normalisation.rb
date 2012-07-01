Given /^the numeric column '\[(.+)\]'$/ do |values|
  @values = values.split(',').map{|val| val.to_i}
end

Given /^the float column '\[(.+)\]'$/ do |values|
  @values = values.split(',').map{|val| val.to_f}
end

Given /^the I specify the normalise '([:\w]+)' option$/ do |opt|
  option = opt.gsub(':','').downcase.to_sym
  @options = {:normalise => option}
end

When /^I call normalise with the column$/ do
  options = @options || {}
  norm = Normaliser.new options
  @normalised = norm.normalise @values
end

Then /^I should get back '\[(.+)\]'$/ do |values|
  expected = values.split(',').map{|v|v.strip}
  @normalised.map{|val| val.to_s}.should == expected
end

Then /^the total should be (\d+)$/ do |expected_total|
  @normalised.reduce(:+).to_f.should == expected_total.to_f
end
