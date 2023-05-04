module UserDefinedFields
  class UserDefinedField < ApplicationRecord
    # Relationships
    belongs_to :defineable, polymorphic: true, optional: true

    # Resourceable parameters
    allow_params :table_name, :column_name, :data_type, :required, :searchable, :allow_multiple, :order, options: []

    # Validations
    validates :order, numericality: { only_integer: true }

    # Constants
    DATA_TYPES = {
      boolean: 'Boolean',
      date: 'Date',
      number: 'Number',
      richText: 'RichText',
      select: 'Select',
      string: 'String',
      text: 'Text'
    }
  end
end
