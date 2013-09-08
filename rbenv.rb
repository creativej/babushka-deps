dep 'rbenv' do
  PROFILE_CONFIG = '~/.profile'

  met? { '~/.rbenv'.p.exists? }
  meet {
    cd('~') {
      log_shell 'Cloning rbenv', "git clone https://github.com/sstephenson/rbenv.git .rbenv"
      log_shell(
        'Add ~/.rbenv/bin to your $PATH for access to the rbenv command-line utility.',
        "echo 'export PATH=\"$HOME/.rbenv/bin:$PATH\"' >> #{PROFILE_CONFIG}"
      )
      log_shell(
        'Add rbenv init to your shell to enable shims and autocompletion.',
        "echo 'eval \"$(rbenv init -)\"' >> #{PROFILE_CONFIG}"
      )
      shell('exec $SHELL -l')
    }
  }
  after {
    log "NOTE: Please log out and back in again to enable rbenv"
  }
end

dep 'rbenv ruby-build' do
  met? { '~/.rbenv/plugins/ruby-build'.p.exists? }
  meet {
    shell('git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build')
  }
end

meta :rbenv do
  accepts_value_for :builds, :basename

  template {
    def version
      builds
    end

    requires  'rbenv', 'rbenv ruby-build'

    met? {
      shell('rbenv versions')[/#{version}\b/]
    }

    meet {
      log_shell "Installing ruby #{version}. This will take a while...", "rbenv install #{version}"
    }

    after {
      log_shell 'rbenv rehash', 'rbenv rehash'
      shell('rbenv global #{versions}')
    }
  }
end

dep '1.9.3-p448.rbenv'
dep '2.0.0-p247.rbenv'

