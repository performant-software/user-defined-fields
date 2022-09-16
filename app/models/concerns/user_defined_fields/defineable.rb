module UserDefinedFields
  module Defineable
    extend ActiveSupport::Concern

    included do
      # Relationships
      has_many :user_defined_fields, as: :defineable, dependent: :destroy, class_name: 'UserDefinedFields::UserDefinedField'

      # Nested attributes
      accepts_nested_attributes_for :user_defined_fields, allow_destroy: true

      # Resourceable parameters
      allow_params user_defined_fields_attributes: [:id, :_destroy, *UserDefinedField.permitted_params]
    end
  end
end
