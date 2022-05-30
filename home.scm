(use-modules
  (gnu)
  (gnu home)
  (gnu packages)
  (gnu services)
  (guix gexp)
  (gnu home services)
  (gnu home services shells))

(define pkgs (map specification->package (list "bash" "neovim")))

(home-environment
  (packages pkgs)
  (services
    (list
      (service
            home-zsh-service-type
            (home-zsh-configuration))
      (simple-service 'pkgs home-profile-service-type pkgs)
      (simple-service
        'neovim
        home-files-service-type
        (list (list ".config/nvim/init.lua" (plain-file "init.lua" "require(\"tabby\").setup({})"))
              (list ".local/share/nvim/site/pack/d/start/tabby" (local-file "../tabby.nvim" #:recursive? #t)))))))
