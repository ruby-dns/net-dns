require 'yaml'

module Net
  module DNS
    module Version

      @@version = YAML.load_file(File.dirname(__FILE__) + '/../../../VERSION.yml')

      MAJOR = @@version[:major]
      MINOR = @@version[:minor]
      TINY  = @@version[:patch]
      ALPHA = nil

      STRING = [MAJOR, MINOR, TINY, ALPHA].compact.join('.')
    end

    VERSION = Version::STRING

  end
end