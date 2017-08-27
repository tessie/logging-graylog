# logging-graylog 

<a href="https://badge.fury.io/rb/logging-graylog"><img src="https://badge.fury.io/rb/logging-graylog.svg" alt="Gem Version" height="18"></a>
A graylog appender for the Ruby Logging framework


## Description
This gem provides a way to send logs to graylog.This appender is an extension of twp/logging gem.

## Installation
The logging framework uses the [little-plugger](https://github.com/twp/little-plugger) gem based plugin system. All that needs to be done to start using the graylog appender is to install the gem.

          gem install logging-graylog
          
## Usage

 This appender logs messages to a GELF server like [Graylog2](http://www.graylog2.org).
 
         require 'logging'
         Logging.init
         graylog_appenders = Logging.appenders.graylog 'graylog-server'
                                    {
                                      server: 'localhost',
                                      level : 'DEBUG'
                                      port: '12201'
                                    }
        logger = Logging.logger['example_logger']
        logger.add_appenders \
          graylog_appenders
          Logging.appenders.file('example.log')
          
       logger.info "Hello World"


