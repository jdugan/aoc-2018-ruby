module Day21
  module Helpers
    class Watch < Tableless

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      # mixins
      include WatchOperations
      include WatchPointers

    end
  end
end
