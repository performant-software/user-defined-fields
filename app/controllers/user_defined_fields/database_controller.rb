module UserDefinedFields
  class DatabaseController < ApplicationController
    def data_types
      render json: { data_types: UserDefinedField::DATA_TYPES.values }, status: :ok
    end

    def tables
      tables = []

      ActiveRecord::Base.connection.tables.map do |model|
        klass = model.classify
        next unless klass.safe_constantize&.included_modules&.include?(Fieldable)

        tables << klass.to_s
      end

      render json: { tables: tables }, status: :ok
    end
  end
end
