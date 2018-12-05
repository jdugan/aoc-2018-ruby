class Day02 < AbstractDay

  #--------------------------------------------------------
  # Public Methods
  #--------------------------------------------------------

  def p1
    c2 = 0
    c3 = 0

    box_ids.each do |id|
      found2 = false
      found3 = false
      flen   = id.size
      chars  = id.split('')
      chars.each do |c|
        plen   = id.gsub(c, '').size
        diff   = flen - plen
        case flen - plen
        when 2
          found2 = true
        when 3
          found3 = true
        end
        if found2 && found3
          break
        end
      end
      c2 = c2 + 1  if found2
      c3 = c3 + 1  if found3
    end

    c2 * c3
  end


  def p2
    answer = nil
    ids    = box_ids.map { |id| id }

    while answer.nil? && (current = ids.shift) && ids.present?
      ids.each do |possible|
        if set?(current, possible)
          answer = common(current, possible)
          break
        end
      end
    end

    answer
  end


  #--------------------------------------------------------
  # Private Methods
  #--------------------------------------------------------
  private

  def box_ids
    @box_ids ||= data.map(&:strip)
  end

  def common(a, b)
    di = nil
    aa = a.split('')
    ba = b.split('')
    aa.each_with_index do |c, i|
      if aa[i] != ba[i]
        di = i
        break
      end
    end
    "#{ a.slice(0, di) }#{ a.slice(di + 1, aa.size) }"
  end

  def set?(a, b)
    count = 0
    aa    = a.split('')
    ba    = b.split('')
    aa.each_with_index do |c, i|
      unless aa[i] == ba[i]
        count = count + 1
      end
      if count > 1
        break
      end
    end
    count == 1
  end

end
