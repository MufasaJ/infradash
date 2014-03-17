module Infradash
  module Hypervisor
    class Abstract

      def self.connect(address)
        begin
          conn = new(address)
          yield conn
        ensure
          conn.close
        end
      end

      def close
      end

      def query
      end

      def get(name)
      end
    end
  end
end
