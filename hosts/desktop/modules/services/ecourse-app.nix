{ config, pkgs, lib, ... }:
let
  ecourseDataDir = "/var/lib/ecourse";
  ecourseContainerName = "ecourse-app"; 
  ecourseImageName = "ecourse:latest"; 
in

{
  config = {
    systemd.tmpfiles.rules = [
      "d ${ecourseDataDir} 0755 root root -"
    ];

    virtualisation.podman.enable = true;

    systemd.services.ecourse-container = {
      description = "eCourse application container";
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];

      script = ''
        echo "Stopping and removing any old ${ecourseContainerName} container..."
        ${pkgs.podman}/bin/podman stop ${ecourseContainerName} || true
        ${pkgs.podman}/bin/podman rm ${ecourseContainerName} || true

        echo "Starting ${ecourseContainerName} container with ${ecourseImageName}..."
        ${pkgs.podman}/bin/podman run \
          --name ${ecourseContainerName} \
          --publish 8090:8090 \
          --volume ${ecourseDataDir}:/eCourse/pb/pb_data:Z \
          --restart always \
          --detach \
          ${ecourseImageName}
      '';

      # Service configuration for Systemd:
      # - Type=oneshot: The script runs once and then Systemd considers the service "ready".
      # - RemainAfterExit=true: Systemd keeps the service marked as "active" even after the script finishes,
      #   because the container started by the script is still running detached.
      # - ExecStop: The command Systemd runs when you stop the service (e.g., `systemctl stop ecourse-container`).
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStop = "${pkgs.podman}/bin/podman stop ${ecourseContainerName}";
      };
    };
  };
}