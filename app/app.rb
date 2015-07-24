require 'pathname'

require 'mail'
require 'sequel'
require 'virtus'

class App
  ROOT = Pathname.new(File.expand_path(__dir__, '../..')).dirname.realpath

  class << self
    def root
      ROOT
    end
  end
end

$LOAD_PATH.unshift(App.root)

require 'lib/use_case'
require 'lib/validation'
require 'app/use_cases/user'
