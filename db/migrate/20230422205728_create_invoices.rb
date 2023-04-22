class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.references :request, null: false, foreign_key: true
      t.integer :price

      t.timestamps
    end
  end
end
