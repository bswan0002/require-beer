module ApplicationHelper

  def admin?
    current_user && current_user.admin
  end

  def sortable(column)
      if @sort && @sort.include?(column)
        dir = @sort.split("_").last
        dir == "asc" ? new_dir = "desc" : new_dir = "asc"
        css_class = "current #{dir}"
      else
        new_dir = "asc"
        css_class = "current"
      end
      
      link_to column.titleize, sort_by_col_path(c: "#{column}_#{new_dir}"), {:class => css_class}
  end

  def filterable(fparam)
    if @filter && @filter.include?(fparam)
      dir = @filter.split("+").last
      dir == "fwd" ? new_dir = "bkwd" : new_dir = "fwd"
    else
      new_dir = "fwd"
    end
    css_class = "current"
    link_to fparam.titleize, filter_by_fparam_path(f: "#{fparam}+#{new_dir}"), {:class => css_class}
  end

end
