dep 'apt update' do
  meet {
    sudo 'apt-get update'
  }
end
