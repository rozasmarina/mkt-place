class CreateAnnounces < ActiveRecord::Migration[6.0]
  def change
    create_table :announces do |t|
      t.references :user, null: false, foreign_key: true
      t.string :announce_type
      t.integer :quantity
      t.string :product_name
      t.text :product_description
      t.string :product_category
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
