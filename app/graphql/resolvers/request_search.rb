require 'search_object'
require 'search_object/plugin/graphql'

class Resolvers::RequestSearch < GraphQL::Schema::Resolver
  include ActionPolicy::GraphQL::Behaviour
  include SearchObject.module(:graphql)
  scope { authorize! Request, to: :scoping }
  type [Types::RequestType], null: false

  class RequestFilter < ::Types::BaseInputObject
    argument :price_greater_than, Integer, required: false
    argument :user_id, ID, required: false
  end

  class RequestOrderBy < ::Types::BaseEnum
    value 'createdAt_ASC'
    value 'createdAt_DESC'
  end

  option :filter, type: RequestFilter, with: :apply_filter
  option :order_by, type: RequestOrderBy, with: :apply_sort
    
  def apply_filter(scope, value)
    scope = scope.where('price >= ?', value[:price_greater_than]) if value[:price_greater_than]
    scope = scope.where('user_id = ?', value[:user_id]) if value[:user_id]
    
    scope
  end

  def apply_sort(scope, value)
    case value
    when 'createdAt_ASC'
      apply_order_by_with_created_at_asc(scope)
    when 'createdAt_DESC'
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