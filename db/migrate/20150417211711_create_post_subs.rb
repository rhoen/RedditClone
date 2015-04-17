class CreatePostSubs < ActiveRecord::Migration
  def change
    create_table :post_subs do |t|
      t.integer :sub_id
      t.integer :post_id

      t.timestamps null: false
    end
  end
end
