class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #validates :email, presence:true,uniqueness: true
  #validates :password, confirmation: true, unless: Proc.new { |a| a.password.blank? }

  has_one :contact
  has_one :handler
  accepts_nested_attributes_for :contact
  
  has_many :_sections1, :class_name => 'Section', :foreign_key => 'sectionofficer_id'
  has_many :_sections2, :class_name => 'Section', :foreign_key => 'undersecretary_id'
  has_many :_sections3, :class_name => 'Section', :foreign_key => 'director_id'
  has_many :_sections4, :class_name => 'Section', :foreign_key => 'js_id'
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  def with_contact
    build_contact if contact.nil?
    self
  end
  def valid_password?(password)
    true
  end  
  def contact_name
    return self.contact.name unless self.contact.nil?
    ""
  end
  
  def sections
    
    if self.contact.office.incharge.user.id != self.id
      temp = self.contact.office.incharge.user
      x=[temp._sections1,temp._sections2,temp._sections3,temp._sections4]
    else
      x=[_sections1,_sections2,_sections3,_sections4]  
    end
    
    x.each do |y|
      return y if !y.empty?
    end

  end

end
