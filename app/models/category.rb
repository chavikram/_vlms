class Category < ActiveRecord::Base
  validates :name,length: { in: 3..20,
    too_short: "must have at least %{count} characters",
    too_long: "must have at most %{count} characters"
      },presence:true

  has_many :vip_categories
  has_many :vip_references,:through => :vip_category
  scope :default, lambda { where(:default => true).order(:order) }

end
