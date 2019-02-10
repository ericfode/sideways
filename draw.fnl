(local hud (require "hud"))

(local small-font (love.graphics.newFont "assets/MajorMonoDisplay-Regular.ttf" 12))



(fn draw-laser [laser]
  (love.graphics.setColor 1 0 0)
  (each [_ segment (ipairs laser)]
    (love.graphics.line (unpack segment))))

(fn draw-npc [name state]
  (love.graphics.circle "line" state.x state.y state.r))

(fn draw-npcs [state]
  (each [name st (pairs state.npcs)]
    (draw-npc name st)))

(fn draw-player [state]
  (love.graphics.push)
  ;; drawing non-map stuff needs to apply our own translate
  (love.graphics.setColor 1 1 1)
  (love.graphics.circle "fill"   state.player.x state.player.y state.player.r)
  (love.graphics.pop))

{:draw (fn draw [camera world state]
         (: camera :attach)
         (draw-player state)
        (draw-npcs state)
         (: camera :detach)
        ; (hud.draw state)
         )
 ;; these layer draw functions get called by the tiled library at the right time
 ;; so other layers can obscure them when necessary
 }
