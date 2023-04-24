# frozen_string_literal: true

require "search_object"
require "search_object/plugin/graphql"

module Resolvers
  class InvoiceSearch < GraphQL::Schema::Resolver
    include ActionPolicy::GraphQL::Behaviour
    include SearchObject.module(:graphql)
    scope { authorize! Invoice, to: :scoping }
    type [Types::InvoiceType], null: false

    class InvoiceFilter < ::Types::BaseInputObject
      argument :user_id, ID, required: false
    end

    class InvoiceOrderBy < ::Types::BaseEnum
      value "CREATED_AT_ASC"
      value "CREATED_AT_DESC"
    end

    option :filter, type: InvoiceFilter, with: :apply_filter
    option :order_by, type: InvoiceOrderBy, with: :apply_sort

    def apply_filter(scope, value)
      scope = scope.joins(request: :user).where(users: {id: value[:user_id]}) if value[:user_id].present?

      scope
    end

    def apply_sort(scope, value)
      case value
      when "CREATED_AT_ASC"
        apply_order_by_with_created_at_asc(scope)
      when "CREATED_AT_DESC"
        apply_order_by_with_created_at_desc(scope)
      else
        scope
      end
    end

    def apply_order_by_with_created_at_asc(scope)
      scope.order(created_at: :asc)
    end

    def apply_order_by_with_created_at_desc(scope)
      scope.order(created_at: :desc)
    end
  end
end
