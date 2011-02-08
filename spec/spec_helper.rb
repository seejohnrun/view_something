require 'rubygems'
require 'active_record'
require File.dirname(__FILE__) + '/../lib/view_something'

if ENV['adapter'] == 'mysql' || ENV['adapter'] == 'mysql2'
  ActiveRecord::Base.establish_connection(:database => 'holy_shit', :adapter => ENV['adapter'])
  ActiveRecord::Base.connection.execute('drop table users;')
elsif ENV['adapter'] == 'sqlite3'
  `rm spec/test.sqlite3`
  ActiveRecord::Base.establish_connection(:database => 'spec/test.sqlite3', :adapter => 'sqlite3')
else
  raise "Please specify an adapter to test with!"
end

ENV['RAILS_ENV'] = 'test'
load File.dirname(__FILE__) + '/schema.rb'
