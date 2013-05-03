;;; visual config
; use term colors
;   (set-background-color "black")
;   (set-foreground-color "orange")
(set-face-foreground 'minibuffer-prompt "light blue")
(set-frame-font "-*-dejavu sans mono-*-*-*-*-12-*-*-*-*-*-*-*")
(menu-bar-mode 0)

;;; kill those annoying backup files
(setq make-backup-files nil)

;;; death to tabs
(setq-default c-basic-indent 2)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;;; Fix junk characters in shell mode
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;;; set editing preferences
(setq column-number-mode 1)
(global-visual-line-mode t)

;;; fix for backspace while running emacs in screen generating C-h
(define-key key-translation-map [?\C-h] [?\C-?])

;;; make a more comfortable h-split binding
(global-set-key "\C-x9" 'split-window-horizontally)

;;; configure auto-insert templates
(add-hook 'find-file-hooks 'auto-insert)
      (load-library "autoinsert")
      (setq auto-insert-directory "~/.emacs-insert-templates/")
      (setq auto-insert-alist
            (append '(
	          (python-mode      .  "python.inc")
	          (sh-mode          .  "sh.inc")
	          (c-mode           .  "c.inc")
	          (c++-mode         .  "c++.inc")
            )
            auto-insert-alist))

;;; duplicate line
(defun duplicate-line-or-region (&optional n)
  "Duplicate current line, or region if active.
With argument N, make N copies.
With negative N, comment out original line and use the absolute value."
  (interactive "*p")
  (let ((use-region (use-region-p)))
    (save-excursion
      (let ((text (if use-region        ;Get region if active, otherwise line
                      (buffer-substring (region-beginning) (region-end))
                    (prog1 (thing-at-point 'line)
                      (end-of-line)
                      (if (< 0 (forward-line 1)) ;Go to beginning of next line, or make a new one
                          (newline))))))
        (dotimes (i (abs (or n 1)))     ;Insert N times, or once if not specified
          (insert text))))
    (if use-region nil                  ;Only if we're working with a line (not a region)
      (let ((pos (- (point) (line-beginning-position)))) ;Save column
        (if (> 0 n)                             ;Comment out original with negative arg
            (comment-region (line-beginning-position) (line-end-position)))
        (forward-line 1)
        (forward-char pos)))))

(global-set-key [?\C-c ?\C-d] 'duplicate-line-or-region)
