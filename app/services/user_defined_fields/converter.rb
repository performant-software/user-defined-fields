module UserDefinedFields
  module Converter
    extend ActiveSupport::Concern

    included do
      def convert_value(user_defined_field, value)
        return nil unless value.present? or value == false

        if user_defined_field.data_type == UserDefinedField::DATA_TYPES[:boolean]
          convert_bool(value)
        elsif user_defined_field.data_type == UserDefinedField::DATA_TYPES[:date]
          convert_date(value)
        elsif user_defined_field.data_type == UserDefinedField::DATA_TYPES[:number]
          value.to_i
        elsif user_defined_field.data_type == UserDefinedField::DATA_TYPES[:select] && user_defined_field.allow_multiple
          convert_array(value)
        else
          value
        end
      end

      private

      def convert_array(value)
        begin
          JSON.parse(value)
        rescue StandardError
          nil
        end
      end

      def convert_bool(value)
        if value.is_a? String
          value.to_bool
        elsif value.in? [true, false]
          value
        else
          false
        end
      end

      def convert_date(value)
        begin
          DateTime.parse(value)&.to_time&.to_i
        rescue Date::Error
          nil
        end
      end
    end
  end
end