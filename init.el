;################################
; dot.emacs.el For BLThunder1991
;################################

;================================
; CHARACTER AND FONT SETTING
;================================
;character setting
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setq file-name-coding-system 'utf-8)

;Font Setting
(when (>= emacs-major-version 23)
 (set-face-attribute 'default nil
                     :family "monaco"
                     :height 140)
 )
;Charcter color set
(global-font-lock-mode t)

;Area color set
(setq transient-mark-mode t)

;================================
; WINDOW SETTING
;================================
;start messege not display
(setq inhibit-startup-message t)


; Window Setting
(setq initial-frame-alist
      (append (list
	       '(alpha 95)
               )
              initial-frame-alist))
(setq default-frame-alist initial-frame-alist)

;Frame title
(setq frame-title-format
      (concat "%b - emacs@" system-name))

;display clock
(display-time)

;; 分割ウィンドウのサイズ調整
;; http://d.hatena.ne.jp/mooz/20100119/p1
;; 関数 window-resizer を定義
(defun window-resizer ()
  "Control window size and position."
  (interactive)
  (let ((window-obj (selected-window))
        (current-width (window-width))
        (current-height (window-height))
        (dx (if (= (nth 0 (window-edges)) 0) 1
              -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1
              -1))
        c)
    (catch 'end-flag
      (while t
        (message "size[%dx%d]"
                 (window-width) (window-height))
        (setq c (read-char))
        (cond ((= c ?l)
               (enlarge-window-horizontally dx))
              ((= c ?h)
               (shrink-window-horizontally dx))
              ((= c ?j)
               (enlarge-window dy))
              ((= c ?k)
               (shrink-window dy))
              ;; otherwise
              (t
               (message "Quit")
               (throw 'end-flag t)))))))

;; Ctrl-c R でウィンドウリサイズモード・hjklでリサイズ
(global-set-key "\C-cR" 'window-resizer)

;================================
; EDITOR SETTING
;================================
;Drag and Drop
(define-key global-map [ns-drag-file] 'ns-find-file)
;Line
(setq-default line-spacing 2)
; Highlight ()
(show-paren-mode 1)
;Scroll Step
(setq scroll-step 1)
;Indent Size
(setq indent-tabs-mode nil )
;Marking
(setq transient-mark-mode t)
;Editing line Hilight
(global-hl-line-mode 1)
;Erase beep sound
(setq visible-bell t)
;Recent File List
(recentf-mode 1)
;yes or no -> y or n
(defalias 'yes-or-no-p 'y-or-n-p)
; do not use dialog box
(setq use-dialog-box nil)
; C-k last \n delete
; linum-mode
(linum-mode 1)
(setq linum-format "%4d ")
; which-function-mode
(which-function-mode t)

;Key bind
;Undo
(global-set-key "\C-z" 'undo)
;delete-backword
(global-set-key "\C-h" 'delete-backword-char)
(global-set-key (kbd "M-h") 'delete-backword-word)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "\C-cr") 'replace-string)


;================================
; EXTENTION SETTING
;================================

;Load path
(add-to-list 'load-path(expand-file-name "~/.emacs.d/site-lisp/" ))

;;Server mode
(server-mode t)

;Auto Complete
;Color Theme

;YaTeX
(add-to-list 'load-path "~/.emacs.d/yatex/")
(setq auto-mode-alist  (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
;(setq load-path (cons "~/.emacs.d/yatex" load-path))
(setq tex-command "/Applications/TeXShop.app/Contents/MacOS/TeXShop"
      Bibtex-command "/Applications/UpTex.app/teTex/bin/jbibtex"
      makeindex-command "/Applications/UpTex.app/teTex/bin/makeindex"
      dvi2-command "open -a Preview"
      YaTeX-kanji-code nil ;
      )
(defvaralias 'last-command-char 'last-command-event)
(setq dviprint-command-format "dvipdfmx %s")
;; ;; previewにtexshop
;; (setq tex-command "/Applications/UpTex.app/teTex/bin/dvipdfmx"
;;       dvi2-command "open -a TeXShop")

;; ;anithing.el
;; (require 'anything)
;; (defvar org-directory "")
;; (require 'anything-startup)

;flymake
;; (require 'flymake)
;; (setq flymake-gui-warnings-enabled nil)
;; (add-hook 'find-file-hook 'flymake-find-file-hook)
;; (add-to-list 'flymake-err-line-patterns
;;          ;; g++ 4.7
;;          '("\\([^:]+\\):\\([0-9]+\\):\\(\\([0-9]+\\):\\)? \\(\\(error\\|warning\\): \\(.+\\)\\)" 1 2 4 5))

;; ; C++モードでは flymakeを有効にする
;; (add-hook 'c++-mode-hook
;;                   '(lambda ()
;;                          (flymake-mode t)))
;; (add-hook 'c-mode-hook
;;                   '(lambda ()
;;                          (flymake-mode t)))
;; ;; M-p/M-n で警告/エラー行の移動
;; (global-set-key "\M-p" 'flymake-goto-prev-error)
;; (global-set-key "\M-n" 'flymake-goto-next-error)

;; ;; 警告エラー行の表示
;; (global-set-key "\C-cd" 'flymake-display-err-menu-for-current-line)

;; (set-face-background 'flymake-warnline "dark orange")
;; (set-face-foreground 'flymake-warnline "black")
;; (set-face-background 'flymake-errline "orange red")
;; (set-face-foreground 'flymake-errline "black")

;; (defun flymake-simple-generic-init (cmd &optional opts)
;;   (let* ((temp-file  (flymake-init-create-temp-buffer-copy
;;                       'flymake-create-temp-inplace))
;;          (local-file (file-relative-name
;;                       temp-file
;;                       (file-name-directory buffer-file-name))))
;;     (list cmd (append opts (list local-file)))))

;; ;; Makefile が無くてもC/C++のチェック
;; (defun flymake-simple-make-or-generic-init (cmd &optional opts)
;;   (if (file-exists-p "Makefile")
;;       (flymake-simple-make-init)
;;     (flymake-simple-generic-init cmd opts)))

;; (defun flymake-c-init ()
;;   (flymake-simple-make-or-generic-init
;;    "gcc" '("-Wall" "-Wextra" "-pedantic" "-fsyntax-only")))

;; (defun flymake-cc-init ()
;;   (flymake-simple-make-or-generic-init
;;    "g++" '("-Wall" "-Wextra" "-pedantic" "-fsyntax-only")))

;; (push '("\\.[cC]\\'" flymake-c-init) flymake-allowed-file-name-masks)
;; (push '("\\.\\(?:cc\|cpp\|CC\|CPP\\)\\'" flymake-cc-init) flymake-allowed-file-name-masks)
;; ; 日本語ロケールではerrorとwarningが区別できないのでmake実行時は英語ロケールで
;; (defun flymake-get-make-cmdline (source base-dir)
;;   (list "make"
;;         (list "-s"
;;               "-C"
;;               base-dir
;;               (concat "CHK_SOURCES=" source)
;;               "SYNTAX_CHECK_MODE=1"
;;               "LANG=C"
;;               "check-syntax")))

(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))
;; (autoload 'dummy-h-mode "dummy-h-mode" "Dummy H mode" t)

;; ;; 文法チェックの頻度の設定
;; (setq flymake-no-changes-timeout 1)
;; ;; 改行時に文法チェックを行うかどうかの設定
;; (setq flymake-start-syntax-check-on-newline nil)

;;Auto-insert
(require 'autoinsert)
;; テンプレート格納用ディレクトリ
(setq auto-insert-directory "~/.emacs.d/template/")
;; ファイル拡張子とテンプレートの対応
(setq auto-insert-alist
(append '(
("\\.tex" . ["LaTeXTemp.tex"])
) auto-insert-alist))
(add-hook 'find-file-hooks 'auto-insert)


;================================
; back UP SETTING
;================================
(setq make-backup-files t)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/backup"))
	    backup-directory-alist))

; auto-install.el
;; (add-to-list 'load-path "~/.emacs.d/auto-install")
;; (require 'auto-install)
;; (setq auto-install-directory "~/.emacs.d/site-lisp/")
;; (auto-install-update-emacswiki-package-name t)
;; (auto-install-compatibility-setup)

;; タイトルバーにファイルのフルパス表示
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))
;; 行番号表示
(global-linum-mode t)
(set-face-attribute 'linum nil
                    :foreground "#0000ff"
                    :height 0.9)

;; 行番号フォーマット
;;(setq linum-format "%4d")


;;括弧の範囲内強調
(show-paren-mode t)
(setq show-paren-delay 0)
(setq show-paren-style 'expression)

;; 括弧の範囲色
(set-face-background 'show-paren-match-face "#0000ff")
;; 最近使ったファイルをメニューに表示
(recentf-mode t)

;; 最近使ったファイルの表示数
(setq recentf-max-menu-items 10)
