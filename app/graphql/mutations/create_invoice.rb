# frozen_string_literal: true

module Mutations
  class CreateInvoice < BaseMutation
    argument :request_id, ID, required: true

    field :invoice, Types::InvoiceType, null: true
    field :errors, [String], null: true

    def resolve(request_id:)
      request = Request.find(request_id)
      num_days = (request.end_date - request.start_date).to_i
      room_price = request.room.price
      total_price = num_days * room_price
      invoice = Invoice.new(request: request, price: total_price)
      if invoice.save
        {
          invoice: invoice,
          errors: []
        }
      else
        {
          invoice: nil,
          errors: invoice.errors.full_messages
        }
      end
    end
  end
end