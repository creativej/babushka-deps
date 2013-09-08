dep 'essentials' do
  log 'apt-get update...'
  sudo 'apt-get update'
  log 'apt-get -y upgrade... (May need to run "sudo dpkg --configure -a" manually if this halt)'
  sudo 'apt-get -y upgrade'

  essentials = [
    'build-essential',
    'openssl',
    'libreadline6',
    'libreadline6-dev',
    'curl',
    'zlib1g',
    'zlib1g-dev',
    'libssl-dev',
    'libyaml-dev',
    'libsqlite3-dev',
    'sqlite3',
    'libxml2-dev',
    'libxslt-dev',
    'autoconf',
    'libc6-dev',
    'ncurses-dev',
    'automake',
    'libtool',
    'bison',
    'subversion',
    'libghc6-zlib-dev',
    'libcurl4-openssl-dev',
    'libruby'
  ]

  essentials.each do | item |
    log "installing... #{item}"
    sudo "sudo apt-get -y install #{item}"
  end
end
