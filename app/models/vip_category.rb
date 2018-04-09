class VipCategory < ActiveRecord::Base
  
  validates :name,length: { in: 3..20,
    too_short: "must have at least %{count} characters",
    too_long: "must have at most %{count} characters"
      },presence:true
  
  validates :s_name,length: { in: 2..10,
    too_short: "must have at least %{count} characters",
    too_long: "must have at most %{count} characters"
      },presence:true
      
    validates :category,presence: true
       
  has_many :vip_references
  default_scope { order('name ASC') }
  scope :default, lambda { where(:default => true) }
  
  belongs_to :category
  
  def isVip?
    if self.category.id ==1 
      return true
    else 
      return false
    end
  end
  
  def to_s
    "#{name}"
  end
  
end
