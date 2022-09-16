require 'rails/generators/active_record'

module UserDefinedFields
  module Generators
    class AddGenerator < Rails::Generators::Base
      # Includes
      include ActiveRecord::Generators::Migration

      # Command arguments
      argument :model_name, type: :string

      # Migration template directory
      source_root File.join(__dir__, 'templates')

      def copy_migration
        migration_template(
          'add.rb',
          "db/migrate/add_user_defined_fields_to_#{model_name}.rb",
          migration_version: migration_version,
          model_name: model_name
        )
      end

      def migration_version
        "[#{ActiveRecord::VERSION::MAJOR}.#{ActiveRecord::VERSION::MINOR}]"
      end
    end
  end
end
