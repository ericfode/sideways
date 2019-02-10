(local draw (require "draw"))
(local hud (require "hud"))
(local bump (require "bump"))
(local camera (require :hump/camera))

(local world (bump.newWorld))

(local state {:npcs {:george {:x 96 :y 120}}
              :messages ["test message"]
              :player {:x 100 :y 100}
              :tx 0
              :ty 0})

(local cam (camera.new 300 260))

(global w world)
(global c cam)
(fn circle-of-npcs []
  (let [settings
        (fun.totable
         (fun.map
          (lambda [v]
            {:r 100.0
             :name v
             :v (* math.pi v 0.2)})
          (fun.range 10)))
        center-x 100
        center-y 100
        ]
    (each [name s (ipairs settings)]
      (let [{:r r :v v :name name} s]
        (tset state.npcs name
              {:x (+ center-x (* r (math.cos v)))
               :y (+ center-y (* r (math.sin v)))})))))

(circle-of-npcs)

(local keymap {"a" (fn [] (set state.player.x (- state.player.x 1)))
               "s" (fn [] (set state.player.y (+ state.player.y 1)))
               "w" (fn [] (set state.player.y (- state.player.y 1)))
               "d" (fn [] (set state.player.x (+ state.player.x 1)))})

(love.keyboard.setKeyRepeat true)

(global s state)
{:draw (partial draw.draw cam world state)

 :update (fn update [dt set-mode]

           (each [key update (pairs keymap)]
             (when (love.keyboard.isDown key)
               (update)))
           (: cam :lockWindow state.player.x state.player.y 0 400 0 300 )
           )
 :keypressed (fn keypressed [key]
               (set state.lastKey key))

 }
