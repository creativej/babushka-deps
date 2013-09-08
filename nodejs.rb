dep "nodejs" do
  # https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager
  # https://github.com/joyent/node/wiki/Installation
  requires \
    "nodejs deb",
    "nodejs path setup"
end


dep "python-software-properties" do
  met? { `dpkg -s python-software-properties 2>&1`.include?("\nStatus: install ok installed\n") }
  meet { sudo "apt-get -y install python-software-properties" }
end

dep "nodejs deb" do
  requires "python-software-properties"
  met? { `dpkg -s nodejs 2>&1`.include?("\nStatus: install ok installed\n") }
  meet {
    sudo 'apt-add-repository ppa:chris-lea/node.js'
    sudo "apt-get update"
    sudo "apt-get -y install nodejs"
  }
end

dep "nodejs path setup" do
  met? { shell('echo $PATH')[/\/node_modules\/bin/] }

  meet {
    shell "echo 'export PATH=$PATH:~/node_modules/bin' >> ~/.bashrc"
    log 'Path has been modified. You will need to re login for the ~/node_modules/bin have effect.'
  }
end
