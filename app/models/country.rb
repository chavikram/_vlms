class Country < ActiveRecord::Base
  validates :name,length: { in: 3..20,
    too_short: "must have at least %{count} characters",
    too_long: "must have at most %{count} characters"
      },presence:true
  validates :code,length: { is: 2,
      message: "not a valid size, it must 2 characters long"
      },presence:true
  
  has_many :states
end
