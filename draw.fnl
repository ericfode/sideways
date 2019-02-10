(local hud (require "hud"))

(local small-font (love.graphics.newFont "assets/MajorMonoDisplay-Regular.ttf" 12))



(fn draw-laser [laser]
  (love.graphics.setColor 1 0 0)
  (each [_ segment (ipairs laser)]
    (love.graphics.line (unpack segment))))

(fn draw-npc [name state]
  (love.graphics.rectangle "line" state.x state.y 10 10))

(fn draw-npcs [state]
  (each [name st (pairs state.npcs)]
    (draw-npc name st)))

{:draw (fn draw [camera world state]
         (: camera :attach)
         (love.graphics.push)
         (love.graphics.setColor 1 1 1)
         (love.graphics.circle "line"   state.player.x state.player.y 10)
         (love.graphics.pop)
         (draw-npcs state)
         (: camera :detach)
        ; (hud.draw state)
         )
 ;; these layer draw functions get called by the tiled library at the right time
 ;; so other layers can obscure them when necessary
 }
