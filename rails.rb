dep 'rails' do
  requires 'bundler.gem', 'rails.gem'
end

dep 'bundler.gem' do
  met? { in_path? 'bundle' }
  meet { shell 'gem install bundler' }
end

dep 'rails.gem' do
  met? { in_path? 'rails' }
  meet { shell 'gem install rails' }
end
