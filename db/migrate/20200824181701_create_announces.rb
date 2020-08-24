class CreateAnnounces < ActiveRecord::Migration[6.0]
  def change
    create_table :announces do |t|
      t.references :user, null: false, foreign_key: true
      t.string :type
      t.integer :quantity
      t.integer :price
      t.string :product_name
      t.text :product_description
      t.string :product_category

      t.timestamps
    end
  end
end
