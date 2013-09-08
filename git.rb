dep 'git setup' do
  requires  'git',
            'git config',
            'git config symlink'
end

dep 'git config' do
  met? {
    '~/configs/git'.p.exists?
  }

  meet {
    shell 'git clone git@github.com:creativej/gitconfig.git ~/configs/git'
  }
end

dep 'git config symlink' do
  met? {
    '~/.gitconfig'.p.exists?
  }

  meet {
    shell 'ln -s ~/configs/git/config ~/.gitconfig'
  }
end
