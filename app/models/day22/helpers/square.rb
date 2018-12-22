module Day22
  module Helpers
    Square = Struct.new(:x, :y, :depth, :location_type, :geologic_index) do

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      # constants
      GEOLOGIC_TYPES ||= [:rocky, :narrow, :wet].freeze
      LOCATION_TYPES ||= [:mouth, :target, :normal].freeze


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== ACTIONS =================================

      def print
        case location_type
        when :mouth
          'M'
        when :target
          'T'
        else
          case geologic_type
          when :rocky then '.'
          when :narrow then '|'
          else '='
          end
        end
      end


      #========== MEMOS ===================================

      def erosion_level
        @erosion_level ||= begin
          (geologic_index + depth) % 20183
        end
      end

      def geologic_type
        @geologic_type ||= begin
          case erosion_level % 3
          when 0 then :rocky
          when 1 then :wet
          when 2 then :narrow
          end
        end
      end

      def risk_level
        @risk_level ||= begin
          case geologic_type
          when :rocky   then 0
          when :wet     then 1
          when :narrow  then 2
          end
        end
      end


      #========== HELPERS =================================

      GEOLOGIC_TYPES.each do |t|
        define_method "#{ t }?" do
          geologic_type == t
        end
      end

      LOCATION_TYPES.each do |t|
        define_method "#{ t }?" do
          location_type == t
        end

        define_method "#{ t }!" do
          self[:location_type] = t
        end
      end

    end
  end
end
