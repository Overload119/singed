require 'singed/backtrace_cleaner_ext'
require 'singed/controller_ext'

module Singed
  class Railtie < Rails::Railtie
    initializer 'singed.configure_rails_initialization' do |app|
      Singed.output_directory = Rails.root.join('tmp/speedscope')
      Singed.backtrace_cleaner = Rails.backtrace_cleaner

      app.middleware.use Singed::RackMiddleware

      ActiveSupport.on_load(:action_controller) do
        ActionController::Base.include(Singed::ControllerExt)
      end
    end
  end
end
