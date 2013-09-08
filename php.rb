dep 'php' do
  met? {

  }
  # requires 'php cli',
  #          'php apache'
end

dep 'php apache' do
  # installs 'libapache2-mod-php5'
end

dep 'php cli' do
  installs 'php5-cli'
  provides 'php'
end
