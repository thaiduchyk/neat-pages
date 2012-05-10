require 'neat_pages/implants/action_controller_implant'

module NeatPages::Implants
  class Railtie < Rails::Railtie
    initializer "neat_pages" do |app|

      ActiveSupport.on_load :action_controller do
        include NeatPages::Implants::ActionControllerImplant
      end

    end
  end
end
