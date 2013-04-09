module NeatSpreadsheet
  module Implants
  end
end

if defined? Rails::Railtie
  require 'neat-spreadsheet/implants/railtie'
elsif defined? Rails::Initializer
  raise "neat-spreadsheet is not compatible with Rails 2.3 or older"
end
