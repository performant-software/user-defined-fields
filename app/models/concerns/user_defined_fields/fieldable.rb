module UserDefinedFields
  module Fieldable
    extend ActiveSupport::Concern

    class_methods do
      def resolve_defineable(lambda = nil)
        @resolve_defineable = lambda unless lambda.nil?
        @resolve_defineable
      end

      def search_fieldable(uuid, search)
        where("user_defined->>'#{uuid}' ILIKE ?", "%#{search}%")
      end

      def where_fieldable(uuid, value)
        where("user_defined->>'#{uuid}' = ?", value)
      end
    end

    included do
      # Resourceable parameters
      allow_params user_defined: {}

      # Validations
      validate :validate_user_defined_fields

      private

      def validate_user_defined_fields
        query = UserDefinedField
                  .where(table_name: self.class.to_s)

        defineable = self.class.resolve_defineable&.call(self)

        if defineable
          query = query.where(
            defineable_id: defineable.id,
            defineable_type: defineable.class.to_s
          )
        end

        query.each do |field|
          # Skip if this field is not required
          next unless field.required?

          # Parse the user defined field and extract the value
          value = self.user_defined[field.uuid] if self.user_defined.present?

          # Add an error if the value is "empty"
          next unless value.nil? ||
            (value.is_a?(String) && value.blank?) ||
            (value.is_a?(Array) && value.length === 0) ||
            (value.is_a?(Hash) && value.empty?)

          message = I18n.t('errors.common.required', name: field.column_name)
          self.errors.add(:user_defined, [field.uuid, message])
        end
      end
    end
  end
end
