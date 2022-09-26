module UserDefinedFields
  class UserDefinedFieldsController < ApplicationController
    search_attributes :table_name, :column_name
  end
end
