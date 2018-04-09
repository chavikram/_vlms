class CreateVipReferences < ActiveRecord::Migration
  def change
    create_table :vip_references do |t|
      t.string :letter_no
      t.date :letter_date
      t.text :subject
      t.date :diaried_date
      t.integer :diaried_by
      t.string :sender_name
      t.references :section, index: true
      t.references :vip_ref_status, index: true
      t.references :vip_category, index: true
      t.date :received_on
      t.string :eoffice_receipt_no
      t.string :eoffice_file_no
      t.boolean :deleted

      t.timestamps
    end
  end
end
