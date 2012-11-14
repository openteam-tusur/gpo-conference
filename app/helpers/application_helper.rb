module ApplicationHelper
  def project_participants_select_collection(discourse)
    discourse.project.participants.map { |participant|
      full_name = "#{participant.last_name} #{participant.first_name} #{participant.mid_name}".squish

      [full_name, full_name]
    }
  end
end
