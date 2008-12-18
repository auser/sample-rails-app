# Basic poolparty template
pool :cb do
  # plugin_directory "#{File.dirname(__FILE__)}/plugins"
  
  ami "ami-1cd73375"
  
  cloud :app do
    set_master_ip_to "75.101.162.232"
    mount_ebs_volume_at "vol-b38763da", "/data"
    expand_when "cpu > 2.80"
    contract_when "cpu < 0.50"
    
    has_gempackage(:name => "rails", :version => "2.1.2")
    image_science
        
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