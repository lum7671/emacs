;;
;; My own setting
;;

;; =============================================================================
;; 새로운 프레임 생성시 크기 설정
;; =============================================================================
(setq initial-frame-alist '((width . 120) (height . 74))) ;; 첫번째 프래임의 크기를 설정
(setq default-frame-alist '((width . 80) (height . 40))) ;; 그 다음 프래임의 크기를 설정

; (setq load-path (nconc '("/Volumes/PDS/Emacs") load-path))	;; 개인 lisp 패키지가 위치 할 load-path 설정
; (setq load-path (nconc '("~/.emacs") load-path))	;; 개인 lisp 패키지가 위치 할 load-path 설정
(add-to-list 'load-path "/Volumes/PDS/Emacs")
; (setq load-path (cons '("/Volumes/PDS/Emacs") load-path))

(setq frame-title-format
      (list (format "%s %%S: %%j " (system-name))
        '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))


(defun set-win-key-bindings ()
  "Windows Keyboard key bindings"
  (interactive)
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
  )

(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))

(global-set-key [C-f1] 'show-file-name) ; Or any other key you want

; for cscope
; (require 'xcscope)
; (setq cscope-do-not-update-database t)
; (add-hook 'java-mode-hook (function cscope:hook))
;
; (require 'hanja-util)

;; =============================================================================
;; person info
;; =============================================================================
(setq user-full-name "Nate Doohyun Jang")
(setq user-mail-address "dh.jang@gmail.com")

;; =============================================================================
;; 기본 색 지정
;; =============================================================================
(set-foreground-color "wheat")
(set-background-color "DarkSlateGray")

;; =============================================================================
;; 영역 색 지정
;; =============================================================================
(set-face-foreground 'region "white")
(set-face-background 'region "cadetblue")

;; =============================================================================
;; 한글 세벌식 최종
;; =============================================================================
;; (require 'hangul)
(set-input-method "korean-hangul3f") ;; if you want 3 beolsik final...
;; (utf-translate-cjk-mode 1)
(prefer-coding-system 'utf-8)

;;모드라인에 현재 커서의 줄과 칼럼위치 시간 표시('mode line hacking'때문에 필요 없음)
(setq column-number-mode t)             ;;컬럼수를 모드라인에 표시할 경우 에디팅 속도가 느려진다

;; function to reload .emacs 2008.01.24
;; 출처 : http://hermian.tistory.com/195
(defun reload-dotemacs ()
  "Reload .emacs"
  (interactive)
  (load-file "~/.emacs.el"))

; for emacsclient
(server-start)

;; Switch fromm *.<impl> to *.<head> and vice versa
(defun switch-cc-to-h ()
  (interactive)
  (when (string-match "^\\(.*\\)\\.\\([^.]*\\)$" buffer-file-name)
	(let ((name (match-string 1 buffer-file-name))
		  (suffix (match-string 2 buffer-file-name)))
	  (cond ((string-match suffix "c\\|cc\\|C\\|cpp")
			 (cond ((file-exists-p (concat name ".h"))
					(find-file (concat name ".h"))
					)
				   ((file-exists-p (concat name ".hh"))
					(find-file (concat name ".hh"))
					)
				   ))
			((string-match suffix "h\\|hh")
			 (cond ((file-exists-p (concat name ".cc"))
					(find-file (concat name ".cc"))
					)
				   ((file-exists-p (concat name ".C"))
					(find-file (concat name ".C"))
					)
				   ((file-exists-p (concat name ".cpp"))
					(find-file (concat name ".cpp"))
					)
				   ((file-exists-p (concat name ".c"))
					(find-file (concat name ".c"))
					)))))))

;; ================================================================================
;; auto mode alist
;; ================================================================================
;;(setq-default auto-fill-function 'do-auto-fill)		;; auto-fill모드 설정
(autoload 'x-resource-generic-mode "generic-x" nil t)	;; generic-x 모드 설정
(setq auto-mode-alist
      (nconc '(("\\.ml[iylp]?\\'" . caml-mode)
               ("\\.sml\\'" . sml-mode)
               ("\\.grm\\'" . sml-mode)
               ("\\.ML\\'" . sml-mode)
               ("\\.htm\\'" . html-helper-mode)
               ("\\.html\\'" . html-helper-mode)
               ("\\.shtml\\'" . html-helper-mode)
               ("\\.thtml\\'" . html-helper-mode)
               ("\\.css\\'" . css-mode)
               ("\\.php\\'" . php-mode)
               ("\\.php3\\'" . php-mode)
               ("\\.gnus\\'" . emacs-lisp-mode)
               ("\\.abbrev_defs\\'" . emacs-lisp-mode)
               ("\\el\\'" . emacs-lisp-mode)
               ("\\.s?html\\'" . sgml-mode)
               ("\\.sgml\\'" . sgml-mode)
               ("\\.tex\\'" . latex-mode)
               ("\\.ks$\\'" . latex-mode)
               ("\\.cl\\'" . lisp-mode)
               ("\\.cgi\\'" . cperl-mode)
               ("\\.pl\\'" . cperl-mode)
               ("\\.pm\\'" . cperl-mode)
               ("\\.py\\'" . phthon-mode)
               ("\\.c\\'" . c-mode)
               ("\\.C\\'" . c-mode)
               ("\\.cc\\'" . c++-mode)
               ("\\.cpp\\'" . c++-mode)
               ("\\.h\\'" . c++-mode)
               ("\\.hh\\'" . c++-mode)
               ("\\.idl\\'" . c++-mode)
               ("\\.txi\\'" . Texinfo-mode)
               ("\\.java\\'" . java-mode)
               ("\\.prolog\\'" . prolog-mode)
               ("\\.pro\\'" . prolog-mode)
               ("\\.txt\\'" . text-mode))
             auto-mode-alist))

;; ================================================================================
;; C mode
;; ================================================================================
(add-hook 'c-mode-common-hook
          '(lambda()
            (c-set-style "java") ;;C 코딩 스타일 정의
			(gtags-mode 1)
			(when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))
))

(add-hook 'c++-mode-common-hook
          '(lambda()
            (c-set-style "java") ;;C 코딩 스타일 정의
			(gtags-mode 1)
			(when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))
))

;; revert buffer. 파일 내용이나 디렉토리 내용이 바뀌어서 Disk의 내용을 다시 불러올때
;; g : dired 모드에서 사용
;; M-x revert-buffer RET yes RET
;; C-x C-v RET		

(defun revert-all-buffers()
  "Refreshs all open buffers from their respective files"
  (interactive)
  (let* ((list (buffer-list))
		 (buffer (car list)))
	(while buffer
	  (if (string-match "\\*" (buffer-name buffer)) 
	      (progn
	        (setq list (cdr list))
	        (setq buffer (car list)))
		(progn
		  (set-buffer buffer)
		  (revert-buffer t t t)
		  (setq list (cdr list))
		  (setq buffer (car list))))))
  (message "Refreshing open files"))

;; ================================================================================
;; show paren mode. 괄호등을 사용할때 마지막에 사용된 괄호에 대응하는 괄호를 찾음
;; ================================================================================
(show-paren-mode 1)


(setq enable-recursive-minibuffers t)


;; ================================================================================
;; ;;indent with just spaces 들여쓰기 설정
;; ================================================================================
(setq-default indent-tabs-mode nil)   ;; nil 이 아니면 들여쓰기 명령이 탭문자를 입력한다.(버퍼지역변수)
; (setq-default indent-tabs-mode t)		;; nil 이 아니면 들여쓰기 명령이 탭문자를 입력한다.(버퍼지역변수)
; (setq tab-stop-list '(4 8 12 16 20 24 28 32 26 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))
(setq default-tab-width 2)              ;; 탭간 간격(버퍼지역변수)
;; automatically indenting yanked text if in programming-modes
;; 붙여넣기 하면서 자동 들여쓰기 함수
(defadvice yank (after indent-region activate)
  (if (member major-mode '(emacs-lisp-mode
                           c-mode c++-mode
                           tcl-mode sql-mode
                           perl-mode cperl-mode
                           java-mode jde-mode
                           LaTeX-mode TeX-mode))
	  (let ((transient-mark-mode nil))
		(indent-region (region-beginning) (region-end) nil))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "NanumGothicCoding" :foundry "nil" :slant normal :weight normal :height 141 :width normal)))))

;; http://www.emacswiki.org/emacs/CollectionOfEmacsDevelopmentEnvironmentTools
;; 6. While I was at it, I installed Exuberant Ctags using MacPorts and enabled it in CEDET::
;;
;(semantic-load-enable-primary-exuberent-ctags-support)

;(require 'semantic/ia)
;(require 'semantic/bovine/gcc)

; (load-file "/Applications/MacPorts/EmacsMac.app/Contents/Resources/lisp/cedet/cedet.elc")
;(global-ede-mode 1)                      ; Enable the Project management system
;(require 'semantic/sb)
;(semantic-mode 1)
; (semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion 
; (global-srecode-minor-mode 1)            ; Enable template insertion menu

;(setq-mode-local c-mode semanticdb-find-default-throttle
;                 '(project unloaded system recursive))


;; if you want to enable support for gnu global
;(when (cedet-gnu-global-version-check t)
;  (semanticdb-enable-gnu-global-databases 'c-mode)
;  (semanticdb-enable-gnu-global-databases 'c++-mode))

;; enable ctags for some languages:
;;  Unix Shell, Perl, Pascal, Tcl, Fortran, Asm
;(when (cedet-ectag-version-check)
;  (semantic-load-enable-primary-exuberent-ctags-support))

(add-to-list 'load-path "/Users/x/.emacs/dash-at-point")
(autoload 'dash-at-point "dash-at-point"
  "Search the word at point with Dash." t nil)
(global-set-key "\C-cd" 'dash-at-point)

;(add-to-list 'dash-at-point-mode-alist '(perl-mode . "perl"))
;(add-to-list 'dash-at-point-mode-alist '(c++-mode . "cpp"))
;(add-to-list 'dash-at-point-mode-alist '(c-mode . "c"))

;(add-hook 'rinari-minor-mode-hook
;          (lambda () (setq dash-at-point-docset "rails")))

;; like vi's %
;; By an unknown contributor

(global-set-key "%" 'match-paren)

(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
		((looking-at "\\s\)") (forward-char 1) (backward-list 1))
		(t (self-insert-command (or arg 1)))))

;; ISO 8601 Format yyyy-mm-dd, http://ergoemacs.org/emacs/elisp_datetime.html 
(defun insert-date ()
  "Insert current date yyyy-mm-dd."
  (interactive)
  (when (region-active-p)
    (delete-region (region-beginning) (region-end) )
    )
  (insert (format-time-string "%Y-%m-%d"))
  )

;; example of setting env var named “path”, by appending a new path to existing path
(setenv "PATH"
		(concat
		 "/usr/local/bin" ":"
		 "/usr/local/sbin" ":"
		 (getenv "PATH")
		 )
		)

(setq tramp-default-method "ssh")

;; for gtags

(defun gtags-root-dir ()
  "Returns GTAGS root directory or nil if doesn't exist."
  (with-temp-buffer
	(if (zerop (call-process "global" nil t nil "-pr"))
		(buffer-substring (point-min) (1- (point-max)))
	  nil)))

(defun gtags-update ()
  "Make GTAGS incremental update"
  (call-process "global" nil nil nil "-u"))

(defun gtags-update-hook ()
  (when (gtags-root-dir)
	(gtags-update)))

(add-hook 'after-save-hook #'gtags-update-hook)

(defun gtags-update-single(filename)  
  "Update Gtags database for changes in a single file"
  (interactive)
  (start-process "update-gtags" "update-gtags" "bash" "-c" (concat "cd " (gtags-root-dir) " ; gtags --single-update " filename )))

(defun gtags-update-current-file()
  (interactive)
  (defvar filename)
  (setq filename (replace-regexp-in-string (gtags-root-dir) "." (buffer-file-name (current-buffer))))
  (gtags-update-single filename)
  (message "Gtags updated for %s" filename))

;(defun gtags-update-hook()
;  "Update GTAGS file incrementally upon saving a file"
;  (when ggtags-mode
;	(when (gtags-root-dir)
;	  (gtags-update-current-file))))
;
;(add-hook 'after-save-hook 'gtags-update-hook)


(autoload 'gtags-mode "gtags" "" t)
; (autoload 'gtags-mode "gtags" "" t)

;; (add-hook 'gtags-mode-hook
;;   '(lambda ()
;;      (define-key gtags-mode-map "\C-f" 'scroll-up)
;;      (define-key gtags-mode-map "\C-b" 'scroll-down)
;; ))

(add-hook 'gtags-select-mode-hook
  '(lambda ()
     (setq hl-line-face 'underline)
     (hl-line-mode 1)
))

(setq gtags-suggested-key-mapping t)
(setq gtags-auto-update t)

;(add-hook 'c-mode-common-hook
;          (lambda ()
;            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
;              (ggtags-mode 1))))

;(add-to-list 'load-path "/Volumes/PDS/Works/GitHub/go-mode.el")
;(require 'go-mode-autoloads)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t) ; Org-mode's repository


(add-to-list 'load-path "/Volumes/PDS/Emacs/auto-complete-1.3.1")
(require 'auto-complete)
(require 'auto-complete-config)
(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)

; (add-to-list 'load-path "~/Library/Preferences/Aquamacs Emacs/Packages/elpa/go-autocomplete-20141210.1904/")
; (require 'go-autocomplete)


(add-to-list 'load-path "~/.emacs.d/lisp")
(autoload 'gtags-mode "gtags" "" t)
(add-hook 'gtags-mode-hook
  '(lambda ()
        ; Local customization (overwrite key mapping)
        (define-key gtags-mode-map "\C-f" 'scroll-up)
        (define-key gtags-mode-map "\C-b" 'scroll-down)
))
(add-hook 'gtags-select-mode-hook
  '(lambda ()
        (setq hl-line-face 'underline)
        (hl-line-mode 1)
))
(add-hook 'c-mode-hook
  '(lambda ()
        (gtags-mode 1)))
; Customization
(setq gtags-suggested-key-mapping t)
(setq gtags-auto-update t)

; (source gnu)
; (source melpa) ;;archive of VCS snapshots built automatically from upstream repositories

(require 'cask "~/.emacs.d/.cask/24.4.1/elpa/cask-20150109.621/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

(mapc 'load (directory-files "~/.emacs.d/customizations" t "^[0-9]+.*\.el$"))

