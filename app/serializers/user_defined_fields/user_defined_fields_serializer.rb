module UserDefinedFields
  class UserDefinedFieldsSerializer < BaseSerializer
    index_attributes :id, :table_name, :column_name, :data_type, :required, :searchable, :allow_multiple, :options
    show_attributes :id, :table_name, :column_name, :data_type, :required, :searchable, :allow_multiple, :options
  end
end
