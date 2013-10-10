# == Schema Information
# Schema version: 20130327155943
#
# Table name: investigator_appointments
#
#  created_at             :timestamp
#  end_date               :date
#  id                     :integer          default(0), not null, primary key
#  investigator_id        :integer          not null
#  organizational_unit_id :integer          not null
#  research_summary       :text
#  start_date             :date
#  type                   :string(255)
#  updated_at             :timestamp
#

class PrimaryAssociateMember < AssociateMember
end
