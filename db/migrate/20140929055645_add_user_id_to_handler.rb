class AddUserIdToHandler < ActiveRecord::Migration
  def change
    add_column :handlers, :user_id, :integer
  end
end
