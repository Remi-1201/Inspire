

      @blogs =
      if params[:search_title].blank? && params[:search_detail].blank?
        Blog.all.order(created_at: :desc).kaminari(params[:page])
      elsif params[:search_title].present? && params[:search_detail].present?
        Blog.where('title LIKE ?', "%#{params[:search_title]}%").where(detail: params[:search_detail]).order(created_at: :desc).kaminari(params[:page])
      elsif params[:search_title].present? && params[:search_detail].blank?
        Blog.where('title LIKE ?', "%#{params[:search_title]}%").order(created_at: :desc).kaminari(params[:page])
      elsif params[:search_title].blank? && params[:search_detail].present?
        Blog.where('detail LIKE ?', "%#{params[:search_detail]}%").order(created_at: :desc).kaminari(params[:page])
      end
    end
    render :index
  end
end
   
<div class="sort_search">
<%= form_with(url: sort_tasks_path, local: true) do |f| %>
  <%= select_tag :sort, options_for_select([["Sort by created time","created_at"],["Sort by deadline","deadline"],["Sort by priority","priority"]]), { class: 'sort_select' } %>
  <%= submit_tag "ソート" %>
<% end %>  

<%= form_with url: tasks_path, method: :get, local: true do |form| %>
<%= form.select("label_id", Label.pluck(:name, :id), { include_blank: true }) %>
<%= form.submit 'ラベル検索', name: nil %>
<% end %> </div> 