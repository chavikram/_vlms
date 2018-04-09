class CreateDesignations < ActiveRecord::Migration
  def change
    create_table :designations do |t|
      t.string :name
      t.boolean :default

      t.timestamps
    end
  end
end
