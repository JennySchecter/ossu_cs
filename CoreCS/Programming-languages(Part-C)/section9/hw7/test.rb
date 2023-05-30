def intersectWithSegmentAsLineResult seg
    sx1,sy1,sx2,sy2 = seg.x1,seg.y1,seg.x2,seg.y2
    if sx1==sx2
        aYstart,aYend,bYstart,bYend = if y1 < sy1 then [y1,y2,sy1,sy2] else [sy1,sy2,y1,y2] end
        if real_close(aYend,bYstart)
          1
        elsif aYend > bYstart
        then 2
        elsif aYend > bYend
        then 3
        else 4
        end
    else
      if x1 < sx1
      then aXstart,aXend,aYstart,aYend = x1,y1,x2,y2
           bXstart,bXend,bYstart,bYend = sx1,sy1,sx2,sy2
      else 
           aXstart,aXend,aYstart,aYend = sx1,sy1,sx2,sy2
           bXstart,bXend,bYstart,bYend = x1,y1,x2,y2
      end
      if aXend==bXstart
      then 5
      elsif aXend < bXstart
      then 6
      elsif aXend > bXend
      then 7
      else 8
      end
    end
end

