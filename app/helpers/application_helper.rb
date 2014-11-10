module ApplicationHelper
  def participants_select_collection(discourse)
    discourse.project.participants.map { |participant|
      full_name = "#{participant.surname} #{participant.name} #{participant.patronymic}".squish

      [full_name, full_name]
    }
  end
end
