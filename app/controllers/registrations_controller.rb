class RegistrationsController < Devise::RegistrationsController
  def new 
    super 
    @office_list= Office.all
  end  
end
