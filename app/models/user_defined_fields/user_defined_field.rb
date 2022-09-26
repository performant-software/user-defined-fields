module UserDefinedFields
  class UserDefinedField < ApplicationRecord
    # Relationships
    belongs_to :defineable, polymorphic: true, optional: true

    # Resourceable parameters
    allow_params :table_name, :column_name, :data_type, :required, :allow_multiple, options: []
  end
end
