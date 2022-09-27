require "user_defined_fields/configuration"
require "user_defined_fields/version"
require "user_defined_fields/engine"

module UserDefinedFields
  mattr_accessor :config, default: Configuration.new

  def self.configure(&block)
    block.call self.config
  end
end

