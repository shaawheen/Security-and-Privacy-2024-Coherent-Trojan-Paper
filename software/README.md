# devil-in-the-fpga software
This dir has the infrastructure to build all artifacts needed to boot bao configured 
in a dual-guest setup (dual-baremetal or baremetal+linux).

## Setps to use this Repo
* Issue a `nix-build` command
* Plug the SD_card
* Run ./result-8
* Power up the system, stop the u-boot and insert the command:
  *  `fatload mmc 0 0x200000 bao.img; bootm start 0x200000; bootm loados; bootm go`
* You should see Bao running a dual-guest setup (either dual-baremetal or baremetal+linux). 
