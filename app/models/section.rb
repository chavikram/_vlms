class Section < ActiveRecord::Base
    validates :name,:short_name, presence:true
    validates :name,length: { in: 3..20,
    too_short: "must have at least %{count} characters",
    too_long: "must have at most %{count} characters"
      },presence:true
    validates :short_name,length: { in: 2..10,
    too_short: "must have at least %{count} characters",
    too_long: "must have at most %{count} characters"
      },presence:true
    validates :sectionofficer,:undersecretary,:director,:js,presence: true
    
    default_scope {order(:id)}
    has_many :vip_references
    
    belongs_to :sectionofficer, class_name: "User"
    belongs_to :undersecretary, class_name: "User"
    belongs_to :director, class_name: "User"
    belongs_to :js, class_name: "User"
    def to_s
      "#{name}"
    end
end
