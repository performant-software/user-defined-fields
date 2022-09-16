module UserDefinedFields
  class ApplicationController < Api::ResourceController
    def current_user
      return super if defined?(super)

      nil
    end

    def item_class
      "UserDefinedFields::#{controller_name.singularize.classify}".constantize
    end

    def serializer_class
      "UserDefinedFields::#{"#{controller_name}_serializer".classify}".constantize
    end
  end
end
