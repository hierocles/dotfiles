{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        # https://github.com/nix-community/nur-combined/blob/master/repos/rycee/pkgs/firefox-addons/generated-firefox-addons.nix
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          onepassword-password-manager
        ];
        settings = {
          "widget.use-xdg-desktop-portal.file-picker" = 1;
          "identity.fxaccounts.enabled" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.shell.defaultBrowserCheckCount" = 1;
          "browser.startup.page" = 3; # Restore session
          "browser.tabs.inTitlebar" = 0; # Use system's titlebar
          "dom.webgpu.enabled" = true;

          # Enable HTTPS-Only Mode
          "dom.security.https_only_mode" = true;
          "dom.security.https_only_mode_ever_enabled" = true;

          # Privacy settings
          "privacy.donottrackheader.enabled" = true;
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.socialtracking.enabled" = true;
          "privacy.partition.network_state.ocsp_cache" = true;

          # Disable Pocket Integration
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          "extensions.pocket.enabled" = false;
          "extensions.pocket.api" = "";
          "extensions.pocket.oAuthConsumerKey" = "";
          "extensions.pocket.showHome" = false;
          "extensions.pocket.site" = "";
        };
        search = {
          force = true; # allows this setting to work
          engines = {
            "MyNixOS" = {
              urls = [
                {
                  template = "https://mynixos.com/search";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              iconUpdateURL = "https://mynixos.com/favicon.ico";
              definedAliases = ["@np"];
            };

            "NixOS Wiki" = {
              urls = [{template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";}];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@nw"];
            };

            "Sourcegraph NixOS" = {
              urls = [{template = "https://sourcegraph.com/search?q=context:global+fork:no+lang:nix+{searchTerms}";}];
              iconUpdateURL = "https://sourcegraph.com/favicon.png";
              definedAliases = ["@sn"];
            };

            "GitHub NixOS" = {
              urls = [{template = "https://github.com/search?q=language%3Anix+NOT+is%3Afork+{searchTerms}&type=code";}];
              iconUpdateURL = "https://github.com/favicon.ico";
              definedAliases = ["@gn"];
            };

            "DuckDuckGo" = {
              urls = [{template = "https://duckduckgo.com/?q={searchTerms}";}];
              iconUpdateURL = "https://duckduckgo.com/favicon.ico";
              # updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = ["@ddg"];
            };

            "Bing".metaData.hidden = true;
            "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
          };
        };
      };
    };
  };
}