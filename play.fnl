(local draw (require "draw"))
(local hud (require "hud"))
(local bump (require "bump"))
(local camera (require :hump/camera))

(local world (bump.newWorld))

(local state {:npcs {:george
                     {:x 96 :y 120
                      :r 10
                      :w 20 :h 20}}
              :messages ["test message"]
              :player {:x 100
                       :r 10
                       :w 20
                       :h 20
                       :y 100}
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
               :y (+ center-y (* r (math.sin v)))
               :r 10
               :w 20
               :h 20})))))

(fn add-entity [world entity]
  (: world :add entity entity.x entity.y entity.w entity.h))

(fn init-physics [world state]
  (fun.each (partial add-entity world) state.npcs)
  (add-entity world state.player))

(fn init []
  (circle-of-npcs)
  (init-physics world state))

(init)
(local keymap {"a" (fn []
                     (set state.player.goal-x (- state.player.x 1))
                     (set state.player.goal-y state.player.y))
               "s" (fn [] (set state.player.goal-y (+ state.player.y 1))
                     (set state.player.goal-x state.player.x))
               "w" (fn [] (set state.player.goal-y (- state.player.y 1))
                     (set state.player.goal-x state.player.x))
               "d" (fn [] (set state.player.goal-x (+ state.player.x 1))
                     (set state.player.goal-y state.player.y))})

(fn update-entity [world entity]
  (let  [(actualX actualY cols len)
         (: world :move entity entity.goal-x entity.goal-y)]
    (print len)
    (set entity.x actualX)
    (set entity.y actualY)
    (set entity.goal-x nil)
    (set entity.goal-y nil)
    (set state.cols (+ state.cols len))))

(fn filter-entity [entity]
  (and entity.goal-x entity.goal-y))

(fn update-physics [world state]
  (set state.cols 0)
  (let [has-goal (fun.filter filter-entity state.npcs)
        updated  (fun.each (partial update-entity world) has-goal)]

    (when (filter-entity state.player)
      (update-entity world state.player))))

(love.keyboard.setKeyRepeat true)

(global s state)
{:draw (partial draw.draw cam world state)

 :update (fn update [dt set-mode]
           (each [key update (pairs keymap)]
             (when (love.keyboard.isDown key)
               (update)))
           (update-physics world state)
           (: cam :lockWindow state.player.x state.player.y 0 400 0 300 )
           )
 :keypressed (fn keypressed [key]
               (set state.lastKey key))

 }
