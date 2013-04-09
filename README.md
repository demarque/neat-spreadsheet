Neat Spreadsheet
================

Simplify the task of building a spreadsheet in Rails. This gem is based on the Spreadsheet gem. The syntax have been simplified a bit.

Install
-------

```
gem install neat-spreadsheet
```

### Rails 3

In your Gemfile:

```ruby
gem 'neat-spreadsheet'
```

Example
-------

In your controller *(app/controllers/products_controller.rb)*

```ruby
def index
  respond_to do |format|
    format.html
    format.xls { render xls: "filename" }
  end
end
```

In your **RXLS** view *(app/views/products/index.rxls)*

```ruby
neat_spreadsheet workbook, title: 'Product Report', columns_width: [8, 25, 15, 15] do |sheet|
  sheet.row style: :h1 do |row|
    row.cell 'Product Report', colspan: 4
  end

  sheet.spacer

  sheet.row do |row|
    row.cell '2013-01-01'
    row.cell 'Apple'
    row.cell 4, align: :right
    row.cell 12.99, align: :right
  end
end
```


Usage
-----

### neat_spreadsheet *(title, options={}, &block)*
In your **RXLS** view, you can call the method ```neat_spreadsheet```. You must pass the workbook object. You can also use those options :

| Options       | Type   | Description                                                       |
| ------------- |--------|-------------------------------------------------------------------|
| title         | String | Title of the sheet                                                |
| column_width  | Array  | Size of each column. This will set the number of columns per row. |


This method takes a block and return a sheet object. Here's a list of the methods available for the sheet object.

#### row *(options={}, &block)*

Create a new row in the sheet

| Name            | Type    | Description                                                    |
| ----------------|---------|----------------------------------------------------------------|
| **Options**                                                                                |
| height          | Integer | Height of the row                                              |
| start_at_column | Integer | Position of the first column                                   |
| style           | Symbol  | Style of the content (h1 to h4, th, normal, small, tiny)       |

#### cell *(value, options={})*

Set the content of a cell at the current row in the sheet

| Name             | Type    | Description                                                   |
| -----------------|---------|---------------------------------------------------------------|
| value            | Mixed   | The content of the cell                                       |
| **Options**                                                                                |
| align            | Symbol  | left, right or center                                         |
| color            | Symbol  | Color of the text (white, black, red, etc...)                 |
| colspan          | Integer | The number of columns this cell take.                         |
| pattern_fg_color | Symbol  | Background color of the cell. Must set pattern to 1           |
| size             | Integer | Font size                                                     |
| vertical_align   | Symbol  | top, bottom, middle                                           |
| weight           | Symbol  | :normal, :bold                                                |

#### skip_cell

#### skip_cells *(nb)*

#### skip_row

#### spacer

Show a blank merged row.


Thanks
------

Thanks to https://github.com/10to1/spreadsheet_on_rails for the hooks with Rails.

Copyright
---------

Copyright (c) 2013 De Marque inc. See LICENSE for further details.
