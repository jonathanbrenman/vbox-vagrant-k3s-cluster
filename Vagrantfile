servers = [
  { :hostname => "master01", :ip => "192.168.33.10", :memory => "2048", :disks => "15G" },
  { :hostname => "master02", :ip => "192.168.33.11", :memory => "2048", :disks => "15G" },
  { :hostname => "master03", :ip => "192.168.33.12", :memory => "2048", :disks => "15G" },
  { :hostname => "node01", :ip => "192.168.33.13", :memory => "2048", :disks => "15G" },
  { :hostname => "node02", :ip => "192.168.33.14", :memory => "2048", :disks => "15G" },
  { :hostname => "node03", :ip => "192.168.33.15", :memory => "2048", :disks => "15G" },
]

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.ssh.forward_agent = true
  
  servers.each do |conf|
    config.vm.synced_folder ".", "/vagrant", type: "rsync"
   
    config.vm.provision "shell" do |s|
      ssh_pub_key = File.readlines("/home/jonathan/.ssh/id_rsa.pub").first.strip
      s.inline = <<-SHELL
        echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
        echo vagrant ALL=NOPASSWD:ALL > /etc/sudoers.d/vagrant
        usermod -aG root vagrant
      SHELL
    end
    
    config.vm.define conf[:hostname] do |node|
      node.vm.hostname = conf[:hostname]
      config.vm.network "private_network", ip: conf[:ip]
      node.vm.provider :virtualbox do |v|
        v.name = conf[:hostname]
        v.memory = conf[:memory]
        v.cpus = 2
      end
    end
  end
end