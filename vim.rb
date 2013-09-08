CONFIG_PATH = '~/configs/vim'

dep 'vim' do
  requires  'vim.bin',
            'vim vundle',
            'vim basic config',
            'vim config symlink'
end

dep 'vim.bin' do
  installs 'vim'
end

dep 'vim config' do
  met? { CONFIG_PATH.p.exists? }

  meet {
    shell "git clone git@github.com:creativej/vim-config.git #{CONFIG_PATH}"
  }
end

dep 'vim basic config' do
  requires 'vim config'

  met? {
    shell("cd #{CONFIG_PATH}; git branch")[/.+bare/]
  }

  meet {
    shell("cd #{CONFIG_PATH}; git co bare")
  }
end

dep 'vim config symlink' do
  met? { '~/.vimrc'.p.exists? }

  meet {
    shell "ln -s #{CONFIG_PATH}/vimrc ~/.vimrc"
    shell "ln -s #{CONFIG_PATH}/colors ~/.vim/colors"
  }
end

dep 'vim vundle' do
  requires 'vim .vim dir'

  met? {
    '~/.vim/vundle.git'.p.exists?
  }

  meet {
    shell "git clone https://github.com/gmarik/vundle.git ~/.vim/vundle.git"
  }
end

dep 'vim .vim dir' do
  met? { '~/.vim'.p.exists? }

  meet { shell 'mkdir ~/.vim' }
end
