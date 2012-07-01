$LOAD_PATH << File.expand_path('../../../lib',__FILE__)
require File.dirname(__FILE__) + '/../../lib/normalise.rb'

require 'aruba/cucumber'
ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__) + '/../../bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"
