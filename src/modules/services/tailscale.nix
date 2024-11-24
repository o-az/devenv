{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.tailscale;

  serveOpts = {
    options = {
      target = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Target for serve command (URL, file path, text content)";
      };

      port = mkOption {
        type = types.nullOr types.int;
        default = null;
        description = "Port to expose service on";
      };

      protocol = mkOption {
        type = types.enum [ "https" "http" "tcp" "tls-terminated-tcp" ];
        default = "https";
        description = "Protocol to expose service with";
      };

      path = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Path to append to base URL";
      };
    };
  };
in
{
  options = {
    services.tailscale = {
      enable = mkEnableOption "Tailscale serve service";

      serve = mkOption {
        type = types.attrsOf (types.submodule serveOpts);
        default = { };
        description = "Tailscale serve configurations";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    packages = [ pkgs.tailscale ];
    processes = mapAttrs'
      (name: serveCfg:
        nameValuePair "tailscale-serve-${name}" {
          exec = concatStringsSep " " ([
            "${pkgs.tailscale}/bin/tailscale serve"
          ]
          ++ optional (serveCfg.path != null) "--set-path=${serveCfg.path}"
          ++ optional (serveCfg.port != null) "--${serveCfg.protocol}=${toString serveCfg.port}"
          ++ optional (serveCfg.target != null) serveCfg.target);
        }
      )
      cfg.serve;
  };
}
