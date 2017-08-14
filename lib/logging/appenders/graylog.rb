require 'gelf'
require 'logging'

module Logging
  module Appenders

    # Accessor / Factory for the Email appender.
    def self.graylog(*args)
      return ::Logging::Appenders::Graylog if args.empty?
      ::Logging::Appenders::Graylog.new(*args)
    end

    LEVELS_MAP = {
      'DEBUG'  => GELF::Levels::DEBUG,
      'INFO'   => GELF::Levels::INFO,
      'WARN'   => GELF::Levels::WARN,
      'ERROR'  => GELF::Levels::ERROR,
      'FATAL'  => GELF::Levels::FATAL
    }

    # Provides an appender that can send log messages to graylog
    class Graylog < ::Logging::Appender

      def initialize(name, opts = {})
        super(name, opts)
        @server = opts.fetch(:server, '127.0.0.1')
        @port = opts.fetch(:port, 12201)
        @max_chunk_size = opts.fetch(:max_chunk_size, 'WAN')
        hash = {}
        hash['host'] = opts.fetch(:host, Socket.gethostname)
        hash['facility'] = opts.fetch(:facility, 'gelf-rb')
        hash['level'] = LEVELS_MAP[opts.fetch(:level, 'DEBUG')]
        @gelf_notifier = GELF::Notifier.new(@server, @port, @max_chunk_size, hash)
      end

      private

      def write(logevent)
        opts = {}
        opts[:logger] = logevent.logger
        opts[:level] = logevent.level
        opts[:short_message] = format(logevent.data)
        opts[:full_message] =  format(logevent) unless opts[:full_message]
        @gelf_notifier.notify!(opts)
      end

      def format(event)
        event.inspect
      end
    end
  end
end
