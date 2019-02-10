;;(local intro-img (love.graphics.newImage "assets/intro-225.jpg"))
(local intro-font (love.graphics.newFont "assets/MajorMonoDisplay-Regular.ttf" 32))
(local small-font (love.graphics.newFont "assets/MajorMonoDisplay-Regular.ttf" 12))

(local messages [(love.filesystem.read "text/splash")] )

(var counter 0)

(var tap false)

{:draw (fn draw [message]
         (love.graphics.setFont intro-font)
;;         (love.graphics.draw intro-img)
         (love.graphics.print "Sideways" 32 16)
         (love.graphics.setFont small-font)
         (when tap
             (do
               (love.graphics.setFont small-font)
               (love.graphics.print "message" 32 62)))
         (if message
             ;; let this code be re-used by pause/help mode
             (love.graphics.print message 16 62)
             (for [i 1 (# messages)]
               (when (> counter (* i 2))
                 (love.graphics.print (. messages i) 8 (+ (* 18 i) 110))))))
 :update (fn update [dt set-mode]
           (set counter (+ counter dt))
           (when (> counter 16)
             (love.graphics.print "message")))
 :keypressed (fn keypressed [key set-mode]
               (if (= key "space")
                   (set-mode :play)
                   (set tap true)
                   ))}
