module NeatSpreadsheet
  # Thanks to https://github.com/10to1/spreadsheet_on_rails for this method.
  def self.render_xls_string(spreadsheet)
<<RENDER
    workbook = Spreadsheet::Workbook.new
    #{spreadsheet}
    blob = StringIO.new("")
    workbook.write(blob)
    blob.string
RENDER
  end
end

require "neat-spreadsheet/engine"
require 'neat-spreadsheet/implants'
