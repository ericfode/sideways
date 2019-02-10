;; This module contains non-game-specific bits and mode-changing logic.
(local repl (require "lib.stdio"))
(local canvas (love.graphics.newCanvas 720 450))

;; (local sound (require "sound"))

(var scale 2)
(var mode (require :intro))

(fn set-mode [mode-name ...]
  (set mode (require mode-name))
  (when mode.activate
    (mode.activate ...)))

(fn love.load []
  (: canvas :setFilter "nearest" "nearest")
  (repl.start)
 ;; (sound.play :temple)
  )

(fn love.draw []
  (love.graphics.setCanvas canvas)
  (love.graphics.clear)
  (love.graphics.setColor 1 1 1)
  (mode.draw)
  (love.graphics.setCanvas)
  (love.graphics.setColor 1 1 1)
  (love.graphics.draw canvas 0 0 0 scale scale))

(fn love.update [dt]
  (mode.update dt set-mode))

(fn love.keypressed [key]
  (if (and (= key "f11") (= scale 2))
      (let [(dw dh) (love.window.getDesktopDimensions)]
        (love.window.setMode dw dh {:fullscreen true :fullscreentype :desktop})
        (set scale (/ dh 225)))

      (= key "f11")
      (do (set scale 2) (love.window.setMode (* 720 scale) (* 450 scale)))

      (and (love.keyboard.isDown "lctrl" "rctrl" "capslock") (= key "q"))
      (love.event.quit)

      ;; (= key "f5") (set-mode :win)

      (love.keyboard.isDown "m")
  ;;    (sound.toggle)

      :else
      (mode.keypressed key set-mode)))
