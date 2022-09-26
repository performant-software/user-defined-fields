module UserDefinedFields
  class DatabaseController < ApplicationController
    def data_types
      data_types = %w(Boolean Date Number RichText Select String Text)
      render json: { data_types: data_types }, status: :ok
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
