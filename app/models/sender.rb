class Sender < ActiveRecord::Base
  belongs_to :vip_reference
# validates :name,:designation,:org,:address1,:address2,:city,:pincode,:mobile,:landline,:email, presence: true
  validates :name,:designation, presence: true
  
  validates :pincode,length: { is: 6,
    message: "length must 6 characters long",
      },presence:true,numericality: true,allow_blank: true 
      
  validates :mobile,length: { is: 10,
    message: "length must be 10 characters long",
          },presence:true,numericality: true,allow_blank: true 
      
  validates :landline,length: { is: 10,
    message: "length must be 10 characters long",
      },presence:true,numericality: true,allow_blank: true 

  validates :org,:address1,:address2,length: { maximum: 50,
    message: "can't be more 25 characters",
      },presence:true,allow_blank: true 
  
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :message=> 'invalid email address', allow_blank: true

end
