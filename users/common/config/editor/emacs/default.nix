{ pkgs, colors, ... }:

{
  programs.emacs = {
    enable  = true;
    package = pkgs.unstable.emacs;
    # extraConfig = ''
    #     ;; ------------------------- ;;
    #     ;; -- basic configuration -- ;;
    #     ;; ------------------------- ;;

    #     ;; Set garbage collection up.
    #     (setq gc-cons-threshold (* 50 1000 1000))

    #     ;; Shut the fuck up, Emacs.
    #     (setq warning-minimum-level :emergency
    #         inhibit-startup-screen t
    #         initial-scratch-message "")
    #     (scroll-bar-mode -1)
    #     (tool-bar-mode -1)
    #     (menu-bar-mode -1)
    #     (tooltip-mode -1)
    #     (set-fringe-mode 10)
    #     (set-face-attribute 'default nil :font "IBM Plex Mono" :height 90)

    #     ;; Put your garbage elsewhere, Emacs.
    #     (setq backup-directory-alist
    #         `((".*" . ,temporary-file-directory))
    #         auto-save-file-name-transforms
    #         `((".*" ,temporary-file-directory t))
    #         custom-file
    #         (concat user-emacs-directory "/custom.el"))

    #     ;; Sane defaults.
    #     (setq-default
    #         ;; Fix tabbing.
    #         indent-tabs-mode nil
    #         tab-width 4
    #         ;; Use the newest version of a file.
    #         load-prefer-newer t
    #         ;; Reserve 3 columns for line numbers.
    #         display-line-numbers-width 3)
    #     (column-number-mode 1)
    #     (global-display-line-numbers-mode t)
    #     (global-hl-line-mode t)
    #     (show-paren-mode 1)
    #     (setq font-lock-mode t)
    #     (set-window-margins (selected-window) 1 1)

    #     ;; Disable line numbers for some modes
    #     (dolist (mode '(term-mode-hook
    #                     shell-mode-hook
    #                     treemacs-mode-hook
    #                     eshell-mode-hook))
    #     (add-hook mode (lambda () (display-line-numbers-mode 0))))

    #     ;; Extra Keybindings
    #     ;; -----------------
    #     ;; Comment a line.
    #     (global-set-key (kbd "C-c c") 'comment-line)
    #     ;; Evaluate buffer (running on this file reloads config).
    #     (global-set-key (kbd "C-c r") 'eval-buffer)
    #     ;; Toggle tabline.
    #     (global-set-key (kbd "C-c t") 'global-tab-line-mode)

    #     ;; Finish garbage collection.
    #     (setq gc-cons-threshold (* 2 1000 1000))

    #     ;; -------------- ;;
    #     ;; -- Packages -- ;;
    #     ;; -------------- ;;

    #     ;; Package management
    #     ;; ------------------
    #     ;; Set up package.el to work with both ELPA and MELPA.
    #     (require 'package)
    #     (add-to-list 'package-archives
    #     '("melpa" . "https://melpa.org/packages/")
    #     '("elpa"  . "https://elpa.gnu.org/packages/"))
    #     (package-initialize)
    #     (unless package-archive-contents
    #     (package-refresh-contents))

    #     ;; Also set use-package up.
    #     (unless (package-installed-p 'use-package)
    #     (package-install 'use-package))
    #     (require 'use-package)
    #     (setq use-package-always-ensure t)

    #     ;; Utils
    #     ;; -----
    #     ;; Set `evil` up.
    #     (use-package evil
    #     :init (setq evil-want-integration t
    #                 evil-want-keybinding nil
    #                 evil-want-C-u-scroll t
    #                 evil-want-C-i-jump nil)
    #     :config
    #     (evil-mode 1)
    #     (evil-set-initial-state 'messages-buffer-mode 'normal)
    #     (evil-set-initial-state 'dashboard-mode 'normal))

    #     ;; TODO: Try to get a bearing of how to even get meow to
    #     ;;       use the default.

    #     ;; Completion engine.
    #     (use-package ivy
    #     :diminish
    #     :config
    #     (ivy-mode 1))

    #     ;; Command keybinds display.
    #     (use-package which-key
    #     :init (which-key-mode)
    #     :diminish which-key-mode
    #     :config
    #     (setq which-key-idle-delay 0.3))
    #     (use-package counsel
    #     :bind (("M-x"     . 'counsel-M-x)
    #             ("C-x C-f" . 'counsel-find-file)
    #             ("C-M-j"   . 'counsel-switch-buffer)))
    #     (use-package ivy-rich
    #     :init (ivy-rich-mode 1))

    #     ;; Languages
    #     ;; Lua
    #     (use-package lua-mode
    #     :mode "\\.lua\\'")
    #     ;; Nix
    #     (use-package nix-mode
    #     :mode "\\.nix\\'")
    #     ;; Yuck (for eww)
    #     (use-package yuck-mode
    #     :mode "\\.yuck\\'")

    #     ;; User Interface
    #     ;; --------------
    #     ;; #RRGGBB coloring.
    #     (use-package rainbow-mode
    #     :ensure t
    #     :init (rainbow-mode 1))

    #     ;; Font icons support.
    #     (use-package all-the-icons)

    #     ;; Modeline.
    #     (use-package doom-modeline
    #     :ensure t
    #     :init (doom-modeline-mode 1)
    #     :custom ((doom-modeline-height 35)))

    #     ;; Tab line.
    #     (global-tab-line-mode -1)
    #     (setq tab-line-new-button-show   nil
    #         tab-line-close-button-show nil
    #         tab-line-separator         " ")

    #     ;; File tree.
    #     (use-package neotree
    #     :ensure t
    #     :bind   (("M-n" . 'neotree-toggle))
    #     :config (setq neo-smart-open t))

    #     ;; Startup dashboard
    #     (use-package dashboard
    #     :ensure t
    #     :init (setq dashboard-center-content    t
    #                 dashboard-startup-banner    "~/.config/emacs/ascii.txt"
    #                 dashboard-banner-logo-title "μh emacs"
    #                 dashboard-set-navigator     nil
    #                 dashboard-set-init-info     t
    #                 dashboard-items             '((recents   . 5)
    #                                                 (bookmarks . 5))
    #                 dashboard-item-names        '(("Recent Files:" . "History")
    #                                                 ("Bookmarks:"    . "Bookmarked"))
    #                 dashboard-set-heading-icons t
    #                 dashboard-set-file-icons    t
    #                 dashboard-set-footer        nil)
    #     :config
    #     (dashboard-setup-startup-hook))
    #     ;; change default screen to *dashboard* and destroy *scratch*.
    #     (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
    #     (add-hook 'emacs-startup-hook
    #             (lambda () (when (get-buffer "*scratch*") (kill-buffer "*scratch*"))))

    #     ;; Colorschemes
    #     (use-package doom-themes
    #     :ensure t
    #     :config
    #     (load-theme 'ibm-carbon-gray-100 t)
    #     (setq doom-themes-enable-bold t
    #             doom-themes-enable-italic t)
    #     (doom-themes-visual-bell-config))

    # '';
  };

  home.file = {
    ".config/emacs/ibm-carbon-gray-100-theme.el" = {
      text = import ./ibm-theme.nix { }; 
    };
  };
}
