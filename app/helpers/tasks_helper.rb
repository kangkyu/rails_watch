module TasksHelper

  def complete_button_tag(task)
    if task.statuses.find_by(user_id: current_user.id).completed
      button_tag "w", value: false, class: "buttons"
    else
      button_tag "check", value: true, class: "buttons"
    end
  end

  def title_format(task)
    if task.title.blank?
      "title missing"
    else
      task.title
    end
  end
end