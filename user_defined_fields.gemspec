require_relative 'lib/user_defined_fields/version'

Gem::Specification.new do |spec|
  spec.name        = 'user_defined_fields'
  spec.version     = UserDefinedFields::VERSION
  spec.authors     = ['Performant Software Solutions']
  spec.email       = ['derek@performantsoftware.com']
  spec.homepage    = 'https://github.com/performant-software/user-defined-fields'
  spec.summary     = 'Metadata made easy.'
  spec.description = 'A gem to empower users to define their own metadata.'
  spec.license     = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/performant-software/user-defined-fields'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  end

  spec.add_dependency 'rails', '>= 6.0.3.2', '< 8'
end
