class CreateMakeups < ActiveRecord::Migration[5.2]
  def change
    create_table :makeups do |t|
      t.string :st

      t.timestamps
    end
  end
end
