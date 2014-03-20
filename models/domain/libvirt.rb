require 'libvirt'

module Infradash
  module Domain
    class Libvirt < Abstract

      def initialize(domain)
        @domain = domain
        super()
      end

      def id
        begin
          @domain.id
        rescue ::Libvirt::RetrieveError => e
          nil
        end
      end

      def name
        @domain.name.encode("UTF-8")
      end

      def state
        case @domain.state[0]
        when ::Libvirt::Domain::NOSTATE
          "no state"
        when ::Libvirt::Domain::RUNNING
          "running"
        when ::Libvirt::Domain::BLOCKED
          "blocked"
        when ::Libvirt::Domain::PAUSED
          "paused"
        when ::Libvirt::Domain::SHUTDOWN
          "shutting down"
        when ::Libvirt::Domain::SHUTOFF
          "shut off"
        when ::Libvirt::Domain::CRASHED
          "crashed"
        when ::Libvirt::Domain::PMSUSPENDED
          "suspended"
        else
          "unknown"
        end
      end

      def cpu
        @domain.info.nr_virt_cpu
      end

      def memory
        @domain.info.max_mem
      end
    end
  end
end
