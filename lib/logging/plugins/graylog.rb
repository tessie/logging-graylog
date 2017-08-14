module Logging
  module Plugins
    module Graylog
      extend self

      VERSION = '1.0.0'.freeze

      def initialize_graylog
        require File.expand_path('../../appenders/graylog', __FILE__)
      end
    end
  end
end