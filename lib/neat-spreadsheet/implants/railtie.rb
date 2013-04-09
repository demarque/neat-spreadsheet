module NeatSpreadsheet::Implants
  class Railtie < Rails::Railtie
    initializer "neat-spreadsheet" do |app|
      ActiveSupport.on_load :action_view do
        require 'neat-spreadsheet/helpers'
      end

      ActionView::Template.register_template_handler :rxls, lambda { |template|
        NeatSpreadsheet.render_xls_string(template.source)
      }

      ActionController::Renderers.add :xls do |filename, options|
        send_data(render_to_string(options), filename: "#{filename}.xls", type: "application/vnd.ms-excel", disposition: "attachment")
      end

      Mime::Type.register "application/vnd.ms-excel", :xls if not Mime::Type.lookup_by_extension :xls
    end
  end
end
