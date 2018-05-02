require 'logging'
require Logging.path(%w[test setup])

Logging.initialize_plugins

module TestLogging
  module TestAppenders

    class TestGraylog < Test::Unit::TestCase

      def setup
        super
        @appender = Logging.appenders.graylog('graylog')
        @levels = Logging::LEVELS
      end

      def test_initialize
        appender = Logging.appenders.graylog('graylog')
        assert_equal('127.0.0.1', appender.instance_variable_get('@server'))
        assert_equal(12201, appender.instance_variable_get('@port'))
        assert_equal('WAN', appender.instance_variable_get('@max_chunk_size'))
        appender = Logging.appenders.graylog('graylog', { server: 'localhost', port: 12207, max_chunk_size: 'LAN' })
        assert_equal('localhost', appender.instance_variable_get('@server'))
        assert_equal(12207, appender.instance_variable_get('@port'))
        assert_equal('LAN', appender.instance_variable_get('@max_chunk_size'))
      end

      def test_options
        appender = Logging.appenders.graylog('graylog', {app: "test-graylog", tags: "LOGGING,RAILS,TEST_UNIT"})
        assert_equal('127.0.0.1', appender.instance_variable_get('@server'))
        assert_equal('test-graylog', appender.instance_variable_get('@hash')["app"])
        assert_equal('LOGGING,RAILS,TEST_UNIT', appender.instance_variable_get('@hash')["tags"])
      end
    end
  end
end
