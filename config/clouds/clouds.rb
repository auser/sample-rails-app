# Basic poolparty template
pool :cb do
  # plugin_directory "#{File.dirname(__FILE__)}/plugins"
  
  ami "ami-1cd73375"
  
  cloud :app do
    set_master_ip_to "75.101.162.232"
    expand_when "cpu > 3.80"
    contract_when "cpu < 0.50"
    
    rails
    image_science
    git
        
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