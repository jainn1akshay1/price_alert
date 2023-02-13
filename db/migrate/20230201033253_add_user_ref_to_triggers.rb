class AddUserRefToTriggers < ActiveRecord::Migration[5.2]
  def change
    
    add_reference :triggers, :user, foreign_key: true
  end
end
