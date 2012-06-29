class InvestigatorAppointment < ActiveRecord::Base
  belongs_to :investigator
  belongs_to :organizational_unit, 
    :conditions => ['investigator_appointments.end_date is null']
  belongs_to :center, :foreign_key => :organizational_unit_id
  #belongs_to :organizational_unit
  has_many :investigator_abstracts, :through => :investigator 
  validates_uniqueness_of :investigator_id, :scope => [:organizational_unit_id, :type]

  named_scope :remove_deleted,  :conditions => 'investigator_appointments.end_date is null'
  named_scope :only_members,  :conditions => "investigator_appointments.type = 'Member'"

  def self.has_appointment(unit_id ) 
    appointments = self.find :all, 
         :conditions => ['investigator_appointments.organizational_unit_id = :unit_id  and investigator_appointments.end_date is null ',
         {:unit_id => unit_id }] 
    return appointments.length > 0
  end 

end
