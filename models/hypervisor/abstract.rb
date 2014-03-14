module Infradash
  module Hypervisor
    class Abstract

      def self.connect(address)
        @conn = new(address)
        yield @conn
        @conn.close
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
