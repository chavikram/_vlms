class VipRefAppController < ApplicationController

  before_action :authenticate_user!
  
  def homescreen
    @sections = Section.unscoped.all.joins(:vip_references).select("sections.id,sections.name").group("sections.id,sections.name").order("count(vip_references.id) desc").paginate(page: params[:page], per_page: 10)
    @sectionsbydisposal=@sections .sort_by{|s| s.vip_references.vip.count!=0?(s.vip_references.vip.closed.count*100/s.vip_references.vip.count.to_f).round():0}.reverse!
    @sectionsbydisposal=@sectionsbydisposal
  end
  
  def monthwisereport
      @sections=Hash.new
      if params[:type]=='all'
        Section.all.each do |section|
            temp=section.vip_references.vip.pending.group_by_month(:diaried_date, format: "%b %Y").count
            if temp.size != 0
              @sections["#{section.name}"]=temp
            end
        end
      else
        current_user.sections.each do |section|
          temp=section.vip_references.vip.pending.group_by_month(:diaried_date, format: "%b %Y").count
          if temp.size != 0
            @sections["#{section.name}"]=temp
          end
        end
      end
      
      respond_to do |format|
          format.html
          format.pdf do
            render :pdf => "Month wise summary report",
                   :template => 'vip_ref_app/monthwisereport.pdf.haml',
                   #:layout => 'vip_references/pdflayout.pdf.haml',
                   :layout => 'vip_references/pdflayout.pdf.haml',
                    :orientation => 'Landscape',
                    :show_as_html => params[:download]=='true'?false:true,
                    :page_size => 'A4',
                    :footer=>{
                       :center => "VIP References Monitoring System ",
                      :left => "#{l Time.now}",
                      :right => "Developed by CAID,NIC,M/o CA",
                      :font_size=>10,
                    },
                   :margin => {:top=>5,:bottom=>10}
          end         
      end
  end


  def disposalreport

    category_id= params.has_key?(:category_id) ? params[:category_id] : Category.all.first
    @sections = Section.unscoped.all.select("sections.id,sections.name").joins("inner join vip_references on vip_references.section_id= sections.id 
       inner join vip_categories on vip_categories.id = vip_references.vip_category_id 
       inner join categories on categories.id =vip_categories.category_id
      ").
    group("sections.id,sections.name").order("count(vip_references.id) desc")
    .where("categories.id= ?",category_id)
    .paginate(page: params[:page], per_page: 10)


    @sectionsbydisposal=@sections.sort_by{|s| s.vip_references.vip.count!=0?
      (s.vip_references.vip.closed.count*100/s.vip_references.vip.count.to_f).round():0}
      .reverse!
    @sectionsbydisposal=@sectionsbydisposal

    respond_to do |format|
        format.html
        format.pdf do
          render :pdf => "Section-wise disposal summary report",
                 :template => 'vip_ref_app/disposalreport.pdf.haml',
                 :layout => 'vip_references/pdflayout.pdf.haml',
                  :orientation => 'Landscape',
                  :show_as_html => params[:download]=='true'?false:false,
                  :page_size => 'A4',
                  :footer=>{
                     :center => "VIP References Monitoring System ",
                    :left => "#{l Time.now}",
                    :right => "Developed by CAID,NIC,M/o CA",
                    :font_size=>10,
                  },
                 :margin => {:top=>5,:bottom=>10}
        end         
    end
  end
  
  def home

    @sections = Section.unscoped.all.joins(:vip_references).select("sections.id,sections.name").group("sections.id,sections.name").order("count(vip_references.id) desc").paginate(page: params[:page], per_page: 10)
    @sectionsbydisposal=@sections.sort_by{|s| s.vip_references.vip.count!=0?(s.vip_references.vip.closed.count*100/s.vip_references.vip.count.to_f).round():0}.reverse!
    @sectionsbydisposal=@sectionsbydisposal.paginate(page: params[:page], per_page: 10)
    @vip_categories = VipCategory.all
    @senders= []
    VipReference.joins(:sender).group(:state).count.each{|c| @senders << [State.find(c[0]).name, c[1]]}

  end
  
  def statewisereport
    @senders= []
    VipReference.joins(:sender).group(:state).count.each{|c| @senders << [State.find(c[0]).name, c[1]]}

    respond_to do |format|
        format.html
        format.pdf do
          render :pdf => "Vip References Pending Report as on #{l Time.now}",
                 :template => 'vip_ref_app/statewisereport.pdf.haml',
                 :layout => 'vip_references/pdflayout.pdf.haml',
                  :orientation => 'Landscape',
                  :page_size => 'A4',
                  :footer=>{
                     :center => "VIP References Monitoring System ",
                    :left => "#{l Time.now}",
                    :right => "Developed by CAID,NIC,M/o CA",
                    :font_size=>10,
                  },
                 :margin => {:top=>5,:bottom=>10}
        end         
    end
  end

  def category_wise_pendency
    @vip_categories = VipCategory.all
    respond_to do |format|
        format.html
        format.pdf do
          render :pdf => "Vip References Pending Report as on #{l Time.now}",
                 :template => 'vip_ref_app/category_wise_pendency.pdf.haml',
                 :layout => 'vip_references/pdflayout.pdf.haml',
                  :orientation => 'Landscape',
                  
                  :page_size => 'A4',
                  :footer=>{
                     :center => "VIP References Monitoring System ",
                    :left => "#{l Time.now}",
                    :right => "Developed by CAID,NIC,M/o CA",
                    :font_size=>10,
                  },
                 :margin => {:top=>5,:bottom=>10}
        end         
    end
  end

  def pending_report_1
    #@sections = Section.unscoped.all.joins(:vip_references).group("sections.id").group("vip_references.id").order("count(vip_references.id) desc")
    @sections = Section.unscoped.all.joins(:vip_references).select("sections.id,sections.name").group("sections.id,sections.name").order("count(vip_references.id) desc")
    #@sections = Section.unscoped.all
    respond_to do |format|
        format.html
        format.pdf do
          
          render :pdf => "Vip References Pending Report as on #{l Time.now}",
                 :template => 'vip_ref_app/pending_report_1.pdf.haml',
                 :layout => 'vip_references/pdflayout.pdf.haml',
                  :orientation => 'Landscape',
                  :show_as_html => params[:download]=='true'?false:true,
                  :page_size => 'A4',
                  :footer=>{
                     :center => "VIP References Monitoring System ",
                    :left => "#{l Time.now}",
                    :right => "Developed by CAID,NIC,M/o CA",
                    :font_size=>10,
                  },
                 :margin => {:top=>5,:bottom=>10}
        end         
    end
  end
  
  def pending_report
    @sections = Section.unscoped.all.joins(:vip_references).select("sections.id,sections.name").group("sections.id,sections.name").order("count(vip_references.id) desc").paginate(page: params[:page], per_page: 10)
    
    respond_to do |format|
        format.html
        format.pdf do
          render :pdf => "Vip References Pending Report as on #{l Time.now}",
                 :template => 'vip_ref_app/pending_report.pdf.haml',
                 :layout => 'vip_references/pdflayout.pdf.haml',
                  :orientation => 'Landscape',
                  :page_size => 'A4',
                  :footer=>{
                     :center => "VIP References Monitoring System ",
                    :left => "#{l Time.now}",
                    :right => "Developed by CAID,NIC,M/o CA",
                    :font_size=>10,
                  },
                 :margin => {:top=>5,:bottom=>10}
        end         
    end
  end
  
  def report
  end
  
  def chart
    respond_to do |format|
        format.html
        format.pdf do
          render :pdf => "Vip References  Report as on #{l Time.now}",
                 :template => 'vip_ref_app/chart.pdf.haml',
                 :layout => 'vip_references/pdflayout.pdf.haml',
                  
                  :page_size => 'A4',
                  :wkhtmltopdf=>'/usr/local/bin/wkhtmltopdf',
                  :javascript_delay => 5000,
                  :footer=>{
                     :center => "VIP References Monitoring System ",
                    :left => "#{l Time.now}",
                    :right => "Developed by CAID,NIC,M/o CA",
                    :font_size=>10,
                  },
                 :margin => {:top=>5,:bottom=>10}
        end         
    end
  end

  def inbox_section

    #selectQuery= "select v1.* from vip_references as v1 where v1.section_id =? "
    selectQuery=" select v1.* from vip_ref_transfers as vm1 left join vip_references as v1 
                  on v1.id=vm1.vip_reference_id left join vip_ref_statuses as vrs1 
                  on v1.vip_ref_status_id = vrs1.id
                  left join vip_categories 
                  as vipcat on v1.vip_category_id = vipcat.id 
                  left join categories as cat on vipcat.category_id = cat.id 
                   where vrs1.status_name ilike '%pending%' and
                  vm1.transferred_on = (select max(vm.transferred_on) from vip_ref_transfers as vm 
                  where vm.vip_reference_id=v1.id group by vm.vip_reference_id ) 
                  and vm1.to_id= ? and cat.id = ? order by v1.diaried_date asc"
    section_id= params.has_key?(:section_id) ? params[:section_id] : current_user.sections.first.id
    category_id= params.has_key?(:category_id) ? params[:category_id] : Category.all.first



    @vip_references= VipReference.find_by_sql([selectQuery,section_id,category_id])
    @vip_references=@vip_references.paginate(page: params[:page], per_page: 10)
  end

  
  def closed
      selectQuery=" select v1.* from vip_ref_transfers as vm1 left join vip_references as v1 
                  on v1.id=vm1.vip_reference_id left join vip_ref_statuses as vrs1 
                  on v1.vip_ref_status_id = vrs1.id 
                  left join vip_categories 
                  as vipcat on v1.vip_category_id = vipcat.id 
                  left join categories as cat on vipcat.category_id = cat.id  

                  where vrs1.status_name ilike '%closed%' and
                  vm1.transferred_on = (select max(vm.transferred_on) from vip_ref_transfers as vm 
                  where vm.vip_reference_id=v1.id group by vm.vip_reference_id ) 
                  and vm1.to_id= ? and cat.id =?  order by v1.diaried_date asc "

    section_id= params.has_key?(:section_id) ? params[:section_id] : current_user.sections.first.id
    category_id= params.has_key?(:category_id) ? params[:category_id] : Category.all.first

      
      @vip_references= VipReference.find_by_sql([selectQuery,section_id,category_id])
      @vip_references=@vip_references.paginate(page: params[:page], per_page: 10)

  end
    
  def inbox
      # if current_user.is_admin?
        # selectQuery="select v1.* from vip_ref_movements as vm1 left join vip_references as v1 on v1.id=vm1.vip_reference_id where 
              # vm1.sent_on = (select max(vm.sent_on) from vip_ref_movements as vm where vm.vip_reference_id=v1.id 
                 # group by vm.vip_reference_id ) order by vm1.sent_on desc"
        # @vip_references=VipReference.find_by_sql(selectQuery)
        #         
      # else
        selectQuery="select v1.* from vip_ref_movements as vm1 left join vip_references as v1 on v1.id=vm1.vip_reference_id where 
              vm1.sent_to = ? and vm1.sent_on = (select max(vm.sent_on) from vip_ref_movements as vm where vm.vip_reference_id=v1.id 
                 group by vm.vip_reference_id ) order by vm1.sent_on desc"
        @vip_references=VipReference.find_by_sql([selectQuery,current_user.id])
      # end  
      @vip_references=@vip_references.paginate(page: params[:page], per_page: 10)
  end

  def draft

    selectQuery=" select v1.*  from vip_references as v1 
         left join vip_ref_statuses as vrs1 
        on v1.vip_ref_status_id = vrs1.id 
        left join vip_categories as vipcat
         on v1.vip_category_id = vipcat.id 
        left join categories as cat 
        on vipcat.category_id = cat.id  
        where vrs1.status_name ilike '%draft%' and
        not exists (select count(*) from vip_ref_transfers as vm 
        where vm.vip_reference_id=v1.id group by vm.vip_reference_id ) 
        and v1.section_id= ? and cat.id =?  order by v1.diaried_date asc "

    section_id= params.has_key?(:section_id) ? params[:section_id] : current_user.sections.first.id
    category_id= params.has_key?(:category_id) ? params[:category_id] : Category.all.first

      
      @vip_references= VipReference.find_by_sql([selectQuery,section_id,category_id])

      @vip_references=@vip_references.paginate(page: params[:page], per_page: 10)

  end

  def sent
         selectQuery="select vt1.* from vip_ref_transfers as vt1 left join vip_references as v1 
                          left join vip_categories 
                          as vipcat on v1.vip_category_id = vipcat.id 
                          left join categories as cat on vipcat.category_id = cat.id  


                      on v1.id=vt1.vip_reference_id where vt1.from_id=?  and cat.id =? and vt1.from_id!=vt1.to_id" 

            section_id= params.has_key?(:section_id) ? params[:section_id] : current_user.sections.first.id
          category_id= params.has_key?(:category_id) ? params[:category_id] : Category.all.first



          @transfers= VipRefTransfer.find_by_sql([selectQuery,section_id,category_id])
        @transfers=@transfers.paginate(page: params[:page], per_page: 10)
         # end
  end
  
end
