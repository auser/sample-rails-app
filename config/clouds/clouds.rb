# Basic poolparty template
pool :cb do
  # plugin_directory "#{File.dirname(__FILE__)}/plugins"
  
  ami "ami-1cd73375"
  
  cloud :app do
    set_master_ip_to "75.101.162.232"
    expand_when "cpu > 3.80"
    contract_when "cpu < 0.50"
    
    rails
    mysql do
      install
      has_database(:name => "demo_production", :user => "demo", :password => "demo")
    end
    image_science
    git
    
    has_rsyncmirror(:name => "/var/www/demo/current")
    
    apache do
      installed_as_worker
      has_passengersite do
        name "demo"
        docroot "/var/www/demo/current"
        port "8080"
      end
      
    end
  end
end