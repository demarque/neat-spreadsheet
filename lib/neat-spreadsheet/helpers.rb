module NeatSpreadsheet::Helpers
  def neat_spreadsheet(workbook, options={}, &block)
    Sheet.new(workbook, options, &block)
  end

  ::ActionView::Base.send :include, self
end

require 'neat-spreadsheet/helpers/sheet'
