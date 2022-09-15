module UserDefinedFields
  class Engine < ::Rails::Engine
    isolate_namespace UserDefinedFields
    config.generators.api_only = true
  end
end
