module Day16
  module Helpers
    Watch = Struct.new(:registry) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== META ====================================

      def operation_names
        @operation_names ||= [ :addi, :addr, :bani, :banr, :bori, :borr,
                               :eqir, :eqri, :eqrr, :gtir, :gtri, :gtrr,
                               :muli, :mulr, :seti, :setr ].freeze
      end


      #========== OPERATIONS ==============================

      # addi (add immediate) stores into register C the result of
      # adding register A and value B.
      #
      def addi(rA, vB, rC)
        registry[rC] = registry[rA] + vB
      end

      # addr (add register) stores into register C the result of
      # adding register A and register B.
      #
      def addr(rA, rB, rC)
        registry[rC] = registry[rA] + registry[rB]
      end

      # bani (bitwise AND immediate) stores into register C the result of
      # the bitwise AND of register A and value B.
      #
      def bani(rA, vB, rC)
        registry[rC] = registry[rA] & vB
      end

      # banr (bitwise AND register) stores into register C the result of
      # the bitwise AND of register A and register B.
      #
      def banr(rA, rB, rC)
        registry[rC] = registry[rA] & registry[rB]
      end

      # bori (bitwise OR immediate) stores into register C the result of
      # the bitwise OR of register A and value B.
      #
      def bori(rA, vB, rC)
        registry[rC] = registry[rA] | vB
      end

      # borr (bitwise OR register) stores into register C the result of
      # the bitwise OR of register A and register B.
      #
      def borr(rA, rB, rC)
        registry[rC] = registry[rA] | registry[rB]
      end

      # eqir (equal immediate/register) sets register C to 1
      # if value A is equal to register B. Otherwise, register C is set to 0.
      #
      def eqir(vA, rB, rC)
        registry[rC] = (vA == registry[rB]) ? 1 : 0
      end

      # eqri (equal register/immediate) sets register C to 1
      # if register A is equal to value B. Otherwise, register C is set to 0.
      #
      def eqri(rA, vB, rC)
        registry[rC] = (registry[rA] == vB) ? 1 : 0
      end

      # eqrr (equal register/register) sets register C to 1
      # if register A is equal to register B. Otherwise, register C is set to 0.
      #
      def eqrr(rA, rB, rC)
        registry[rC] = (registry[rA] == registry[rB]) ? 1 : 0
      end

      # gtir (greater-than immediate/register) sets register C to 1
      # if value A is greater than register B. Otherwise, register C is set to 0.
      #
      def gtir(vA, rB, rC)
        registry[rC] = (vA > registry[rB]) ? 1 : 0
      end

      # gtri (greater-than register/immediate) sets register C to 1
      # if register A is greater than value B. Otherwise, register C is set to 0.
      #
      def gtri(rA, vB, rC)
        registry[rC] = (registry[rA] > vB) ? 1 : 0
      end

      # gtrr (greater-than register/register) sets register C to 1
      # if register A is greater than register B. Otherwise, register C is set to 0.
      #
      def gtrr(rA, rB, rC)
        registry[rC] = (registry[rA] > registry[rB]) ? 1 : 0
      end

      # muli (multiply immediate) stores into register C the result of
      # multiplying register A and value B.
      #
      def muli(rA, vB, rC)
        registry[rC] = registry[rA] * vB
      end

      # mulr (multiply register) stores into register C the result of
      # multiplying register A and register B.
      #
      def mulr(rA, rB, rC)
        registry[rC] = registry[rA] * registry[rB]
      end

      # seti (set immediate) stores value A into register C.
      # (Input B is ignored.)
      #
      def seti(vA, _B, rC)
        registry[rC] = vA
      end

      # setr (set register) copies the contents of register A into register C.
      # (Input B is ignored.)
      #
      def setr(rA, _B, rC)
        registry[rC] = registry[rA]
      end

    end
  end
end
