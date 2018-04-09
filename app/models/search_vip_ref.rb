class SearchVipRef < ActiveRecord::Base
  def self.columns() @columns ||= []; end
 
  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end
  
  column :section_id, :integer
  column :vip_ref_status_id, :integer
  column :vip_category_id, :integer
  column :diary_date_from, :date
  column :diary_date_to, :date
  
  validates :diary_date_from,:diary_date_to, presence:true
  #validates_format_of :from_email, :to_email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  #validates_length_of :message, :maximum => 500
end
