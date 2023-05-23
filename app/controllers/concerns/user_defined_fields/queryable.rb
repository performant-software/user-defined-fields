module UserDefinedFields
  module Queryable
    extend ActiveSupport::Concern

    SORT_ASCENDING = 'ASC'
    SORT_DESCENDING = 'DESC'

    included do
      search_methods :search_user_defined
      sort_methods :apply_user_defined_sort

      def apply_user_defined_sort(query)
        sort_by = params[:sort_by]&.to_sym
        sort_direction = params[:sort_direction] === 'descending' ? SORT_DESCENDING : SORT_ASCENDING

        user_defined_field = UserDefinedField.find_by(
          defineable_id: params[:defineable_id],
          defineable_type: params[:defineable_type],
          column_name: sort_by
        )

        return query if user_defined_field.nil?

        table_alias = table_name(user_defined_field.table_name)

        case user_defined_field.data_type
        when UserDefinedField::DATA_TYPES[:date]
          query.order(Arel.sql("(#{table_alias}.user_defined->>'#{sort_by}')::TIMESTAMPTZ #{sort_direction}"))
        when UserDefinedField::DATA_TYPES[:number]
          query.order(Arel.sql("(#{table_alias}.user_defined->>'#{sort_by}')::DECIMAL #{sort_direction}"))
        else
          query.order(Arel.sql("#{table_alias}.user_defined->>'#{sort_by}' #{sort_direction}"))
        end
      end

      def search_user_defined(query)
        return query unless params[:search].present?

        fields_query = UserDefinedField.where({
          defineable_id: params[:defineable_id],
          defineable_type: params[:defineable_type],
          searchable: true
        })

        fields = fields_query.pluck(:table_name, :column_name)
        return query if fields.size == 0

        or_query = nil

        fields.each do |table, name|
          attribute_query = item_class.where("#{table_name(table)}.user_defined->>'#{name}' ILIKE ?", "%#{params[:search]}%")

          if or_query.nil?
            or_query = attribute_query
          else
            or_query = or_query.or(attribute_query)
          end
        end

        query.or(or_query)
      end

      private

      def table_name(name)
        name.constantize.table_name
      end
    end

  end
end
