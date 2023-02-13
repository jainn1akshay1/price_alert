class CreateTriggers < ActiveRecord::Migration[5.2]
  def change
    create_table :triggers do |t|
      t.string :status
      t.integer :price
      t.timestamps
    end
  end
end
