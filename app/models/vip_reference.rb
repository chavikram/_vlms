class VipReference < ActiveRecord::Base
  
  validates :letter_no,:letter_date,:subject,presence: true
  validates :letter_no,length: { in: 3..20,
    too_short: "must have at least %{count} characters",
    too_long: "must have at most %{count} characters"
      },presence:true
  validates :letter_date,:diaried_date, date: true
  validates :received_on, date: true,allow_blank: true
  validates :eoffice_receipt_no,length: { in: 3..20,
    too_short: "must have at least %{count} characters",
    too_long: "must have at most %{count} characters"
      },presence:true,allow_blank: true
  
   validates :eoffice_file_no,length: { in: 3..20,
    too_short: "must have at least %{count} characters",
    too_long: "must have at most %{count} characters"
      },presence:true,allow_blank: true
 
   validates :subject,length: { in: 3..200,
    too_short: "must have at least %{count} characters",
    too_long: "must have at most %{count} characters"
      },presence:true
      
  validates :section,:vip_ref_status,:vip_category,:user,presence: true
 
  belongs_to :section
  belongs_to :vip_ref_status
  belongs_to :vip_category, lambda { order('name ASC')}
  has_one :category, :through => :vip_category
   
  has_many :vip_ref_transfers, lambda { order('transferred_on DESC')}
  has_many :vip_ref_movements, lambda { order('sent_on DESC')}
  has_many :vip_ref_summaries, lambda { order('created_at DESC')}
  belongs_to :user
  has_one :sender
  
  accepts_nested_attributes_for :sender, :allow_destroy => true
  
  scope :closed,->{where("vip_ref_status_id=2")}
  scope :draft,->{where("vip_ref_status_id='4'")}
  scope :pending,->{where("vip_ref_status_id='1'")}
  scope :pending_lessthan_1mth,->{where("vip_ref_status_id='1' and diaried_date >= ? ", 1.month.ago)}
  scope :pending_lessthan_3mth,->{where("vip_ref_status_id='1' and diaried_date < ? and diaried_date >= ? ", 1.month.ago, 3.month.ago)}
  scope :pending_morethan_3mth,->{where("vip_ref_status_id='1' and diaried_date < ? ", 3.month.ago)}
  scope :updated_today, ->{joins(:vip_ref_summaries).where("vip_ref_summaries.updated_at>='#{Date.today}'")}
  scope :vip, -> {joins(:vip_category).where('category_id=?',Category.where('name ilike \'%vip%\'').first.id)}
  scope :nonvip, -> {joins(:vip_category).where('category_id=?',Category.where('name ilike \'%non-vip%\'').first.id)}
  scope :pmo, -> {joins(:vip_category).where('category_id=?',Category.where('name ilike \'%pmo%\'').first.id)}
  def isOwner?(user_id)
    if self.vip_ref_movements.empty?
      if self.user_id == user_id
        return true
      end
    elsif self.vip_ref_movements.try(:first).try(:sent_to) == user_id
      return true
    else 
      return false
    end
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |vip_reference|
        csv << vip_reference.attributes.values_at(*column_names)
      end
    end
  end
  
  def current_status
    return self.vip_ref_status.status_name
  end
  
  def dealing_section
    if self.vip_ref_transfers.count == 0
      return self.section
    else
      return self.vip_ref_transfers.first.to
    end
  end
end
