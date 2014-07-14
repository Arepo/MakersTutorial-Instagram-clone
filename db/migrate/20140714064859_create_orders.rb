class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :post, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
