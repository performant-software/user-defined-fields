module UserDefinedFields
  module DefineableSerializer
    extend ActiveSupport::Concern

    included do
      show_attributes user_defined_fields: UserDefinedFieldsSerializer
    end

  end
end
