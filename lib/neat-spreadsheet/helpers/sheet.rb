module NeatSpreadsheet::Helpers
  class Sheet
    def initialize(workbook, options={}, &block)
      options.reverse_merge! title: nil, columns_width: [10, 10, 10, 10, 10]

      init_sheet workbook, options[:title]
      init_columns options[:columns_width]
      init_styles

      yield self
    end

    def cell(value, options={})
      if options[:colspan]
        options[:horizontal_align] = :merge

        (@column_position..(@column_position+options[:colspan]-1)).each do |i|
          current_row.set_format(i, current_format(options))
        end
      else
        current_row.set_format(@column_position, current_format(options))
      end

      set_current_column value

      @column_position += 1
    end

    def row(options={}, &block)
      options.reverse_merge! height: nil, start_at_column: 0, style: :normal

      @column_position = 0

      set_current_style options[:style]
      set_current_height options[:height]

      (0..options[:start_at_column]-1).each { |i| cell(' ') } if options[:start_at_column] > 0

      yield self

      @row_position += 1
    end

    def skip_cell
      skip_cells 1
    end

    def skip_cells(nb)
      (@column_position..(@column_position+nb-1)).each { |i| cell(' ') }
    end

    def skip_row
      @row_position += 1
    end

    def spacer(options={})
      options.reverse_merge! height: 20

      @column_position = 0

      current_row.height = options[:height]
      (0..@total_columns-1).each { |i| current_row.set_format(i, Spreadsheet::Format.new(horizontal_align: :merge)) }
      set_current_column ' '

      @row_position += 1
    end

    private

    def current_format(options={})
      format = current_style(options)

      format.delete(:colspan)

      return Spreadsheet::Format.new(format)
    end

    def current_row
      @sheet.row(@row_position)
    end

    def current_style(options={})
      @styles[@current_style].merge(options)
    end

    def init_columns(sizes)
      sizes.each_with_index { |width, i| @sheet.column(i).width = width }

      @total_columns = sizes.length
    end

    def init_sheet(workbook, title)
      @sheet = workbook.create_worksheet
      @sheet.name = title if title
      @row_position = 0
    end

    def init_styles
      @styles = {}

      @styles[:h1] = { weight: :bold,   size: 16, horizontal_align: :left, vertical_align: :middle }
      @styles[:h2] = { weight: :normal, size: 12, horizontal_align: :left, vertical_align: :middle }
      @styles[:h3] = { weight: :normal, size: 9,  horizontal_align: :left, vertical_align: :middle }
      @styles[:h4] = { weight: :bold,   size: 8,  horizontal_align: :left, vertical_align: :middle }
      @styles[:th] = { weight: :bold,   size: 8,  horizontal_align: :center, vertical_align: :middle, pattern_fg_color: :xls_color_19, pattern: 1 }

      @styles[:normal] = { size: 8, horizontal_align: :left , vertical_align: :middle }
      @styles[:small] = { size: 7, horizontal_align: :left , vertical_align: :middle }
      @styles[:tiny] = { size: 6, horizontal_align: :left , vertical_align: :middle }
      @styles[:unknown] = { weight: :bold, size: 5, color: :red }
    end

    def set_column(position, value)
      @sheet[@row_position, position] = value
    end

    def set_current_column(value)
      set_column @column_position, value
    end

    def set_current_height(height)
      height = current_style[:size] + 8 if not height

      current_row.height = height
    end

    def set_current_style(name)
      @current_style = (@styles.has_key?(name) ? name : :unknown)
    end
  end
end
