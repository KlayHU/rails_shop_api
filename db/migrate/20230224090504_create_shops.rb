class CreateShops < ActiveRecord::Migration[7.0]
  def change
    create_table :shops do |t|
      t.string :name, null:false, default:''
      t.index :name
      t.integer :products_count, null:false, default:0
      t.integer :order_count, null:false, default:0
      t.integer :user_id, null:false, default:0

      t.timestamps
    end
  end
end
