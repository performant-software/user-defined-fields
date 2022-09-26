module UserDefinedFields
  module Fieldable
    extend ActiveSupport::Concern

    included do
      allow_params :user_defined
    end
  end
end
