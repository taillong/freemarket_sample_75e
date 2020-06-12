crumb :root do
  link "Home", root_path
end

crumb :user do
  link "マイページ", user_path
  parent :root
end

crumb :card do
  link "支払方法", card_user_path
  parent :user
end

crumb :logout do
  link "ログアウト", logout_user_path
  parent :user
end

crumb :card_show do
  link "クレジットカード詳細", user_card_path(current_user.card)
  parent :card
end

crumb :item_show do |item|
  link item.name, item_path(item.id)
  parent :root 
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).