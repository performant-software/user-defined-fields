module UserDefinedFields
  class UserDefinedField < ApplicationRecord
    belongs_to :defineable, polymorphic: true, optional: true
  end
end
