require 'search_object'
require 'search_object/plugin/graphql'

class Resolvers::RequestSearch < GraphQL::Schema::Resolver
  include SearchObject.module(:graphql)
  scope { Request.all }
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
  option :orderBy, type: RequestOrderBy, with: :apply_sort
    
  def apply_filter(scope, value)
    branches = normalize_filters(value).reduce { |a, b| a.or(b) }
    scope.merge branches
  end

  def normalize_filters(value, branches = [])
    scope = Request.all
    scope = scope.where('price >= ?', value[:price_greater_than]) if value[:price_greater_than]
    scope = scope.where('user_id = ?', value[:user_id]) if value[:user_id]
    branches << scope

    branches
  end

  def apply_sort(scope, value)
    binding.pry
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
    binding.pry
    scope.order(id: :asc)
  end
  
  def apply_order_by_with_created_at_desc(scope)
    binding.pry
    scope.order(id: :desc)
  end

end