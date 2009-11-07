require 'yaml'


module Net # :nodoc:
  module DNS 
    module Version
      
      @@version = YAML.load_file(File.dirname(__FILE__) + '/../../../VERSION.yml')

      MAJOR = @@version[:major]
      MINOR = @@version[:minor]
      PATCH = @@version[:patch]

      STRING = [MAJOR, MINOR, PATCH].join('.')
    end

    VERSION         = Version::STRING
    STATUS          = 'beta'
    BUILD           = nil

  end
end