pdf.font "Courier"
pdf.text "Vip References Report", :size => 14, :style => :bold
pdf.move_down(30)

items = @vip_references_for_pdf.map do |item|
  [
    "#{item.letter_no}  (#{l item.letter_date})",
    item.subject,
    item.sender.try(:name),
    item.section.name,
    (l item.diaried_date),
    if item.vip_ref_movements.count!=0
      User.find(item.vip_ref_movements.first.try(:sent_to)).contact.office.name
    else
      "**"
    end    ,
    item.vip_ref_status.status_name,
    item.vip_ref_summaries.try(:first).try(:summary_text)
  ]
end


pdf.table items,{:header =>true,:row_colors => ["d2e3ed", "FFFFFF"]} do |table|
  table.row(0).font_style = :bold
end
 
pdf.move_down(10)
