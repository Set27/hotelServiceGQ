# frozen_string_literal: true

module Mutations
  class CreateInvoice < BaseMutation
    argument :request_id, ID, required: true

    field :invoice, Types::InvoiceType, null: true

    def resolve(request_id:)
      authorize! Invoice, to: :create?

      request = Request.find(request_id)

      num_days = (request.end_date - request.start_date).to_i
      room_price = request.room.price
      total_price = num_days * room_price

      invoice = Invoice.new(request: request, price: total_price)
      if invoice.save
        room = request.room
        room.update(is_occupied: true)
        {
          invoice: invoice,
        }
      else
        errors = user.errors.full_messages.map { |error| { message: error } }
        raise GraphQL::ExecutionError.new(
          "Failed to create invoice", extensions: { errors: errors }
        )
      end
    end
  end
end