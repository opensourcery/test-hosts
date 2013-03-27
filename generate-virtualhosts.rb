#!/usr/bin/env ruby

require "erb"
require "mapping.rb"

filename = "templates/virtualhost.erb"

Mapping.each do|host,port|
  template = ERB.new(File.read(filename))
  puts output = template.result(binding)
end
