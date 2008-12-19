module PoolParty
  class Plugins

    plugin :monit do
      
      def enable
        install
      end
            
      def install
        has_package(:name => "monit")
      end
      
      def watch(name)
        
      end
      
    end
    
  end
end