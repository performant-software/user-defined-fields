module UserDefinedFields
  class UserDefinedFieldsController < ApplicationController
    search_attributes :table_name, :column_name

    protected

    def apply_filters(query)
      query = super

      query = filter_defineable(query)

      query
    end

    private

    def filter_defineable(query)
      return query unless params[:defineable_id].present? && params[:defineable_type].present?

      query.where(defineable_id: params[:defineable_id], defineable_type: params[:defineable_type])
    end
  end
end
