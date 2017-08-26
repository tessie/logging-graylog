begin
  require 'bones'
rescue LoadError
  abort '### please install the "bones" gem ###'
end

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'logging/plugins/graylog'

task :default => 'test:run'
task 'gem:release' => 'test:run'

Bones {
  name         'logging-graylog'
  summary      'An graylog appender for the Ruby Logging framework'
  authors      'Tessy Joseph John'
  email        'tessyjoseph1992@gmail.com'
  url          'http://rubygems.org/gems/logging-graylog'
  version      Logging::Plugins::Graylog::VERSION

  use_gmail

  depend_on 'logging'

  depend_on 'bones-git', :development => true
}
