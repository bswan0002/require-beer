class Project < ApplicationRecord
  belongs_to :user

  validates_presence_of :title, :desc

  def preview
    special = "?<>',?[]}{=-)(*&^%$#`~{}"
    regex = /[#{special.gsub(/./){|char| "\\#{char}"}}]/

    prev = self.desc.split(" ").first(12)

    if prev.last && prev.last[-1].match(regex)
      prev.last.chop!
      return prev.join(" ") + "..."
    elsif prev.last && prev.length > 4
      return prev.join(" ") + "..."
    else
      return "Preview not available"
    end
  end

  def published
    self.created_at.strftime("%b. %d %Y")
  end

  def self.last_row
    project_count = Project.all.count
    return 0 if project_count < 3
    case project_count%3
    when 0
      return 3
    when 1
      return 1
    when 2
      return 2
    end
  end
end
