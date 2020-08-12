;; * Set search engine
(define-configuration browser
  ((search-engines (list
		    (make-instance 'search-engine
				   :shortcut "default"
				   :search-url "https://www.google.com/search?q=~a"
				   :fallback-url "https://google.com")))))

;; * Simulation keys
(in-package :nyxt/vi-mode)
(in-package :nyxt/web-mode)

(defun simulate-key (key)
  "Run xdotool key"
  (ignore-errors (uiop:run-program
		  (list "xdotool" "key" key))))

(defun simulate-key-no-modifiers (key)
  "Run xdotool key and temporarily release any modifiers held down"
  (ignore-errors (uiop:run-program
		  (list "xdotool" "key" "--clearmodifiers" key))))

(defun simulate-ret ()
  "Simulate key"
  (simulate-key-no-modifiers "Return"))

(defun simulate-backspace ()
  "Simulate key"
  (simulate-key-no-modifiers "BackSpace"))

(defun simulate-del ()
  "Simulate key"
  (simulate-key-no-modifiers "Delete"))

(defun simulate-esc ()
  "Simulate key"
  (simulate-key-no-modifiers "Escape"))

(defun simulate-up ()
  "Simulate key"
  (simulate-key-no-modifiers "Up"))

(defun simulate-down ()
  "Simulate key"
  (simulate-key-no-modifiers "Down"))

;; (defun simulate-tab ()
;;   "Simulate key"
;;   (simulate-key-no-modifiers "Tab"))

;; * Main binds
(define-mode my-mode ()
  "My mode"
  ((keymap-scheme
    :initform
    (define-scheme "my"
      scheme:vi-insert
      (list
       "C-a" 'simulate-ret

       "C-e" 'simulate-esc

       "C-f" 'simulate-backspace
       "C-l" 'simulate-del

       "C-u" 'scroll-page-up
       "C-w" 'scroll-page-down

       "C-s" 'search-buffer

       "C-y" 'copy
       "C-k" 'paste

       "C-p" 'simulate-up
       "C-n" 'simulate-down

       ;; "C-t" 'simulate-tab
       )
      scheme:vi-normal
      (list
       "C-a" 'simulate-ret

       "C-f" 'simulate-backspace
       "C-l" 'simulate-del

       ;; Just to unbound it
       "C-g" 'vi-normal-mode

       "C-k" 'paste
       "C-y" 'copy


       ;; Movement
       "h" 'scroll-left
       "n" 'scroll-down
       "p" 'scroll-up
       "l" 'scroll-right
       "C-p" 'simulate-up
       "C-n" 'simulate-down

       ;; Fast movement
       "C-u" 'scroll-page-up
       "C-w" 'scroll-page-down
       "pageup" 'scroll-page-up
       "pagedown" 'scroll-page-down

       ;; History
       "H" 'history-backwards
       "L" 'history-forwards

       "U" 'history-all-query
       "M-h" 'history-backwards-query
       "M-l" 'history-forwards-query
       "M-L" 'history-forwards-all-query

       ;; Link hint
       "f" 'follow-hint
       "F" 'follow-hint-new-buffer-focus
       "(" 'follow-hint-new-buffer

       ;; Search
       "C-s" 'search-buffer
       ;; "?" 'remove-search-hints

       ;; Reload
       "r" 'reload-current-buffer
       "R" 'reload-buffer

       "button9" 'history-forwards
       "button8" 'history-backwards
       "C-v" 'paste
       "+" 'zoom-in-page
       "hyphen" 'zoom-out-page
       "0" 'unzoom-page
       "z i" 'zoom-in-page
       "z o" 'zoom-out-page
       "z z" 'unzoom-page
       "g h" 'jump-to-heading

       "m f" 'bookmark-hint
       "G" 'scroll-to-bottom
       "g g" 'scroll-to-top

       "k" 'delete-current-buffer
       "K" 'delete-buffer

       "tab" 'switch-buffer

       "P" 'switch-buffer-previous
       "N" 'switch-buffer-next

       "y" 'copy-url
       "Y" 'copy-title
       )))))

;; * Auto-enable modes
(define-configuration buffer
  ((default-modes (append '(
			    ;; noscript-mode
			    vi-normal-mode
			    my-mode
			    ) %slot-default))))

;; * Minibuffer settings
(in-package :nyxt/minibuffer-mode)

;; Custom commands
(define-command my/minibuffer-scroll-down (&optional (minibuffer (current-minibuffer)))
  "Scroll up in minibuffer"
  (select-next minibuffer)
  (select-next minibuffer)
  (select-next minibuffer)
  (select-next minibuffer)
  (select-next minibuffer))

(define-command my/minibuffer-scroll-up (&optional (minibuffer (current-minibuffer)))
  "Scroll down in minibuffer"
  (select-previous minibuffer)
  (select-previous minibuffer)
  (select-previous minibuffer)
  (select-previous minibuffer)
  (select-previous minibuffer))

;; ** Mode override
(define-mode minibuffer-mode ()
  "Mode for the minibuffer."
  ((keymap-scheme
    :initform
    (define-scheme "minibuffer"
      scheme:cua
      (list
       "C-f" 'delete-backwards
       "C-l" 'delete-forwards

       "C-t" 'insert-suggestion

       "C-s" 'minibuffer-history

       "C-k" 'minibuffer-paste

       "C-u" 'my/minibuffer-scroll-up
       "C-w" 'my/minibuffer-scroll-down

       "C-y" 'copy-suggestion

       "hyphen" 'self-insert-minibuffer
       "space" 'self-insert-minibuffer
       "M-f" 'cursor-forwards-word
       "C-right" 'cursor-forwards-word
       "C-b" 'cursor-backwards
       "M-b" 'cursor-backwards-word
       "C-left" 'cursor-backwards-word
       "M-d" 'delete-forwards-word
       "M-backspace" 'delete-backwards-word
       "right" 'cursor-forwards
       "left" 'cursor-backwards
       "C-d" 'delete-forwards
       "delete" 'delete-forwards
       "backspace" 'delete-backwards
       ;; "C-a" 'cursor-beginning
       "home" 'cursor-beginning
       "C-e" 'cursor-end
       "end" 'cursor-end

       "C-a" 'return-input
       "return" 'return-input
       "RETURN" 'return-input
       "ret" 'return-input
       "RET" 'return-input
       "enter" 'return-input
       "Enter" 'return-input
       "ENTER" 'return-input

       "C-return" 'return-immediate
       "C-g" 'cancel-input
       "escape" 'cancel-input
       "C-n" 'select-next
       "C-p" 'select-previous
       )))))
