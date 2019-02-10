(local font (love.graphics.newFont "assets/MajorMonoDisplay-Regular.ttf" 16))

{:draw (fn draw [state]
         (love.graphics.setFont font)
         (love.graphics.setColor 1 1 1)
         (for [i 1 5] ; show the most recent 5 messages
           (love.graphics.print (or (. state.messages i) "")
                                10 (- 213 (* 18 i)))))}
