def index
  @task = Task.new
  @tasks = Task.all.order(created_at: :desc).kaminari(params[:page])
end

def sort
  @tasks =
    if params[:sort] == 'created_at'
      Task.all.order(created_at: :desc).kaminari(params[:page])
    elsif params[:sort] == 'deadline'
      Task.all.order(deadline: :asc).kaminari(params[:page])
    elsif params[:sort] == 'priority'
      Task.all.order(priority: :asc).kaminari(params[:page])
    end
    render :index
end

def search
  @tasks =
  if params[:search_name].blank? && params[:search_status].blank?
    Task.all.sorted.kaminari(params[:page])
  elsif params[:search_name].present?
    if params[:search_status].present? && params[:search_priority].present?
      Task.search_sort(params[:search_name]).status_sort(params[:search_status]).priority_sort(params[:search_priority]).sorted.kaminari(params[:page])
    elsif params[:search_status].present? && params[:search_priority].blank?
      Task.search_sort(params[:search_name]).status_sort(params[:search_status]).sorted.kaminari(params[:page])
    elsif params[:search_status].blank? && params[:search_priority].present?
      Task.search_sort(params[:search_name]).priority_sort(params[:search_priority]).sorted.kaminari(params[:page])
    else
      Task.search_sort(params[:search_name]).sorted.kaminari(params[:page])
    end
  elsif params[:search_status].present?
    if params[:search_priority].present?
      Task.status_sort(params[:search_status]).priority_sort(params[:search_priority]).sorted.kaminari(params[:page])
    else
      Task.status_sort(params[:search_status]).sorted.kaminari(params[:page])
    end
  elsif params[:search_priority].present?
    Task.priority_sort(params[:search_priority]).sorted.kaminari(params[:page])
  end
  render :index
end