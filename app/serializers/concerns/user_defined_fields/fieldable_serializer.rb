module UserDefinedFields
  module FieldableSerializer
    extend ActiveSupport::Concern

    included do
      index_attributes :user_defined
      show_attributes :user_defined
    end

  end
end
