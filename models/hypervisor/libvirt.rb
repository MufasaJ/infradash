require 'libvirt'

module Infradash
  module Hypervisor
    class Libvirt < Abstract

      attr_reader :domains

      def initialize(address)
        @hypervisor = address
        @conn = ::Libvirt::open(@hypervisor)
      end


      def close
        @conn.close
      end

      def query
        active = @conn.list_domains.map do |id|
          Infradash::Domain::Libvirt.new(@conn.lookup_domain_by_id(id))
        end

        inactive = @conn.list_defined_domains.map do |name|
          Infradash::Domain::Libvirt.new(@conn.lookup_domain_by_name(name))
        end

        @domains = active.concat(inactive)
      end

      def get(name)
        begin
          domain = @conn.lookup_domain_by_name(name)
          Infradash::Domain::Libvirt.new(domain)
        rescue ::Libvirt::RetrieveError => e
          nil
        end
      end

    end
  end
end
