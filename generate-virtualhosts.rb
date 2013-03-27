#!/usr/bin/env ruby

require "erb"
require "rubygems"
require "trollop"
require "mapping.rb"

# Template file
filename = "templates/virtualhost.erb"

# Configure options.
opts = Trollop::options do
  opt :host_suffix, "Host suffix, such as '.dev' or '.test'", :type => :string
end

# If a host suffix is passed in, this gets appended.
suffix = ''
unless opts::host_suffix.nil?
  suffix = opts::host_suffix
end

Mapping.each do|host,port|
  host = "#{host}#{suffix}"
  template = ERB.new(File.read(filename))
  puts output = template.result(binding)
end
