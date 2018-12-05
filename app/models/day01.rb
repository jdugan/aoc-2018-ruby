class Day01 < AbstractDay

  #--------------------------------------------------------
  # Public Methods
  #--------------------------------------------------------

  def p1
    frequency_changes.sum
  end

  def p2
    freq = 0
    fmap = { 0 => true }
    dupl = nil

    while dupl.nil? do
      frequency_changes.each do |fc|
        nf = freq + fc
        if fmap.has_key?(nf)
          dupl = nf
          break
        else
          fmap[nf] = true
          freq     = nf
        end
      end
    end

    dupl
  end

  #--------------------------------------------------------
  # Private Methods
  #--------------------------------------------------------
  private

  def frequency_changes
    @frequency_changes ||= data.map(&:to_i)
  end

end
