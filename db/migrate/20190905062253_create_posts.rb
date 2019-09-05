class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :quote
      t.string :image_url

      t.timestamps
    end
  end
end
