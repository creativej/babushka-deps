dep 'gems' do
  requires 'capistrano', 'rails'
end

dep 'capistrano' do
  met? { in_path? 'cap' }
  meet { shell 'gem install capistrano' }
end
