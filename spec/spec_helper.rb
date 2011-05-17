# -*- encoding : utf-8 -*-
require File.join(File.dirname(__FILE__), '../lib/readable')

def read(filename)
  file    = File.open(File.join(File.dirname(__FILE__), filename), "r:binary")
  content = file.read
  file.close
  content
end

def stub_page!(filename)
  content = read(filename)
  result  = stub!(:result)
  result.stub!(:body => content)
  Net::HTTP.stub!(:start).and_return(result)
end
